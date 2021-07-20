import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../provider/local_provider.dart';
import 'dataClass.dart';
import 'package:smart_traveller/provider/local_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
        print(Data.local);
        reloadCurrentLocation = getCurrentLocation();
        
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
    
    var stopname = tomb["sloc"][Data.local];
    print(stopname);
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
       extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(AppLocalizations.of(context).busstops,textScaleFactor: 1.0,style:GoogleFonts.nunito(textStyle: TextStyle(color: Colors.white, letterSpacing: .5,fontSize: 25,),),),
        centerTitle: true,
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
                  borderRadius: BorderRadius.circular(20),
                ),
            ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
              icon: Icon(Icons.navigate_before, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
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
                               color: index.isEven ?  Colors.lightBlue[800]: 
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
            height: 250,
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
                            i < userDocument["rloc"][Data.local].length;
                            i++) ...[
                              
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                            style: GoogleFonts.nunito(textStyle:TextStyle(fontSize:18,color: Colors.white),)),
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
                      ]);
                    }
                    

                    ),
              ],
            ));
      });


}
