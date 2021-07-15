import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smart_traveller/Pages/livebus.dart';
import 'package:marquee/marquee.dart';
import 'package:search_app_bar_page/search_app_bar_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_traveller/provider/local_provider.dart';

import 'dataClass.dart';

class Routes extends StatefulWidget {
  @override
  _NewMapState createState() => _NewMapState();
}

class _NewMapState extends State<Routes> {
  List<String> fav = [];
  List<String> sfav = [];

  List<String> enfav = [];
  List<String> tafav = [];
  List<String> sifav = [];
  List<String> zhfav = [];
  Set<String> all = <String>{};
  SharedPreferences prefs;
  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );

  
  Widget appBarTitle = new Text(
    "Routes",
    textScaleFactor: 1.0,
    style: GoogleFonts.nunito(
      textStyle:
          TextStyle(color: Colors.white, letterSpacing: .5, fontSize: 25),
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
    setapptitle();
    super.initState();
    getfav();
    _IsSearching = false;
    _SearchListState();
  }

  void setapptitle(){
    if(Data.local=='en'){
          this.appBarTitle = new Text(
        
        "Routes",textScaleFactor: 1.0,
        style: GoogleFonts.nunito(
          textStyle:
              TextStyle(color: Colors.white, letterSpacing: .5,  fontSize: 25),
        ),
      );
        }else if(Data.local=='si'){
           this.appBarTitle = new Text(
        
        "මාර්ග",textScaleFactor: 1.0,
        style: GoogleFonts.nunito(
          textStyle:
              TextStyle(color: Colors.white, letterSpacing: .5, fontSize: 25),
        ),
      );

        }else if(Data.local=='ta'){
           this.appBarTitle = new Text(
        
        "வழிகள்",textScaleFactor: 1.0,
        style: GoogleFonts.nunito(
          textStyle:
              TextStyle(color: Colors.white, letterSpacing: .5, fontSize: 25),
        ),
      );

        }else if(Data.local=='zh'){
           this.appBarTitle = new Text(
        
        "路线",textScaleFactor: 1.0,
        style: GoogleFonts.nunito(
          textStyle:
              TextStyle(color: Colors.white, letterSpacing: .5, fontSize: 25),
        ),
      );
        }
  }

  Future<Null> getfav() async {
    prefs = await SharedPreferences.getInstance();
    if(Data.local=='en'){
       sfav = prefs.getStringList('enfavouriteroutes');
       
    }else if(Data.local=='si'){
       sfav = prefs.getStringList('sifavouriteroutes');
       
    }else if(Data.local=='ta'){
       sfav = prefs.getStringList('tafavouriteroutes');
       
    }else if(Data.local=='zh'){
       sfav = prefs.getStringList('zhfavouriteroutes');
       
    }
    enfav=prefs.getStringList('enfavouriteroutes');
    sifav=prefs.getStringList('sifavouriteroutes');
    tafav=prefs.getStringList('tafavouriteroutes');
    zhfav=prefs.getStringList('zhfavouriteroutes');
    print("B4" + fav.toString());
    setState(() {
      if (sfav != null) {
        fav = sfav;
        print("not null");
      } else {
        fav = <String>[];
        enfav=<String>[];
        sifav=<String>[];
        tafav=<String>[];
        zhfav=<String>[];
        print(fav.length);
      }

      isLoaded = true;
      print(fav);
    });
  }

  Future<Null> matchfav() async {
    prefs = await SharedPreferences.getInstance();
    if(Data.local=='en'){
       fav = prefs.getStringList('enfavouriteroutes');
       
    }else if(Data.local=='si'){
       fav = prefs.getStringList('sifavouriteroutes');
       
    }else if(Data.local=='ta'){
       fav = prefs.getStringList('tafavouriteroutes');
       
    }else if(Data.local=='zh'){
       fav = prefs.getStringList('zhfavouriteroutes');
       
    }

    if(fav==null){
      fav=<String>[];
    }

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
                        autofocus: true,
                        controller: _searchQuery,
                        style: GoogleFonts.nunito(
          textStyle:
              TextStyle(color: Colors.white),
        ),
                        
                        decoration: new InputDecoration(
                            prefixIcon:
                                new Icon(Icons.search, color: Colors.white),
                            hintText: AppLocalizations.of(context).hintsearch,
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
             labelStyle: GoogleFonts.nunito(
          textStyle:
              TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),
            ),
             unselectedLabelStyle: GoogleFonts.nunito(
          textStyle:
              TextStyle(fontSize: 15),
            ),
              unselectedLabelColor: Colors.blueGrey[100],
              indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 2.0,color: Color(0xff025190)),
          insets: EdgeInsets.symmetric(horizontal:20.0)
        ),
              tabs: [
                Tab(
                  icon: Icon(Icons.star),
                  child: Text(AppLocalizations.of(context).favourites,textScaleFactor: 1.0),
                  
                ),
                Tab(
                  icon: Icon(Icons.directions_bus),
                  child: Text(AppLocalizations.of(context).busall,textScaleFactor: 1.0),
                  
                ),
              ],
            ),
            title: appBarTitle,
            centerTitle: true,
            /*flexibleSpace: Image(
              image: AssetImage('assets/images/2.png'),
              fit: BoxFit.cover,
            ),*/
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
            elevation: 0.0,
            
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(Icons.navigate_before, color: Colors.white),
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
                  if (data[a]['number'] + " " + data[a]['rloc'][Data.local] == fav[b]) {
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
                      print(item[index]['number'] + " " + item[index]['rloc'][Data.local]);

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
                              RouteNumber.routeName = AppLocalizations.of(context).route;
                              RouteNumber.selectedRoute = item[index]
                                      ['number'] +
                                  " " +
                                  item[index]['rloc'][Data.local];
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
                                  padding: const EdgeInsets.only(top: 12.0,bottom: 12.0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Marquee(
                                          text: item[index]['number'] +
                                              " ⋮ " +
                                              item[index]['rloc'][Data.local],textScaleFactor: 1.0,
                                          style: GoogleFonts.nunito(textStyle: TextStyle(fontSize: 20)),
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
                  child: Text(AppLocalizations.of(context).addfav,textScaleFactor: 1.0,style: GoogleFonts.nunito(
          textStyle:
              TextStyle(fontSize: 20),
            ),),
                ));
              }
            } else {
              return Center(
                  child: Container(
                child: Text(AppLocalizations.of(context).addfav,textScaleFactor: 1.0,style: GoogleFonts.nunito(
          textStyle:
              TextStyle(fontSize: 20),
            ),),
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
            all.add(document['number'] + " " + document['rloc'][Data.local]);
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
                    RouteNumber.routeName = AppLocalizations.of(context).route;
                    RouteNumber.selectedRoute =
                        document['number'] + " " + document['rloc'][Data.local];
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
                        padding: const EdgeInsets.only(top: 12.0,bottom: 12.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Marquee(
                                text: document['number'] +
                                    " ⋮ " +
                                    document['rloc'][Data.local],textScaleFactor: 1.0,
                                style: GoogleFonts.nunito(textStyle: TextStyle(fontSize: 20)),
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
                    if (data[a]['number'] + " " + data[a]['rloc'][Data.local] ==
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
                                RouteNumber.routeName = AppLocalizations.of(context).route;
                                RouteNumber.selectedRoute = item[index]
                                        ['number'] +
                                    " " +
                                    item[index]['rloc'][Data.local];
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
                                                item[index]['rloc'][Data.local],textScaleFactor: 1.0,
                                           style: GoogleFonts.nunito(textStyle: TextStyle(fontSize: 20)),
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
                    child: Text(AppLocalizations.of(context).noresult,textScaleFactor: 1.0,style: GoogleFonts.nunito(
          textStyle:
              TextStyle(fontSize: 20),
            ),)
                  ));
                }
              } else {
                return Center(
                    child: Container(
                  child: Text(AppLocalizations.of(context).noresult,textScaleFactor: 1.0,style: GoogleFonts.nunito(
          textStyle:
              TextStyle(fontSize: 20),
            ),)
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
                    if (data[a]['number'] + " " + data[a]['rloc'][Data.local] ==
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
                            item[index]['number'] + " " + item[index]['rloc'][Data.local]);

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
                                RouteNumber.routeName = AppLocalizations.of(context).route;
                                RouteNumber.selectedRoute = item[index]
                                        ['number'] +
                                    " " +
                                    item[index]['rloc'][Data.local];
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
                                    padding: const EdgeInsets.only(top: 12.0,bottom: 12.0),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Marquee(
                                            text: item[index]['number'] +
                                                " ⋮ " +
                                                item[index]['rloc'][Data.local],textScaleFactor: 1.0,
                                            style: GoogleFonts.nunito(textStyle: TextStyle(fontSize: 20)),
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
                        
                    child: Text(AppLocalizations.of(context).noresult,textScaleFactor: 1.0,style: GoogleFonts.nunito(
          textStyle:
              TextStyle(fontSize: 20),
            ),),
                  ));
                }
              } else {
                return Center(
                    child: Container(
                  child: Text(AppLocalizations.of(context).noresult,textScaleFactor: 1.0,style: GoogleFonts.nunito(
          textStyle:
              TextStyle(fontSize: 20),
            ),),
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
      if(Data.local=='en'){
          this.appBarTitle = new Text(
        
        "Routes",textScaleFactor: 1.0,
        style: GoogleFonts.nunito(
          textStyle:
              TextStyle(color: Colors.white, letterSpacing: .5, fontSize: 25),
        ),
      );
        }else if(Data.local=='si'){
           this.appBarTitle = new Text(
        
        "මාර්ග",textScaleFactor: 1.0,
        style: GoogleFonts.nunito(
          textStyle:
              TextStyle(color: Colors.white, letterSpacing: .5, fontSize: 25),
        ),
      );

        }else if(Data.local=='ta'){
           this.appBarTitle = new Text(
        
        "வழிகள்",textScaleFactor: 1.0,
        style: GoogleFonts.nunito(
          textStyle:
              TextStyle(color: Colors.white, letterSpacing: .5, fontSize: 25),
        ),
      );

        }else if(Data.local=='zh'){
           this.appBarTitle = new Text(
        
        "路线",textScaleFactor: 1.0,
        style: GoogleFonts.nunito(
          textStyle:
              TextStyle(color: Colors.white, letterSpacing: .5, fontSize: 25),
        ),
      );

        }
      
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
    return new ListTile(title: new Text(this.name,textScaleFactor: 1.0,));
  }
}
