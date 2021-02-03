import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
              title: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text("Routes"),
                ],
              )),
          body: TabBarView(
            children: [
              StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('routes').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                  
                  return ListView(
        children: snapshot.data.docs.map<Widget>((document) {
          return Center(
            child: Container(
                        margin: const EdgeInsets.fromLTRB(20, 20, 20, 15),
                        height: 60,
                        
                        child: RaisedButton(
                            textColor: Colors.white,
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.blue),
                            ),
                            onPressed: () {
                              var id=document.id;
                              showDialog(
                                  context: context,
                                  child: new AlertDialog(
                                    title: new Text("My Super title"),
                                    content: new Text(id),
                                  ));
                            },
                            child: Align(
                                alignment: Alignment.center,
                                child: Row(children: <Widget>[
                                  Text(
                                    document['number'],
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  Icon(Icons.more_vert),
                                  Text(
                                    document['name'],
                                    style: TextStyle(fontSize: 25),
                                  )
                                ])))),
          );}
                                //
                                
                  ).toList(),);
                },
              ),

              //Train-----------------------------------------
              Icon(Icons.directions_transit),
            ],
          ),
        ),
      ),
    );
  }
}
