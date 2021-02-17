import 'dart:async';

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
static String routeName='Route';
}

Future setMapStyle(GoogleMapController controller, BuildContext context) async {
  String value = await DefaultAssetBundle.of(context)
      .loadString('assets/maps/map_style.json');
  await controller.setMapStyle(value);
}
//timer
Timer timer;

var arr=List();

class _NewMapState extends State<LiveBus> {
  GoogleMapController _controller;

  Position position;

  Widget _child;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  BitmapDescriptor pinLocationIcon;
  BitmapDescriptor busIcon;
var lat;
  var long;
 Future<Widget> reloadCurrentLocation;
    
      @override
      void initState() {
        super.initState();
        timer = Timer.periodic(Duration(milliseconds: 1000), (Timer t) => refresh());
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
          try{
          Position res = await Geolocator.getCurrentPosition(desiredAccuracy: 
          LocationAccuracy.high); 
        
          lat=res.latitude;
          long=res.longitude;
          }
          catch(Exception){
            lat=40.7128;long=74.0060;
          }          
        }
        
        populateClients();
        setCustomMapPin();
          
        return _child = mapWidget();
    }


  populateClients() async {
    FirebaseFirestore.instance.collection("routes").doc(RouteNumber.route).get().then((value){

      arr.addAll(value['order']);
      RouteNumber.routeName=value['number']+' '+value['name'];

      int val=value['order'].length;


      for(int a=0;a<value['order'].length;a++){
        FirebaseFirestore.instance.collection("stops").doc(arr[a]).get().then((value){

          initMarker(value, arr[a]);

        });
      }

      travel();

    });
  }

  //Livebus
  var buslist=List();
  void travel(){


    buslist.clear();
    FirebaseFirestore.instance.collection("bus").get().then((value){
      

      for(int a=0;a<value.docs.length;a++) {
        buslist.add(value.docs[a].id);
      }

      
      for(int b=0;b<value.docs.length;b++){
        if(value.docs[b]['route']==RouteNumber.route){
          if(value.docs[b]['status']=='active'){
            

            double latitude=double.parse(value.docs[b]['lat']);
            double longitude=double.parse(value.docs[b]['lon']);

            var markerIdVal = value.docs[b].id;
            final MarkerId markerId = MarkerId(markerIdVal);
            
            final Marker marker = Marker(
              markerId: markerId,
              position: LatLng(latitude, longitude),
              icon: busIcon,
              onTap: () {
                 
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                    ),
                    context: context,
                    builder: (BuildContext bc) {
                      return Container(
                        height: 140,
                        
                        child:
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('bus')
                              .doc(markerIdVal)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            }
                            var userDocument = snapshot.data;

                            return Column(children: [

                              Padding(
                                padding:
                                const EdgeInsets.only(top:8.0,left: 4.0, right: 4.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                                  ),
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
                                      Text((markerIdVal),
                                          style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.white,
                                          )),
                                      Row(children: [
                                        // this creates scat.length many elements inside the Column

                                        TextButton(
                                          child: Text(
                                              'Passengers '+userDocument['passengers'].toString(),
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                              )),
                                          onPressed: () {/* ... */},
                                        ),
                                        const SizedBox(width: 8),

                                        TextButton(
                                          child: Text(
                                              'Speed '+userDocument['speed'].toString().substring(0,4)+' km/h',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                              )),
                                          onPressed: () {/* ... */},
                                        ),
                                        const SizedBox(width: 8),

                                      ]),
                                    ],
                                  ),
                                ),
                              )
                            ],
                            );
                          },
                        ),
                        
                      );
                    }
                  

                );
              },
            );
            
            setState(() {
              
              markers[markerId] = marker;

            });
          }
        }
      }
      
    });
  }

  void refresh(){
    if(buslist.isNotEmpty){
      for(int m=0;m<buslist.length;m++){
        setState(() {
          markers.removeWhere((key, marker) => marker.markerId.value == buslist[m]);
        });
      }

    }

    travel();

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

        busIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 10.5),
        'assets/images/bus.png');
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
    return FutureBuilder(
                future: reloadCurrentLocation,
                builder: (context, state) {
                  if (state.connectionState == ConnectionState.active ||
                      state.connectionState == ConnectionState.waiting) {
                      return SpinKitFadingCube(
                        itemBuilder: (BuildContext context, int index) {
                          return DecoratedBox(
                               decoration: BoxDecoration(
                               color: index.isEven ? Colors.lightBlue[800] : 
                                    Color(0XFFFFFF),
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
                           LatLng(lat,long),
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
                    

                    ),
              ],
            ));
      });
}
