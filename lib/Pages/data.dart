import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';



class Data extends StatelessWidget {
  
  Widget build(BuildContext context){
    return new Scaffold(
      
      appBar:new AppBar(
        title: new Text('Datas'),
      ),
      body: StreamBuilder(
    stream: FirebaseFirestore.instance.collection('stops').snapshots(),
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
              child: Text("Title: " + document['name']),
            ),
          );
        }).toList(),
      );
    }
  ),
    );
  }
}