import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LiveBus extends StatefulWidget {

  
  @override
  _NewMapState createState() => _NewMapState();
}

class RouteNumber{
static String route;
static String routeName;
}

Future setMapStyle(GoogleMapController controller, BuildContext context) async {
  String value = await DefaultAssetBundle.of(context)
      .loadString('assets/maps/map_style.json');
  await controller.setMapStyle(value);
}

var arr=List();

class _NewMapState extends State<LiveBus> {
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

  var lat;
  var long;

  void getCurrentLocation() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      lat = 6.9271;
      long = 79.8612;
    } else if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        lat = 6.9271;
        long = 79.8612;
      }
    } else {
      Position res = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high); //getCurrentPosition();

      lat = res.latitude;
      long = res.longitude;
    }

    setState(() {
      //position = res;
      //lat=6.9271;long=79.8612;
      _child = mapWidget();
    });
  }

  populateClients() async {
    FirebaseFirestore.instance.collection("routes").doc(RouteNumber.route).get().then((value){
      print(value['order'].length);
      arr.addAll(value['order']);
      RouteNumber.routeName=value['number']+' '+value['name'];
      print(RouteNumber.routeName);
      int val=value['order'].length;
      int range=val+1;

     for(int a=0;a<value['order'].length;a++){
      FirebaseFirestore.instance.collection("stops").doc(arr[a]).get().then((value){
      
      initMarker(value, arr[a]);
      //arr.addAll(value['order']);
      //print(value[a]['name']);
    });
     }

    });
  }

  void initMarker(tomb, tombId) {
    var stopname = tomb['name'];
    var markerIdVal = tombId;
    final MarkerId markerId = MarkerId(markerIdVal);

    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(tomb['location'].latitude, tomb['location'].longitude),
      icon: pinLocationIcon,
      onTap: () {
        _settingModalBottomSheet(context, markerIdVal, stopname);
      },
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 10.5),
        'assets/images/bus-stop.png');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(RouteNumber.routeName),
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
            target:
                LatLng(lat, long), //(position.latitude, position.longitude),
            zoom: 18,
          ),

          ///mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) async {
            _controller = controller;
            await setMapStyle(controller, context);
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

void _settingModalBottomSheet(context, String idof, String stopname) {
  showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      context: context,
      builder: (BuildContext bc) {
        return Container(
            height: 170,
            child: new ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(stopname,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20)),
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('stops')
                        .doc(idof)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      var userDocument = snapshot.data;

                      return Column(children: [
                        for (var i = 0;
                            i < userDocument['routes'].length;
                            i++) ...[
                              if(userDocument["routes"][i].toString()==RouteNumber.routeName)...[
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 4.0, right: 4.0),
                            child: Card(
                              color: Colors.blue[600],
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Icon(
                                      Icons.directions_bus_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text((userDocument["routes"][i].toString()),
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                      )),
                                  Row(children: [
                                    // this creates scat.length many elements inside the Column
                                    if (userDocument['times']['$i'].length == 0)
                                      Center(child: CircularProgressIndicator()),

                                    for (var l = 0;
                                        l < userDocument['times']['$i'].length;
                                        l++) ...[
                                      TextButton(
                                        child: Text(
                                            userDocument["times"]['$i'][l]
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                            )),
                                        onPressed: () {/* ... */},
                                      ),
                                      const SizedBox(width: 8),
                                    ]
                                  ]),
                                ],
                              ),
                            ),
                          )
                        ],
                      ]]);
                    }
                    //new Text(userDocument["times"]["0"][0].toString());

                    ),
              ],
            ));
      });
}
