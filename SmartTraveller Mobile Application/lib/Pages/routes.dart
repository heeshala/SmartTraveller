import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_traveller/Pages/livebus.dart';
import 'package:marquee/marquee.dart';

class Routes extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.directions_bus),
                    text: "BUS",
                  ),
                  Tab(
                    icon: Icon(Icons.directions_railway),
                    text: "TRAIN",
                  ),
                ],
              ),
              title: 
                  Text(
                    "Routes",
                    style: GoogleFonts.pacifico(
                      textStyle: TextStyle(
                          color: Colors.white, letterSpacing: .5, fontSize: 20),
                    ),
                  ),
                
              centerTitle: true,
            backgroundColor: Colors.blue,
              leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),),
          body: TabBarView(
            children: [
              StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('routes').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: CircularProgressIndicator());

                  return ListView(
                    children: snapshot.data.docs.map<Widget>((document) {
                      return Center(
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(20, 20, 20, 15),
                          height: 50,
                          child: RaisedButton(
                            textColor: Colors.white,
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.blue),
                            ),
                            onPressed: () {
                              var id = document.id;
                              RouteNumber.route = id;
                              RouteNumber.routeName = 'Route';
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LiveBus()));
                            },
                            child: Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Marquee(
                                          text: document['number'] +
                                              " ⋮ " +
                                              document['name'],
                                          style: TextStyle(fontSize: 22),
                                          scrollAxis: Axis.horizontal,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          blankSpace: 20.0,
                                          velocity: 50.0,
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      );
                    }
                        //

                        ).toList(),
                  );
                },
              ),

              //Train-----------------------------------------

              Center(
                  child: Container(
                      child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Image.asset(
                      'assets/images/train.gif',
                      width: 250,
                      height: 400,
                    ),
                  ),
                  Text(
                    'Available soon',
                    style: GoogleFonts.pacifico(
                      textStyle: TextStyle(
                          color: Colors.green, letterSpacing: .5, fontSize: 20),
                    ),
                  ),
                ],
              ))),
            ],
          ),
        ),
      ),
    );
  }
}
