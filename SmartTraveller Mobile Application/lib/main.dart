import 'package:flutter/material.dart';
import 'package:smart_traveller/Pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';


void main() async  {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedSplashScreen(
          duration: 1000,
          splash: Image.asset('assets/images/smartbus.png'),
          
          nextScreen: HomePage(),
          splashTransition: SplashTransition.fadeTransition,
          
          backgroundColor: Colors.blue[200],
        )
    );
  }
}
