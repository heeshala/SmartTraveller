

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'dart:math';

import 'package:google_fonts/google_fonts.dart';





class NfcScan extends StatefulWidget {
  NfcScan({Key key}) : super(key: key);

  @override
  _NfcScanState createState() => _NfcScanState();
}

String cardId;
String status="Tap Your Travel Pass";
String balance="";
IconData nfcIcon=Icons.cast;

class _NfcScanState extends State<NfcScan> {
  
   Widget build(BuildContext context) {
     
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              'My Travel Pass',
              style: GoogleFonts.pacifico(
                textStyle: TextStyle(
                    color: Colors.white, letterSpacing: .5, fontSize: 20),
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.blue,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => back(),
            ),
          ),
          body: bodyWidget(),
        ),
      ),
    );
  }
 
  @override
  initState() {
    super.initState();
   status="Tap Your Travel Pass";
 balance="";
 nfcIcon=Icons.cast;
    
    FlutterNfcReader.onTagDiscovered().listen((onData) {
      setState(() {
        status="Reading...";
        balance="";
      });
      
      
      
      cardId=onData.id.toString();
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
              padding: const EdgeInsets.only(top: 60.00),
              child: Transform.rotate(angle: 270 * pi/180,child: Icon(nfcIcon, color: Colors.blue,size: 150,)),
            ),
            


          ],
        ),
      ),
    );
  }

  
void checkcard(){
  
  
 
  String money;
  bool found=false;
  
  FirebaseFirestore.instance.collection("passenger").get().then((value){
      

      
      for(int a=0;a<value.docs.length;a++) {
        if(cardId==value.docs[a]["nfc"]){
           
           money=value.docs[a]["credits"].toString();
           found=true;
           break;
           
        }
        
      }
      
      if(money!=null){
      double m=double.parse(money);
      money=(m).toStringAsFixed(2);
      }
      
      
       if(found){
        setState(() {
        status="Remaining Credit Amount";
        balance="Rs."+money;
        nfcIcon=Icons.cast_connected;
      });
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


