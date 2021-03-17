import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelpass_recharge/pages/user.dart';
import 'package:travelpass_recharge/pages/data.dart';


class Profile extends StatefulWidget {
  @override
  _NewMapState createState() => _NewMapState();
}

  class _NewMapState extends State<Profile> {
  Widget build(BuildContext context) {
    double m;
    String money;
     

    
    return MaterialApp(
        
      home: Scaffold(
          
            appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Bus Stops',style:GoogleFonts.pacifico(textStyle: TextStyle(color: Colors.white, letterSpacing: .5,fontSize: 20),),),
        centerTitle: true,
        backgroundColor: Colors.blue,leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: () => {Navigator.pop(context),
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => User())),},),

      ),
          body: Padding(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  Padding(
              padding: const EdgeInsets.only(top: 50.00),

              child:Text(
                'Profile',
                textAlign: TextAlign.center,
                style: GoogleFonts.philosopher(
                  textStyle: TextStyle(
                      color: Colors.green,
                      letterSpacing: .5,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      ),
                 
            ))),
            StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('agent')
                        .doc(Data.userId)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      var userDocument = snapshot.data;
                      m=userDocument["credits"];
                      
                     money=(m).toStringAsFixed(2);
                      return Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.00),

              child:Text(
                'Name :'+userDocument["name"],
                textAlign: TextAlign.center,
                style: GoogleFonts.philosopher(
                  textStyle: TextStyle(
                      color: Colors.blue[900],
                      letterSpacing: .5,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      ),
                 
            ))),
                 Padding(
              padding: const EdgeInsets.only(top: 50.00),

              child:Text(
                'Contact :'+userDocument["contact"],
                textAlign: TextAlign.center,
                style: GoogleFonts.philosopher(
                  textStyle: TextStyle(
                      color: Colors.blue[900],
                      letterSpacing: .5,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      ),
                 
            ))),
            Padding(
              padding: const EdgeInsets.only(top: 50.00),

              child:Text(
                'Credits : Rs.'+money,
                textAlign: TextAlign.center,
                style: GoogleFonts.philosopher(
                  textStyle: TextStyle(
                      color: Colors.blue[900],
                      letterSpacing: .5,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      ),
                 
            ))),
            ]);})
                ],
              )),
              ),
              
    
    );

  }

   
  

  
}

