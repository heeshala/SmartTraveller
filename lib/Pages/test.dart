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
        _settingModalBottomSheet(context,markerIdVal);
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

List customExercises = ['aaa','bbb'];

void _settingModalBottomSheet(context,String idof){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc){
          return Container(
            child:StreamBuilder(
      stream: FirebaseFirestore.instance.collection('stops').doc(idof).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return new Text("Loading");
        }
        var userDocument = snapshot.data;
        
        return Column(
  children: [
    // note the ... spread operator that enables us to add two elements 
    for (var i = 0; i<userDocument['routes'].length; i++) ...[ 
           
      Text(userDocument["routes"][i].toString()),
      Column(
        children: [
          
          // this creates scat.length many elements inside the Column
          if(userDocument['times']['$i'].length == 0) Text('n') ,
          
          for (var l = 0; l<userDocument['times']['$i'].length; l++)...[
          
          Text(userDocument["times"]['$i'][l].toString()),
          ]
        ],
      )
    ]
  ],
);//new Text(userDocument["times"]["0"][0].toString());
      }
  ),
          );
      }
    );
}

/*return ListView(
  children: [
    for (var i = 0; i<userDocument['routes'].length; i++) Text(userDocument["routes"][i].toString()),
    
    for (var i = 0; i<userDocument['times']['0'].length; i++) Text(userDocument["times"]["0"][i].toString()),
    ],
); */

/*
StreamBuilder(
      stream: FirebaseFirestore.instance.collection('stops').doc(idof).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return new Text("Loading");
        }
        var userDocument = snapshot.data;
        print(userDocument["times"][1].toString()[0]);
        
        return new Text(userDocument["times"]["0"][0].toString());
      }
  ),
*/ 

/*
StreamBuilder(
    stream: FirebaseFirestore.instance.collection('stops').doc(idof).snapshots(),
    builder: (context, snapshot){
      if(!snapshot.hasData){
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return ListView(
        children: snapshot.data.docs.map<Widget>((document) {
          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width / 1.2,
              height: MediaQuery.of(context).size.height / 6,
              child: Text("Title: " + document["times"]["0"][0].toString()),
            ),
          );
        }).toList(),
      );
    }
  ),
*/ 
/*
children: <Widget>[
    // note the ... spread operator that enables us to add two elements 
    for (var i = 0; i<userDocument['routes'].length; i++) ...[ 
      Text(userDocument["routes"][i].toString()),
      Column(
        children: <Widget>[
          // this creates scat.length many elements inside the Column
          for (var i = 0; i<userDocument['times']['0'].length; i++) 
          Text(userDocument["times"]["0"][i].toString()),
        ],
      )
    ]
  ],*/