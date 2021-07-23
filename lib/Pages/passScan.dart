

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'dart:math';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_traveller/provider/local_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nfc_manager/nfc_manager.dart';


class NfcScan extends StatefulWidget {
  NfcScan({Key key}) : super(key: key);

  @override
  _NfcScanState createState() => _NfcScanState();
}

String cardId;
String status;
String balance="";
String notCompatible="";
IconData nfcIcon=Icons.cast;

class _NfcScanState extends State<NfcScan> {
  
   Widget build(BuildContext context) {
     
    return MaterialApp(
      
      
        home: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            
            title: Text(
              AppLocalizations.of(context).mypass,textScaleFactor: 1.0,
              style: GoogleFonts.nunito(textStyle: TextStyle(color: Colors.white, letterSpacing: .5,fontSize: 25),)
              ),
            
            centerTitle: true,
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
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight:Radius.circular(20) ),
                ),
            ),
         backgroundColor: Colors.transparent,
        elevation: 0.0,
            leading: IconButton(
              icon: Icon(Icons.navigate_before, color: Colors.white),
              onPressed: () => back(),
            ),
          ),
          body: bodyWidget(),
        ),
    );
      
  }
 
  @override
  initState() {
    
     setStatus();
     WidgetsBinding.instance.addPostFrameCallback((_) async {
       setState(() {
        status=AppLocalizations.of(context).tap;
        balance="";
        
      });
      
    });
    super.initState();
   
 balance="";
 nfcIcon=Icons.cast;
   
    FlutterNfcReader.onTagDiscovered().listen((onData) {
      setState(() {
        status=AppLocalizations.of(context).tapsearch;
        balance="";
      });
      
      
      
      cardId=onData.id.toString();
      
      checkcard();
      
    });
  }

void setStatus() async{
  String result;
  bool isAvailable = await NfcManager.instance.isAvailable();
  if(!isAvailable){
     result=AppLocalizations.of(context).notCompatible;
  }else{
    result="";
  }

  setState(() {
        notCompatible=result;
        
        
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
                '$status',textScaleFactor: 1.0,
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
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
                '$balance',textScaleFactor: 1.0,
                textAlign: TextAlign.center,
                
                style: GoogleFonts.nunito(
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
           Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 50.00),

              child: Text(
                '$notCompatible',textScaleFactor: 1.0,
                textAlign: TextAlign.center,
                
                style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                      color: Colors.red,
                      letterSpacing: .5,
                      fontSize: 20,
                      
                      ),
                 
            ))),

            


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
        status=AppLocalizations.of(context).remaining;
        balance=AppLocalizations.of(context).rs+""+money;
        nfcIcon=Icons.cast_connected;
      });
       }
       else{
         setState(()  {
        
        
        status=AppLocalizations.of(context).tap;
        nfcIcon=Icons.cast;
      });
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: AppLocalizations.of(context).invalid,
          
         
        );
      
      
       }
      
      
  });

}

void back(){
  Navigator.of(context).pop();
  status=AppLocalizations.of(context).tap;
 balance="";
 nfcIcon=Icons.cast;
 
}


}


