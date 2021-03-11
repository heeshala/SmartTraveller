
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelpass_recharge/pages/data.dart';
import 'package:travelpass_recharge/pages/home.dart';
import 'package:travelpass_recharge/pages/recharge.dart';
import 'package:travelpass_recharge/pages/changePass.dart';
 var userId;

class User extends StatefulWidget {
  User({Key key}) : super(key: key);
    

  @override
  _NfcScanState createState() => _NfcScanState();
}



class _NfcScanState extends State<User> {
  
 String status="Tap Travel Pass";
 String balance="";
IconData nfcIcon=Icons.cast;

   Widget build(BuildContext context) {
    
    return MaterialApp(
      home:Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              'SmartTraveller Recharge ',
              style: GoogleFonts.pacifico(
                textStyle: TextStyle(
                    color: Colors.white, letterSpacing: .5, fontSize: 20),
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.blue,
            
          ),
          body: bodyWidget(),
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
                  child: Text(
                    'Smart Traveller',
                    style: GoogleFonts.pacifico(
                      textStyle: TextStyle(
                          color: Colors.lightBlue[900],
                          letterSpacing: .5,
                          fontSize: 20),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      /*image: DecorationImage(
                          image: AssetImage("assets/images/nav.png"),
                          fit: BoxFit.cover)*/),
                ),
                Theme(
                  data: ThemeData(
                    splashColor: Colors.lightBlueAccent,
                    highlightColor: Colors.blue.withOpacity(.3),
                  ),
                  child: ListTile(
                    title: Text(
                      'Change Password',
                      style: TextStyle(fontSize: 15),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ChangePass()));
                    },
                  ),
                ),
                
                
                Theme(
                  data: ThemeData(
                    splashColor: Colors.lightBlueAccent,
                    highlightColor: Colors.blue.withOpacity(.3),
                  ),
                  child: ListTile(
                    title: Text(
                      'LogOut',
                      style: TextStyle(fontSize: 15),
                    ),
                    // Within the `FirstRoute` widget
                    onTap: () async {
                      return showDialog(context: context,
      builder:(_) => AlertDialog(
        title: Text('LogOut'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Are you sure you want to logout ?'),
              
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Yes'),
            onPressed: () async{
              SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('userID');
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
            },
          ),
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
               Navigator.of(context).pop();
            },
          ),
        ],
      ),

      barrierDismissible: false);
             
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
        ),
      );
    
  }




 
  @override
  initState() {
     
    super.initState();
    
   status="Tap Travel Pass";
   
 balance="";
 nfcIcon=Icons.cast;
    
    FlutterNfcReader.onTagDiscovered().listen((onData) {
      setState(() {
        status="Reading...";
        balance="";
      });
      
      
      
      Data.cardId=onData.id.toString();
      checkcard();
      
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    
    
    super.dispose();
  }

  Widget bodyWidget(){
    
    return Center(
      child: Container(
        child: Column(
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.only(top: 50.00),

              child:Text(
                '$status',
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

              child: Text(
                '$balance',
                textAlign: TextAlign.center,
                style: GoogleFonts.philosopher(
                  textStyle: TextStyle(
                      color: Colors.teal[900],
                      letterSpacing: .5,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      ),
                 
            ))),
            
            Padding(
              padding: const EdgeInsets.only(top: 30.00),
              child: Transform.rotate(angle: 270 * pi/180,child: Icon(nfcIcon, color: Colors.blue,size: 150,)),
            ),
            


          ],
        ),
      ),
    );
  }

  
void checkcard(){
  
  
 
  
  bool found=false;
  print(found);
  FirebaseFirestore.instance.collection("passenger").get().then((value){
      
    
      
      for(int a=0;a<value.docs.length;a++) {
        if(Data.cardId==value.docs[a]["nfc"]){
           
           Data.money=value.docs[a]["credits"].toString();
           Data.passenger=value.docs[a].id;
           Data.contact=value.docs[a]["contact"].toString();
           found=true;
           break;
           
        }
        
      }
      
      if(Data.money!=null){
      double m=double.parse(Data.money);
      Data.money=(m).toStringAsFixed(2);
      }
      
      
       if(found){
         Navigator.of(context).pop();
        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Recharge()));
       }
       else{
         setState(()  {
        
        
        status="Tap Your Travel Pass";
        nfcIcon=Icons.cast;
      });
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: "Invalid Travel Pass",
         
        );
      
      
       }
      
      
  });

}

void back(){
  Navigator.of(context).pop();
  status="Tap Your Travel Pass";
 balance="";
 nfcIcon=Icons.cast;
}


}
