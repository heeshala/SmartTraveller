import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelpass_recharge/pages/data.dart';
import 'package:travelpass_recharge/pages/rechargeConfirmation.dart';
import 'package:travelpass_recharge/pages/user.dart';

class Recharge extends StatelessWidget {
  String current=Data.money; 
  TextEditingController amountController = TextEditingController();
  
  Widget build(BuildContext context) {
    
Future<bool>_onBackPressed() {
    return showDialog(context: context,
      builder:(_) => AlertDialog(
        title: Text('Warning'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Are you sure you want to cancel the transaction ?'),
              
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Yes'),
            onPressed: () {
              Data.cardId=null;
Data.money=null;
Data.recharge=null;
Data.passenger=null;
Data.agentBalance=null;
              Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => User(),
      ),
      (route) => false,
    );
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
  }

    
    return MaterialApp(
        
      home: Scaffold(
          appBar: AppBar(
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
          body: WillPopScope(
            onWillPop: _onBackPressed,
            child:Padding(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  Padding(
              padding: const EdgeInsets.only(top: 50.00),

              child:Text(
                'Available Balance',
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
                'Rs. $current',
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
                  child:Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: amountController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Recharging Amount',
                      ),
                    ),
                  ),
                  ),
                  Padding(
              padding: const EdgeInsets.only(top: 50.00),
                  child:Container(
                      height: 50,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Colors.blue,
                        child: Text('Proceed'),
                        onPressed: () async {
                          checkCredits(context);
                        },
                      )),
                  )
                ],
              ))),
              ),
              
    
    );

  }

   
  

  Future<void> checkCredits(BuildContext context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
      var userId = prefs.getString('userID');
      print(userId);
      

    FirebaseFirestore.instance.collection("agent").get().then((value){
      for(int a=0;a<value.docs.length;a++) {
        if(userId==value.docs[a].id){
           
           Data.agentBalance=value.docs[a]["credits"].toString();
           
           break;
           
        }
        
      }
      
      
      if(double.parse(Data.agentBalance)<double.parse(amountController.text)){
        
        showDialog(context: context,
      builder:(_) => AlertDialog(
        title: Text('Insufficient Credits'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Your account balance do not have the required amount for transaction.'),
              
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),

      barrierDismissible: true);
      
      }

      else if(double.parse(amountController.text)<30){
        
        showDialog(context: context,
      builder:(_) => AlertDialog(
        title: Text('Minimum Recharge Amount'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('The minimum recharge amount is Rs.30'),
              
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),

      barrierDismissible: true);
      
      }
      else{
        Data.recharge=amountController.text;
        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => RechargeConfirmation()));
      }
    });
  }
}

