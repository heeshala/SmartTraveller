import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelpass_recharge/pages/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:url_launcher/url_launcher.dart';
import 'package:cool_alert/cool_alert.dart';


class Home extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
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
          body:Container(
            height: displayHeight,
          width: displayWidth,
            child: Padding(
             padding: EdgeInsets.fromLTRB(10, displayHeight*0.16, 10, 0),
              child: ListView( 
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Sign in',
                        style: TextStyle(fontSize: 20,color: Colors.blue,fontWeight:FontWeight.bold),
                      )),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User Name',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  
                  Container(
                      height: displayHeight*0.09,
                      
                      padding: EdgeInsets.fromLTRB(displayWidth*0.2, 30, displayWidth*0.2, 0),
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Colors.blue,
                        child: Text('Login' , style: TextStyle(fontSize: 20,color: Colors.white,fontWeight:FontWeight.bold),),
                        onPressed: () async {
                          auth(nameController.text, passwordController.text,
                              context);
                        },
                      )),
                  Container(
                      child: Row(
                    children: <Widget>[
                      Text('Do not have an account?'),
                      FlatButton(
                        textColor: Colors.blue,
                        child: Text(
                          'Contact',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: _makingPhoneCall,
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ))
                ],
              )),),
              ),
    );
  }
}

 _makingPhoneCall() async {
    const url = 'tel:0094770637236';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

bool found = false;

void auth(String userID, String pass, BuildContext context) async {

if(userID.length>0 && pass.length>0){

  String decrypt=EncryptString( pass);
  
  SharedPreferences prefs = await SharedPreferences.getInstance();
  FirebaseFirestore.instance.collection("agent").get().then((value) {
    for (var i = 0; i < value.docs.length; i++) {
      if (userID == value.docs[i].id) {
        found = true;
        if (decrypt == value.docs[i]["password"]) {
          prefs.setString('userID', userID);

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => User()));

          break;
        } else {
          CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: "Password Did Not Match",
         
        );
          break;
        }
      }
    }
    if (!found) {
     CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: "Incorrect UserName",
         
        );
    }
  });
}
else{
  CoolAlert.show(
          context: context,
          type: CoolAlertType.warning,
          text: "Fill all the fields",
         
        );
}
}


String EncryptString( String password) {
  final plainText = password;
  
  final key = encrypt.Key.fromUtf8('b14ca5898a4e4133bbce2ea2315a1916');
  final iv = encrypt.IV.fromLength(16);

  final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.ecb));

  final encrypted = encrypter.encrypt(plainText, iv: iv);
  final decrypted = encrypter.decrypt(encrypted, iv: iv);

  
  return encrypted.base64.toString();
  
}



