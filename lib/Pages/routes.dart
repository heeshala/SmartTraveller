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
  List<String> sfav = [];
  Set<String> all = <String>{};
  SharedPreferences prefs;
  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  Widget appBarTitle = new Text(
    "Routes",
    style: GoogleFonts.pacifico(
      textStyle:
          TextStyle(color: Colors.white, letterSpacing: .5, fontSize: 20),
    ),
  );
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();
  bool _IsSearching;
  String _searchText = "";

  bool isLoaded;
  @override
  void initState() {
    isLoaded = false;
    super.initState();
    getfav();
    _IsSearching = false;
    _SearchListState();
  }

  Future<Null> getfav() async {
    prefs = await SharedPreferences.getInstance();
    sfav = prefs.getStringList('favouriteroutes');
    print("B4" + fav.toString());
    setState(() {
      if (sfav != null) {
        fav = sfav;
        print("not null");
      } else {
        fav = <String>[];
        print(fav.length);
      }

      isLoaded = true;
      print(fav);
    });
  }

  Future<Null> matchfav() async {
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

  //Searching
  _SearchListState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _IsSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _IsSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              new IconButton(
                icon: actionIcon,
                onPressed: () {
                  setState(() {
                    if (this.actionIcon.icon == Icons.search) {
                      this.actionIcon = new Icon(
                        Icons.close,
                        color: Colors.white,
                      );
                      this.appBarTitle = new TextField(
                        controller: _searchQuery,
                        style: new TextStyle(
                          color: Colors.white,
                        ),
                        decoration: new InputDecoration(
                            prefixIcon:
                                new Icon(Icons.search, color: Colors.white),
                            hintText: "Search...",
                            hintStyle: new TextStyle(color: Colors.white)),
                      );
                      _handleSearchStart();
                    } else {
                      _handleSearchEnd();
                    }
                  });
                },
              ),
            ],
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
            title: appBarTitle,
            centerTitle: true,
            flexibleSpace: Image(
              image: AssetImage('assets/images/2.png'),
              fit: BoxFit.cover,
            ),
            backgroundColor: Colors.transparent,
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
                
                _IsSearching ? favSearch() : buildfavList(),

                
              },

              //Bus-----------------------------------------
              _IsSearching ? allSearch() : buildallList(),
              
            ],
          ),
        ),
      ),
    );
  }

  Widget buildfavList() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('routes').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            List data = snapshot.data.docs;

            List item = [];

            if (fav.length > 0 && data.length > 0) {
              for (int a = 0; a < data.length; a++) {
                for (int b = 0; b < fav.length; b++) {
                  if (data[a]['number'] + " " + data[a]['name'] == fav[b]) {
                    item.add(data[a]);
                    //print(data[a]);
                    break;
                  }
                }
              }

              if (item.length > 0) {
                return ListView.builder(
                    itemCount: item.length,
                    itemBuilder: (context, index) {
                      print(item[index]['number'] + " " + item[index]['name']);

                      return Center(
                        child: Container(
                          decoration: new BoxDecoration(
                            gradient: new LinearGradient(
                              colors: [
                                Color(0xFF5ea0d3),
                                Color(0xFF60acda),
                                Color(0xFF64c1e8)
                              ],
                              begin: FractionalOffset.topLeft,
                              end: FractionalOffset.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          margin: const EdgeInsets.fromLTRB(20, 20, 20, 15),
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              textStyle: TextStyle(
                                color: Colors.white,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.blue),
                              ),
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
                              isLoaded = false;
                              Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LiveBus()))
                                  .then((value) {
                                setState(() {
                                  getfav();
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
                                          text: item[index]['number'] +
                                              " ⋮ " +
                                              item[index]['name'],
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

                    );
              } else {
                return Center(
                    child: Container(
                  child: Text("Add Favourites"),
                ));
              }
            } else {
              return Center(
                  child: Container(
                child: Text("Add Favourites"),
              ));
            }
          }
        });
  }

  Widget buildallList() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('routes').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

        return ListView(
          children: snapshot.data.docs.map<Widget>((document) {
            all.add(document['number'] + " " + document['name']);
            print(all);

            return Center(
              child: Container(
                decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                    colors: [
                      Color(0xFF5ea0d3),
                      Color(0xFF60acda),
                      Color(0xFF64c1e8)
                    ],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 15),
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    textStyle: TextStyle(
                      color: Colors.white,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.blue),
                    ),
                  ),
                  onPressed: () {
                    var id = document.id;
                    RouteNumber.route = id;
                    RouteNumber.routeName = 'Route';
                    RouteNumber.selectedRoute =
                        document['number'] + " " + document['name'];
                    matchfav();
                    isLoaded = false;
                    Navigator.push(context,
                            MaterialPageRoute(builder: (context) => LiveBus()))
                        .then((value) {
                      setState(() {
                        getfav();
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
    );
  }

  Widget favSearch() {
    if (_searchText.isEmpty) {
      print(_searchText);
      return buildfavList();
    } else {
      print(_searchText);
      print("Not Empty");
      List<String> favSlist = [];
      for (int a = 0; a < fav.length; a++) {
        String name = fav[a];
        print(fav);
        if (name.toLowerCase().contains(_searchText.toLowerCase())) {
          favSlist.add(name);
        }
      }
      return StreamBuilder(
          stream: FirebaseFirestore.instance.collection('routes').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              List data = snapshot.data.docs;

              List item = [];

              if (favSlist.length > 0 && data.length > 0) {
                for (int a = 0; a < data.length; a++) {
                  for (int b = 0; b < favSlist.length; b++) {
                    if (data[a]['number'] + " " + data[a]['name'] ==
                        favSlist[b]) {
                      item.add(data[a]);
                      //print(data[a]);
                      break;
                    }
                  }
                }

                if (item.length > 0) {
                  return ListView.builder(
                      itemCount: item.length,
                      itemBuilder: (context, index) {
                        print(
                            item[index]['number'] + " " + item[index]['name']);

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
                                var id = item[index].id;
                                RouteNumber.route = id;
                                RouteNumber.routeName = 'Route';
                                RouteNumber.selectedRoute = item[index]
                                        ['number'] +
                                    " " +
                                    item[index]['name'];
                                matchfav();
                                isLoaded = false;
                                Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LiveBus()))
                                    .then((value) {
                                  setState(() {
                                    getfav();
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
                                            text: item[index]['number'] +
                                                " ⋮ " +
                                                item[index]['name'],
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

                      );
                } else {
                  return Center(
                      child: Container(
                    child: Text("No Route Found"),
                  ));
                }
              } else {
                return Center(
                    child: Container(
                  child: Text("No Route Found"),
                ));
              }
            }
          });
    }
  }

  Widget allSearch() {
    if (_searchText.isEmpty) {
      return buildallList();
    } else {
      List<String> allSlist = [];
      List<String> allList = all.toList();
      for (int a = 0; a < allList.length; a++) {
        String name = allList[a];
        if (name.toLowerCase().contains(_searchText.toLowerCase())) {
          allSlist.add(name);
        }
      }
      return StreamBuilder(
          stream: FirebaseFirestore.instance.collection('routes').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              List data = snapshot.data.docs;

              List item = [];

              if (allSlist.length > 0 && data.length > 0) {
                for (int a = 0; a < data.length; a++) {
                  for (int b = 0; b < allSlist.length; b++) {
                    if (data[a]['number'] + " " + data[a]['name'] ==
                        allSlist[b]) {
                      item.add(data[a]);
                      //print(data[a]);
                      break;
                    }
                  }
                }

                if (item.length > 0) {
                  return ListView.builder(
                      itemCount: item.length,
                      itemBuilder: (context, index) {
                        print(
                            item[index]['number'] + " " + item[index]['name']);

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
                                var id = item[index].id;
                                RouteNumber.route = id;
                                RouteNumber.routeName = 'Route';
                                RouteNumber.selectedRoute = item[index]
                                        ['number'] +
                                    " " +
                                    item[index]['name'];
                                matchfav();
                                isLoaded = false;
                                Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LiveBus()))
                                    .then((value) {
                                  setState(() {
                                    getfav();
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
                                            text: item[index]['number'] +
                                                " ⋮ " +
                                                item[index]['name'],
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

                      );
                } else {
                  return Center(
                      child: Container(
                    child: Text("No Matching Route Found"),
                  ));
                }
              } else {
                return Center(
                    child: Container(
                  child: Text("No Matching Route Found"),
                ));
              }
            }
          });
    }
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
      print("Started Search");
    });
  }

  void _handleSearchEnd() {
    setState(() {
      print("Ended Search");
      this.actionIcon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = new Text(
        "Routes",
        style: GoogleFonts.pacifico(
          textStyle:
              TextStyle(color: Colors.white, letterSpacing: .5, fontSize: 20),
        ),
      );
      _IsSearching = false;
      _searchQuery.clear();
    });
  }
}

class ChildItem extends StatelessWidget {
  final String name;
  ChildItem(this.name);
  @override
  Widget build(BuildContext context) {
    return new ListTile(title: new Text(this.name));
  }
}
