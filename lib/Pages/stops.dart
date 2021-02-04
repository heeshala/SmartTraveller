import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Stops extends StatefulWidget {
  @override
  _NewMapState createState() => _NewMapState();
}

class _NewMapState extends State<Stops> {
  GoogleMapController _controller;

  Position position;

  Widget _child;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  BitmapDescriptor pinLocationIcon;

  @override
  void initState() {
    _child = SpinKitRipple(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? Colors.grey : Color(0xffffb838),
          ),
        );
      },
    );
    getCurrentLocation();
    populateClients();
    setCustomMapPin();
    super.initState();
  }

  void getCurrentLocation() async {
    Position res = await getCurrentPosition();
    setState(() {
      position = res;
      _child = mapWidget();
    });
  }

  populateClients() async {
    FirebaseFirestore.instance.collection('stops').get().then((docs) {
      if (docs.docs.isNotEmpty) {
        for (int i = 0; i < docs.docs.length; ++i) {
          initMarker(docs.docs[i].data(), docs.docs[i].id);
        }
      }
    });
  }

  void initMarker(tomb, tombId) {
    var markerIdVal = tombId;
    final MarkerId markerId = MarkerId(markerIdVal);

    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(tomb['location'].latitude, tomb['location'].longitude),
      icon: pinLocationIcon,
      infoWindow: InfoWindow(title: 'Shop', snippet: tombId),
      onTap: () {
        showDialog(
            context: context,
            child: new AlertDialog(
              title: new Text("My Super title"),
              content: new Text(markerIdVal),
            ));
      },
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/images/pin.png');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Bus Stops'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: mapWidget(),
    );
  }

  Widget mapWidget() {
    return Stack(
      children: <Widget>[
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 18,
          ),

          ///mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
          },

          markers: Set<Marker>.of(markers.values),
          compassEnabled: true,
          myLocationEnabled: true,
        ),
        SizedBox(
          height: 26,
        ),
      ],
    );
  }
}
