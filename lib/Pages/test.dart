import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Stops extends StatefulWidget {
  @override
  _NewMapState createState() => _NewMapState();
}

Future setMapStyle(GoogleMapController controller, BuildContext context) async {
  String value = await DefaultAssetBundle.of(context)
      .loadString('assets/maps/map_style.json');
  await controller.setMapStyle(value);
}

class _NewMapState extends State<Stops> {
  GoogleMapController _controller;

  Position position;

  Widget _child;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  BitmapDescriptor pinLocationIcon;
  var lat;
  var long;
  
  Future<Widget> reloadCurrentLocation;
    
      @override
      void initState() {
        super.initState();
    
        reloadCurrentLocation = getCurrentLocation();
      }
    
      Future<Widget> getCurrentLocation() async {
         LocationPermission permission;
         
         permission = await Geolocator.checkPermission();
         if (permission == LocationPermission.deniedForever) {
           lat=40.7128;long=74.0060;
         }
    
         else if (permission == LocationPermission.denied) {
           permission = await Geolocator.requestPermission();
         if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
            lat=40.7128;long=74.0060;
            }
        }
        else {
          Position res = await Geolocator.getCurrentPosition(desiredAccuracy: 
          LocationAccuracy.high); //getCurrentPosition();
        
          lat=res.latitude;
          long=res.longitude;          
        }
        
        populateClients();
        setCustomMapPin();
          
        return _child = mapWidget();
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
    var stopname=tomb['name'];
    var markerIdVal = tombId;
    final MarkerId markerId = MarkerId(markerIdVal);
    
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(tomb['location'].latitude, tomb['location'].longitude),
      icon: pinLocationIcon,
      
      onTap: () {
        _settingModalBottomSheet(context,markerIdVal,stopname);
      },
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 10.5), 'assets/images/bus-stop.png');
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
    return FutureBuilder(
                future: reloadCurrentLocation,
                builder: (context, state) {
                  if (state.connectionState == ConnectionState.active ||
                      state.connectionState == ConnectionState.waiting) {
                      return SpinKitRipple(
                        itemBuilder: (BuildContext context, int index) {
                          return DecoratedBox(
                               decoration: BoxDecoration(
                               color: index.isEven ? Colors.grey : 
                                    Color(0xffffb838),
                               ),
                          );
                        },
                      );
                  } else {
                      return Stack(
                        children: <Widget>[
                         GoogleMap(
                           initialCameraPosition: CameraPosition(
                           target: 
                           LatLng(lat,long),//(position.latitude, 
                           //position.longitude),
                           zoom: 18,
                         ),

                         ///mapType: MapType.normal,
                         onMapCreated: (GoogleMapController 
                           controller) async{
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
                }});
  }
   
}



void _settingModalBottomSheet(context,String idof,String stopname){
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
     borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
  ),
      context: context,
      builder: (BuildContext bc){
          return Container(
            height: 250,
            
            child:new ListView(
              children: [
                
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(stopname,textAlign: TextAlign.center,style: TextStyle(fontSize: 20)),
                ),
            StreamBuilder(
      stream: FirebaseFirestore.instance.collection('stops').doc(idof).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        var userDocument = snapshot.data;
        
        
  return Column(
    children:[
      for (var i = 0; i<userDocument['routes'].length; i++) ...[
     Padding(
       padding: const EdgeInsets.only(left:4.0,right:4.0),
       child: Card(
         color: Colors.blue[600],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Icon(Icons.directions_bus_outlined,color: Colors.white,),
              ),
              Text((userDocument["routes"][i].toString()),style: TextStyle(fontSize: 25,color: Colors.white,)),


            Row(
              children: [

            // this creates scat.length many elements inside the Column
            if(userDocument['times']['$i'].length == 0) Text('n') ,

            for (var l = 0; l<userDocument['times']['$i'].length; l++)...[


                TextButton(
                  child: Text(userDocument["times"]['$i'][l].toString(),style: TextStyle(fontSize: 18,color: Colors.white,)),
                  onPressed: () { /* ... */ },
                ),
                const SizedBox(width: 8),


              ]]),
          ],
        ),
    ),
     )],
    ]);
}
        //new Text(userDocument["times"]["0"][0].toString());
      
  ),
              ],));
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


  

      /*children: [
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
  ],*/

  /*return Column(
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
) */