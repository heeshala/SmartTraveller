import 'dart:math';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelpass_recharge/pages/data.dart';
import 'package:travelpass_recharge/pages/user.dart';


class RechargeConfirmation extends StatefulWidget {
  RechargeConfirmation({Key key}) : super(key: key);
    

  @override
  _NfcScanState createState() => _NfcScanState();
}



class _NfcScanState extends State<RechargeConfirmation> {
  
 String status="Confirm Travel Pass";
 
IconData nfcIcon=Icons.cast;

TwilioFlutter twilioFlutter;

   Widget build(BuildContext context) {
    
    return MaterialApp(
      home:Scaffold(
          appBar: AppBar(
            
            title: Text(
              'SmartTraveller Recharge  ',
              style: GoogleFonts.pacifico(
                textStyle: TextStyle(
                    color: Colors.white, letterSpacing: .5, fontSize: 20),
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.blue,
            
          ),
          body: bodyWidget(),
         
        ),
      );
    
  }




 
  @override
  initState() {
     twilioFlutter = TwilioFlutter(
      accountSid: 'AC68bb37d721ea9140d400e08e5d0b29d4',
      authToken: '9a524a9bdd88aa1ad9673cdffdea675e',
      twilioNumber: '+12546556169');
    super.initState();
    
   status="Confirm Travel Pass";
  
   

 nfcIcon=Icons.cast;
    
    FlutterNfcReader.onTagDiscovered().listen((onData) {
      setState(() {
        status="Reading...";
        
      });
      
      
      
      if(Data.cardId==onData.id.toString()){
        setState(() {
        status="";
        
      });
        recharge();
      }
      else{
        
        setState(() {
        status="Confirm Travel Pass";
        
      });

      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: "Travel Pass not Matching. Try Again",
         
        );

      }
     
      
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
              padding: const EdgeInsets.only(top: 60.00),
              child: Transform.rotate(angle: 270 * pi/180,child: Icon(nfcIcon, color: Colors.blue,size: 150,)),
            ),
            


          ],
        ),
      ),
    );
  }

  double total;
void recharge() async{
  
     SharedPreferences prefs = await SharedPreferences.getInstance();
      var userId = prefs.getString('userID');
 
  
 CollectionReference users = FirebaseFirestore.instance.collection('passenger');

 total=double.parse(Data.money)+double.parse(Data.recharge);

Future<void> updateUser() {
  return users
    .doc(Data.passenger)
    .update({'credits': total})
    .then((value) => print("User Updated"))
    .catchError((error) => print("Failed to update user: $error"));
}

CollectionReference agent = FirebaseFirestore.instance.collection('agent');

 double remaining=double.parse(Data.agentBalance)-double.parse(Data.recharge);

Future<void> updateagent() {
  return agent
    .doc(userId)
    .update({'credits': remaining})
    .then((value) => print("User Updated"))
    .catchError((error) => print("Failed to update user: $error"));
}


updateUser();
updateagent();
twilioFlutter.sendSMS(
        toNumber: Data.contact, messageBody: 'Dear Valued Customer,\nYour SmartTraveller Travel Pass has been recharged Rs.'+Data.recharge+' \nYour Current balance is Rs.'+total.toString()+'.');
Data.cardId=null;
Data.money=null;
Data.recharge=null;
Data.passenger=null;
Data.agentBalance=null;
bool tapped=false;
CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: "Transaction completed successfully!",
         onConfirmBtnTap: () =>{
           tapped=true,
           Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => User(),
      ),
      (route) => false,
    ) ,
    }
        );
      await Future.delayed(const Duration(seconds: 5), (){
        if(!tapped){
Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => User(),
      ),
      (route) => false,
    );
        }

      });



  
 
      

      
  

}

void back(){
  Navigator.of(context).pop();
  status="Tap Your Travel Pass";

 nfcIcon=Icons.cast;
}


}
