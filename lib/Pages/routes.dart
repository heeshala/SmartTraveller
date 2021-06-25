import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_traveller/Pages/livebus.dart';
import 'package:marquee/marquee.dart';
import 'package:search_app_bar_page/search_app_bar_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Routes extends StatefulWidget {
  @override
  _NewMapState createState() => _NewMapState();
}

class _NewMapState extends State<Routes> {
  List<String> fav = [];
  SharedPreferences prefs;

  bool isLoaded = false;
  @override
  void initState() {
    getfav();
    super.initState();
    
  }

  void getfav() async {
    prefs = await SharedPreferences.getInstance();
    fav = prefs.getStringList('favouriteroutes');
    print(fav);
    setState(() {
      isLoaded = true;
    });
  }

  void matchfav() async {
    prefs = await SharedPreferences.getInstance();
    fav = prefs.getStringList('favouriteroutes');

    for (int a = 0; a < fav.length; a++) {
      print(a.toString() + " " + fav[a]);
      print(RouteNumber.selectedRoute);
      if (fav[a] == RouteNumber.selectedRoute) {
        print("Found fav");
        RouteNumber.liked = true;
        break;
      } else {
        RouteNumber.liked = false;
      }
    }
    print(RouteNumber.liked);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.star),
                  text: "Favourites",
                ),
                Tab(
                  icon: Icon(Icons.directions_bus),
                  text: "Bus",
                ),
              ],
            ),
            title: Text(
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
            ),
          ),
          body: TabBarView(
            children: [
              //Favourites
              if (!isLoaded) ...{
                Center(child: CircularProgressIndicator())
              } else ...{
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('routes')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      List data = snapshot.data.docs;

                      List item = [];

                      for (int a = 0; a < data.length; a++) {
                        for (int b = 0; b < fav.length; b++) {
                          if (data[a]['number'] + " " + data[a]['name'] ==
                              fav[b]) {
                            item.add(data[a]);
                            print(data[a]);
                            break;
                          }
                        }
                      }

                      if (item.length > 0) {
                        return ListView.builder(
                            itemCount: item.length,
                            itemBuilder: (context, index) {
                              print(item[index]['number'] +
                                  " " +
                                  item[index]['name']);

                              return Center(
                                child: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(20, 20, 20, 15),
                                  height: 50,
                                  child: RaisedButton(
                                    textColor: Colors.white,
                                    color: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.blue),
                                    ),
                                    onPressed: () {
                                      var id = item[index].id;
                                      RouteNumber.route = id;
                                      RouteNumber.routeName = 'Route';
                                      RouteNumber.selectedRoute = item[index]
                                              ['number'] +
                                          " " +
                                          item[index]['name'];
                                      matchfav();
                                      isLoaded=false;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => LiveBus())).then((value) {
                  setState(() {
                    initState();
                  });
                });
                                    },
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Marquee(
                                                  text: item[index]['number'] +
                                                      " ⋮ " +
                                                      item[index]['name'],
                                                  style:
                                                      TextStyle(fontSize: 22),
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

                            );
                      } else {}
                    }
                  }
              
                ),
              },

                //Bus-----------------------------------------
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('routes')
                      .snapshots(),
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
                                RouteNumber.selectedRoute =
                                    document['number'] + " " + document['name'];
                                matchfav();
                                isLoaded=false;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LiveBus())).then((value) {
                  setState(() {
                         initState();                    
                  });
                });
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
              
            ],
          ),
        ),
      ),
    );
  }
}
