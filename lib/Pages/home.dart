import 'package:flutter/material.dart';
import 'package:smart_traveller/Pages/faq.dart';
import 'package:smart_traveller/Pages/passScan.dart';

import 'package:smart_traveller/Pages/routes.dart';

import 'package:smart_traveller/Pages/stops.dart';
import 'package:google_fonts/google_fonts.dart';



class HomePage extends StatelessWidget{
  Widget build (BuildContext context) {
    
    
        return new Scaffold(
          appBar: new AppBar(
            title: new Text('Smart Traveller',style:GoogleFonts.pacifico(textStyle: TextStyle(color: Colors.white, letterSpacing: .5,fontSize: 20),),),
          ),
           
      drawer: Container(
        height: 640.0,
        width: 250,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(35), bottomRight: Radius.circular(35)),
          child: Drawer(

    child: ListView(
    // Important: Remove any padding from the ListView.
    padding: EdgeInsets.zero,
    children: <Widget>[
          DrawerHeader(
            child: Text('Smart Traveller',style:GoogleFonts.pacifico(textStyle: TextStyle(color: Colors.lightBlue[900], letterSpacing: .5,fontSize: 20),),),
            

            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  image: AssetImage("assets/images/nav.png"),
                     fit: BoxFit.cover)
              
            ),
            
          ),
          
          Theme(
            data:ThemeData(
              splashColor: Colors.lightBlueAccent,
              highlightColor: Colors.blue.withOpacity(.3),
            ),
            child: ListTile(
              title: Text('Routes',style: TextStyle(fontSize: 15),),
              onTap: () {

                Navigator.pop(context);
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Routes())
  );
},
            ),
          ),
          Theme(
            data:ThemeData(
              splashColor: Colors.lightBlueAccent,
              highlightColor: Colors.blue.withOpacity(.3),
            ),
            child: ListTile(
              title: Text('Bus Stops',style: TextStyle(fontSize: 15),),
              onTap: () {
                Navigator.pop(context);
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Stops())
  );
},
            ),
          ),
Theme(
  data:ThemeData(
    splashColor: Colors.lightBlueAccent,
    highlightColor: Colors.blue.withOpacity(.3),
  ),
  child:   ListTile(



              title: Text('FAQ',style: TextStyle(fontSize: 15),),



             onTap: () {



               Navigator.pop(context);

      Navigator.push(

      context,

      MaterialPageRoute(builder: (context) => Faq())



    );

  },



            ),
),

          Theme(
            data:ThemeData(
              splashColor: Colors.lightBlueAccent,
                highlightColor: Colors.blue.withOpacity(.3),
            ),
            child: ListTile(
              title: Text('My Travel Pass',style: TextStyle(fontSize: 15),),
              // Within the `FirstRoute` widget
             onTap: () {
               Navigator.pop(context);
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => NfcScan())

  );
},

            ),
          ),


    ],
  ),
  ),
        ),
      ),
    );
  }

}