import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_traveller/Pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:smart_traveller/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_traveller/provider/local_provider.dart';
import 'package:provider/provider.dart';

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
      
      
      home: AnimatedSplashScreen(
          duration: 1000,
          splash: Image.asset('assets/images/smartbus.png'),
          
          nextScreen: HomePage(),
          splashTransition: SplashTransition.fadeTransition,
          
          backgroundColor: Colors.blue[200],
        ),
        
    );
  }
  );
}
