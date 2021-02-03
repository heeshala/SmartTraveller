import 'package:flutter/material.dart';
import 'package:smart_traveller/Pages/routes.dart';
//import 'package:smart_traveller/Pages/routes.dart';
import 'package:smart_traveller/Pages/stops.dart';
import 'package:smart_traveller/Pages/data.dart';


class HomePage extends StatelessWidget{
  Widget build (BuildContext context) {
    
    
        return new Scaffold(
          appBar: new AppBar(
            title: new Text("Smart Traveller"),
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
         Navigator.pop(context);
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HomePage())
    
  );
},

      ),
      ListTile(
        title: Text('Find Bus'),
        onTap: () {
          Navigator.pop(context);
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Routes())
  );
},
      ),
    ],
  ),
  ),
    );
  }

}