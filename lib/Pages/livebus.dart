import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dataClass.dart';

class LiveBus extends StatefulWidget {
  @override
  _NewMapState createState() => _NewMapState();
}

class RouteNumber {
  static String route;
  static String routeName = 'Route';
  static String selectedRoute;
  static bool liked;
  static String enRoute;
  static String taRoute;
  static String siRoute;
  static String zhRoute;
}

Future setMapStyle(GoogleMapController controller, BuildContext context) async {
  String value = await DefaultAssetBundle.of(context)
      .loadString('assets/maps/map_style.json');
  await controller.setMapStyle(value);
}

//timer
Timer timer;

var arr = List();

class _NewMapState extends State<LiveBus> {
  GoogleMapController _controller;

  Position position;

  Widget _child;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  BitmapDescriptor pinLocationIcon;
  BitmapDescriptor busicon;
  
  var lat;
  var long;

 List<String> fav = [];
  List<String> gfav = [];

  List<String> enfav = [];
  List<String> tafav = [];
  List<String> sifav = [];
  List<String> zhfav = [];
 
  SharedPreferences prefs;

  Future<Widget> reloadCurrentLocation;

  @override
  void initState() {
    
    super.initState();
    
   timer =
        Timer.periodic(Duration(milliseconds: 500), (Timer t) => travel());
    reloadCurrentLocation = getCurrentLocation();

    print("object");
    
    
  }

