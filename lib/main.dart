import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_traveller/Pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:smart_traveller/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_traveller/provider/local_provider.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'Pages/dataClass.dart';


void main() async  {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   SharedPreferences prefs = await SharedPreferences.getInstance();
    Data.favlang =prefs.getString('favlang');
    
   
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context)  => ChangeNotifierProvider(
    
    create:(context)=>LocaleProvider(),
    builder:(context,child){
    final provider = Provider.of<LocaleProvider>(context);
    
    
    return MaterialApp(
      locale: provider.locale,
      supportedLocales: L10n.all,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      
       localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales) {
        for (final supportedLocale in supportedLocales) {
          // The language of the device of the user is compared to every supported language.
          // If the language codes match, the supported locale with that language code is chosen.
          // This allows users using American English or British English as locales
          // to be able to use the Belgian English localisation.
          if (locale.languageCode == supportedLocale.languageCode) {
            print(supportedLocale.languageCode.toString());
            if(Data.favlang==null){
               Data.local=locale.languageCode;
               return supportedLocale;
            }
            else{
              Data.local=Data.favlang;
               locale=Locale(Data.local);
               print("Lang "+locale.toString());
             
              return locale ;
            }
            
          }
        }
        if(Data.favlang==null){
               Data.local=supportedLocales.first.toString();
               return supportedLocales.first;
            }
            else{
              Data.local=Data.favlang;
              return Locale(Data.local);
            }

        // If the language of the user isn't supported, the default locale should be used.
        
        
      },
      
      
      home: MyHomePage(),
        
    );
  }
  );
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController _controller;
 Image myImage,myImage2;
  @override
  void initState() {
    super.initState();
   myImage = Image.asset("assets/images/2223-01.png");
   myImage2 = Image.asset("assets/images/b2-01.png");
    _controller = AnimationController(vsync: this);
  }
 @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(myImage.image, context);
    precacheImage(myImage2.image, context);
    super.didChangeDependencies();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: new BoxDecoration(
              gradient: new LinearGradient(
                colors: [Color(0xFF5677ba), Color(0xFF63b6e2)],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
              ),
              
            ),
        child: Center(
          
          child: ListView(
             shrinkWrap: true,
            children: [
               Container(
            
          ),
              Lottie.asset(
                'assets/lottie/69266-work.json',
                controller: _controller,
                onLoaded: (composition) {
                  _controller
                    ..duration = composition.duration
                    ..forward().whenComplete(() {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                    
                },
              );}),
              Text('',style: GoogleFonts.pacifico(
                        textStyle: TextStyle(
                            color: Colors.lightBlue[900],
                            letterSpacing: .5,
                            fontSize: 20),
                      ),)
            ],
          ),
        ),
      ),
    );
  }
}