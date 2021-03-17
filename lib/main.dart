import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:travelpass_recharge/pages/data.dart';
import 'package:travelpass_recharge/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelpass_recharge/pages/user.dart';
 
Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   SharedPreferences prefs = await SharedPreferences.getInstance();
      var userId = prefs.getString('userID');
      Data.userId=userId;
      
  runApp(MaterialApp(home: userId == null ? Home() : User()));
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedSplashScreen(
          duration: 1000,
          splash: Image.asset('assets/images/smartBus.jpeg'),
          
          nextScreen: Home(),
          splashTransition: SplashTransition.fadeTransition,
          
          backgroundColor: Colors.blue[200],
        )
    );
  }
}
