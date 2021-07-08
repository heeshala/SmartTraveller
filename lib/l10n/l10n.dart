import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class L10n{
   static final all=[
     const Locale('en'),//English
     const Locale('si'),//Sinhala
     const Locale('ta'),//Tamil
     const Locale('zh'),//Chinese

   ];

   static String getLang(String code){
     switch(code){
       case 'si':
        return 'සිංහල';
       case 'ta':
         return 'தமிழ்';
      case 'zh':
        return '中文';
      case 'en':
        return 'English';
       default:
         return 'English';
        
     }
   }
}