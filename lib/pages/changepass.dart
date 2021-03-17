import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelpass_recharge/pages/data.dart';
import 'package:travelpass_recharge/pages/user.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class ChangePass extends StatelessWidget {
  String current=Data.money; 
  TextEditingController oldPass = TextEditingController();
  TextEditingController newPass = TextEditingController();
  TextEditingController conPass = TextEditingController();
  
  Widget build(BuildContext context) {

    
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
            leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: () =>{ Navigator.pop(context),
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => User())),
            }),
          ),
          body: Padding(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  Padding(
              padding: const EdgeInsets.only(top: 30.00),

              child:Text(
                'Change Password',
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
              padding: const EdgeInsets.only(top: 40.00),
                  child:Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      obscureText: true,
                      controller: oldPass,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Old Password',
                      ),
                    ),
                  ),
                  ),
                  Padding(
              padding: const EdgeInsets.only(top: 40.00),
                  child:Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      obscureText: true,
                      controller: newPass,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'New Password',
                      ),
                    ),
                  ),
                  ),
                  Padding(
              padding: const EdgeInsets.only(top: 40.00),
                  child:Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      obscureText: true,
                      controller: conPass,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Confirm Password',
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
                          change(context);
                        },
                      )),
                  )
                ],
              )),
              ),
              
    
    );

  }

   change(BuildContext context) async{
     String old=oldPass.text,n=newPass.text,c=conPass.text;
       if(oldPass.text.length<1 || newPass.text.length<1 || conPass.text.length<1){
          showDialog(context: context,
      builder:(_) => AlertDialog(
        title: Text('Alert'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('All fields are mandatory'),
              
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
         String decrypt=EncryptString(old);
         SharedPreferences prefs = await SharedPreferences.getInstance();
      var userId = prefs.getString('userID');
       String oldPass;
      FirebaseFirestore.instance.collection("agent").get().then((value) async{
      for(int a=0;a<value.docs.length;a++) {
        if(userId==value.docs[a].id){
           
           oldPass=value.docs[a]["password"].toString();
           
           break;
           
        }
        
      }

     if(decrypt==oldPass){
        if(n==c){
          String updatePass=EncryptString(n);
          CollectionReference users = FirebaseFirestore.instance.collection('agent');
          Future<void> updateUser() {
  return users
    .doc(userId)
    .update({'password': updatePass})
    .then((value) => print("User Updated"))
    .catchError((error) => print("Failed to update user: $error"));
}
updateUser();
bool tapped=false;
CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: "Password Changed Successfully!",
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
        else{
          showDialog(context: context,
      builder:(_) => AlertDialog(
        title: Text('Alert'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('New Password & Confirmation do not match'),
              
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
     }
     else{
       showDialog(context: context,
      builder:(_) => AlertDialog(
        title: Text('Alert'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Old Password not correct'),
              
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


       });
     
     
     

     
   }
  

}}

String EncryptString( String password) {
  final plainText = password;
  
  final key = encrypt.Key.fromUtf8('b14ca5898a4e4133bbce2ea2315a1916');
  final iv = encrypt.IV.fromLength(16);

  final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.ecb));

  final encrypted = encrypter.encrypt(plainText, iv: iv);
  final decrypted = encrypter.decrypt(encrypted, iv: iv);

  
  return encrypted.base64.toString();
  
}