  void getfav() async{
 prefs = await SharedPreferences.getInstance();
 if(Data.local=='en'){
       gfav = prefs.getStringList('enfavouriteroutes');
       
    }else if(Data.local=='si'){
       gfav = prefs.getStringList('sifavouriteroutes');
       
    }else if(Data.local=='ta'){
       gfav = prefs.getStringList('tafavouriteroutes');
       
    }else if(Data.local=='zh'){
       gfav = prefs.getStringList('zhfavouriteroutes');
       
    }
    enfav=prefs.getStringList('enfavouriteroutes');
    sifav=prefs.getStringList('sifavouriteroutes');
    tafav=prefs.getStringList('tafavouriteroutes');
    zhfav=prefs.getStringList('zhfavouriteroutes');
      
     if(gfav !=null){
        fav=gfav;
        print("not null");
      }else{
        fav= <String>[];
        enfav=<String>[];
    sifav=<String>[];
    tafav=<String>[];
    zhfav=<String>[];
        print(fav.length);
      }
     
      print(fav);
}
   
  

 
  Future<Widget> getCurrentLocation() async {
    LocationPermission permission;

    
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      lat = 6.9271;
      long = 79.8612;
    } else if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
            setState(() {
              lat = 6.9271;
              long = 79.8612;
              
            });
        
      }else{
        Position res = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        setState(() {
        lat = res.latitude;
        long = res.longitude;
        });
      }
    } else {
      try {
        Position res = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        lat = res.latitude;
        long = res.longitude;
        
      } catch (Exception) {
        lat = 6.9271;
        long = 79.8612;
      }
    }
    getfav();
   
    populateClients();
    
    setCustomMapPin();
    
    return _child = mapWidget();
  }

  populateClients() async {
    arr.clear();
    FirebaseFirestore.instance
        .collection("routes")
        .doc(RouteNumber.route)
        .get()
        .then((value) {
      arr.addAll(value['order']);
      RouteNumber.routeName = value['number'] + ' ' + value['rloc'][Data.local];
      RouteNumber.enRoute= value['number'] + ' ' + value['rloc']['en'];
      RouteNumber.siRoute= value['number'] + ' ' + value['rloc']['si'];
      RouteNumber.taRoute= value['number'] + ' ' + value['rloc']['ta'];
      RouteNumber.zhRoute= value['number'] + ' ' + value['rloc']['zh'];
      print(RouteNumber.routeName);
      int val = value['order'].length;

      for (int a = 0; a < value['order'].length; a++) {
        FirebaseFirestore.instance
            .collection("stops")
            .doc(arr[a])
            .get()
            .then((value) {
          initMarker(value, arr[a]);
        });
      }

      //travel();
      
    });
  }



  //Livebus
  var buslist = List();
 
  void travel() {
    buslist.clear();
    FirebaseFirestore.instance.collection("bus").get().then((value) {
      for (int a = 0; a < value.docs.length; a++) {
        buslist.add(value.docs[a].id);
      }

      for (int b = 0; b < value.docs.length; b++) {
        if (value.docs[b]['route'] == RouteNumber.route) {
          if (value.docs[b]['status'] == 'active') {
            double latitude = double.parse(value.docs[b]['lat']);
            double longitude = double.parse(value.docs[b]['lon']);

            var markerIdVal = value.docs[b].id;
            
            final MarkerId markerId = MarkerId(markerIdVal);
            
            
            
            final Marker marker = Marker(
              markerId: markerId,
              position: LatLng(latitude, longitude),
              icon: busicon,
              
              onTap: () {
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25.0)),
                    ),
                    context: context,
                    builder: (BuildContext bc) {
                      return Container(
                        height: 140,
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('bus')
                              .doc(markerIdVal)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            }
                            var userDocument = snapshot.data;

                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 4.0, right: 4.0),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(25.0)),
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
                                        textScaleFactor: 1.0,
                                            style: GoogleFonts.nunito(textStyle:TextStyle(fontSize: 25,color: Colors.white),)),
                                        Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                                          // this creates scat.length many elements inside the Column

                                          TextButton(
                                            child: Text(
                                                AppLocalizations.of(context).passengers +" "+
                                                    userDocument['passengers']
                                                        .toString()+'/'+userDocument['seats']
                                                        .toString(),
                                                        textScaleFactor: 1.0,
                                                style: GoogleFonts.nunito(textStyle:TextStyle(fontSize: 18,color: Colors.white),)),
                                            onPressed: () {/* ... */},
                                          ),
                                          const SizedBox(width: 8),

                                          TextButton(
                                            child: Text(
                                                AppLocalizations.of(context).speed +" "+
                                                    userDocument['speed']
                                                        .toString()
                                                        .substring(0, 4) +
                                                    ' km/h',
                                                    textScaleFactor: 1.0,
                                                style: GoogleFonts.nunito(textStyle:TextStyle(fontSize:18,color: Colors.white),)),
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
                    });
              },
            );
               
            setState(() {
              markers[markerId] = marker;
              
            });
          }else{
            if (buslist.isNotEmpty) {
      
        setState(() {
          markers.removeWhere(
              (key, marker) => marker.markerId.value == value.docs[b].id);
        });
      
    }
          }
        }
      }
    });
  }

  void refresh() {
    if (buslist.isNotEmpty) {
      for (int m = 0; m < buslist.length; m++) {
        /*setState(() {
          markers.removeWhere(
              (key, marker) => marker.markerId.value == buslist[m]);
        });*/
      }
    }

    travel();
  }

  void initMarker(tomb, tombId) {
    var stopname = tomb["sloc"][Data.local];
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

    busicon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 10.5), 'assets/images/bus.png');
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        
        title: Row(
          children: [
            Expanded(
              child:Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                   child: Text(RouteNumber.routeName,
       textScaleFactor: 1.0,
       style: GoogleFonts.nunito(
          textStyle:
              TextStyle(color: Colors.white, letterSpacing: .5, fontSize: 20),
        ),),
                ),
              ),
                     
            ),
          ],
        ),
        flexibleSpace: Container(
               decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                    colors: [
                      Color(0xFF5677ba),
                      Color(0xFF63b6e2)
                    ],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight:Radius.circular(20) ),
                ),
            ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
              icon: Icon(Icons.navigate_before, color: Colors.white),
              onPressed: () => {
                timer.cancel(),
                Navigator.of(context).pop(),
                
              }
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 2),
                child: StarButton(
                  
                  isStarred: RouteNumber.liked,
                   iconDisabledColor: Colors.white,
                  valueChanged: (_isStarred) {
                    if(_isStarred==true){
                      fav.add(RouteNumber.routeName);
                      enfav.add(RouteNumber.enRoute);
                      sifav.add(RouteNumber.siRoute);
                      tafav.add(RouteNumber.taRoute);
                      zhfav.add(RouteNumber.zhRoute);
                      prefs.setStringList('enfavouriteroutes', enfav);
                      prefs.setStringList('sifavouriteroutes', sifav);
                      prefs.setStringList('tafavouriteroutes', tafav);
                      prefs.setStringList('zhfavouriteroutes', zhfav);
                      var yourList = prefs.getStringList('zhfavouriteroutes');
                      print(yourList);
                    }else{
                       fav.remove(RouteNumber.routeName);
                       enfav.remove(RouteNumber.enRoute);
                      sifav.remove(RouteNumber.siRoute);
                      tafav.remove(RouteNumber.taRoute);
                      zhfav.remove(RouteNumber.zhRoute);
                       prefs.setStringList('enfavouriteroutes', enfav);
                       prefs.setStringList('sifavouriteroutes', sifav);
                       prefs.setStringList('tafavouriteroutes', tafav);
                       prefs.setStringList('zhfavouriteroutes', zhfav);
                       var yourList = prefs.getStringList('tafavouriteroutes');
                      print(yourList);
                      RouteNumber.liked=false;
                    }
                  },
                ),
              ),
              
            ],
        
      ),
      body: mapWidget(),
    );
  }

 @override
  void dispose() {
    timer.cancel();
    
    super.dispose();
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
                    color:
                        index.isEven ? Colors.lightBlue[800] : Color(0XFFFFFF),
                  ),
                );
              },
            );
          } else {
            return Stack(
              children: <Widget>[
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(lat, long),
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
        });
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
                  child: Text(stopname,textScaleFactor: 1.0,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(textStyle:TextStyle(fontSize:20),)),
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
                            i < userDocument['rloc'][Data.local].length;
                            i++) ...[
                          if (userDocument["rloc"][Data.local][i].toString() ==
                              RouteNumber.routeName) ...[
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
                                    Text((userDocument["rloc"][Data.local][i].toString()),textScaleFactor: 1.0,
                                        style: GoogleFonts.nunito(textStyle:TextStyle(fontSize:25,color: Colors.white),)),
                                    Row(mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                    // this creates scat.length many elements inside the Column
                                    if (userDocument['times']['$i'].length == 0)
                                    
                                      Center( child:TextButton(
                                        
                                        child: Text(
                                            AppLocalizations.of(context).noschedule,textScaleFactor: 1.0,
                                            style: GoogleFonts.nunito(textStyle:TextStyle(fontSize:18,color: Colors.white),)),
                                        onPressed: () {/* ... */},
                                      )),//add text here
                                     
                                    if(userDocument['times']['$i'].length<4)...[
                                       for (var l = 0;
                                        l < userDocument['times']['$i'].length;
                                        l++) ...[
                                      TextButton(
                                        child: Text(
                                            userDocument["times"]['$i'][l]
                                                .toString(),textScaleFactor: 1.0,
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                            )),
                                        onPressed: () {/* ... */},
                                      ),
                                      const SizedBox(width: 8),
                                    ]
                                    ]
                                    else...[
                                      for (var l = 0;
                                        l < 4;
                                        l++) ...[
                                      TextButton(
                                        child: Text(
                                            userDocument["times"]['$i'][l]
                                                .toString(),textScaleFactor: 1.0,
                                            style: GoogleFonts.nunito(textStyle:TextStyle(fontSize:18,color: Colors.white),)),
                                        onPressed: () {/* ... */},
                                      ),
                                      const SizedBox(width: 8),
                                    ]
                                    ]
                                          
                                     
                                    
                                  ]),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ]
                      ]);
                    }),
              ],
            ));
      });
}
