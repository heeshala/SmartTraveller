import 'package:flutter/material.dart';


import 'package:cloud_firestore/cloud_firestore.dart';

List<String> intArr = ['1','2','3','4','5'];
 
class Data extends StatelessWidget {
  Widget build (BuildContext context) {
    
    
        return new Scaffold(
          appBar: new AppBar(
            title: new Text("Data"),
          ), 
      drawer: Drawer(
    child: ListView(
    // Important: Remove any padding from the ListView.
    padding: EdgeInsets.zero,
    children: <Widget>[
      DrawerHeader(
        child: Text('Drawer Header'),
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
      ),
      ListTile(
        title: Text('Home'),
        // Within the `FirstRoute` widget
       onTap: () {
         _onPressed();
},

      ),
      ListTile(
        title: Text('Bus Routes'),
        onTap: () {
          
},
      ),
      ListTile(
        title: Text('Bus Stops'),
        onTap: () {
         
},
      ),
    ],
  ),
  ),
    );
  }
}

var arr=List();
void _onPressed() {
    
    FirebaseFirestore.instance.collection("routes").doc('1').get().then((value){
      print(value['order'].length);
      arr.addAll(value['order']);
      print(arr);

     for(int a=1;a<=value['order'].length;a++){
      FirebaseFirestore.instance.collection("stops").doc(arr[1]).get().then((value){
      print(value['name']);
      
      //arr.addAll(value['order']);
      //print(arr[3]);
    });
     }

    });


    
  }
