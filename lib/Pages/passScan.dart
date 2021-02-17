import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';

import 'package:google_fonts/google_fonts.dart';


/*class TravelPass extends StatelessWidget {
 
}*/



class NfcScan extends StatefulWidget {
  NfcScan({Key key}) : super(key: key);

  @override
  _NfcScanState createState() => _NfcScanState();
}

String cardId;
String status="Tap Your Travel Pass";

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
              onPressed: () => Navigator.of(context).pop(),
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
   
    
    FlutterNfcReader.onTagDiscovered().listen((onData) {
      setState(() {
        status="Reading...";
      });
      
      
      print(onData.id);
      cardId=onData.id.toString();
      checkcard();
      
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    
    super.dispose();
  }

  Widget bodyWidget(){
    return Column(
      children: <Widget>[
        
        Text('$status'),
        Image.asset('assets/images/tapnfc.png',
                        width: 250,
                        height: 400,),
        
      ],
    );
  }

  //@override
  /*Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        
        Text('$status'),
        Image.asset('assets/images/tapnfc.png',
                        width: 250,
                        height: 400,),
        
      ],
    );
  }*/
void checkcard(){
  
  print("checking");
  String user;
  String money;
  FirebaseFirestore.instance.collection("passenger").get().then((value){
      

      for(int a=0;a<value.docs.length;a++) {
        if(cardId==value.docs[a]["rfid"]){
           print(value.docs[a]["credits"]);
           money=value.docs[a]["credits"].toString();
           break;
           
        }
        
      }

      setState(() {
        status=money;
      });
      
  });

}


}


