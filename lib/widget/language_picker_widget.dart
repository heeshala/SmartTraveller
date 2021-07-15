import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_traveller/Pages/dataClass.dart';
import 'package:smart_traveller/l10n/l10n.dart';
import 'package:smart_traveller/provider/local_provider.dart';

class LanguagePickerWidget extends StatelessWidget{



  @override
  Widget build(BuildContext context){
    
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale;
    var inuse;
    if(locale==null){
      
      inuse= Locale(Data.local);
      
    }else{
      inuse=locale;
    }
    return 
    Container(
          padding: EdgeInsets.only(left:20,right: 140,top: 30),
          
          child:DropdownButtonHideUnderline(
            child:DropdownButton(
            value: inuse,   
            items: L10n.all.map(
        (inuse){

          final lang= L10n.getLang(inuse.languageCode);
         return DropdownMenuItem(
           
           child: Text(
             lang,
             textScaleFactor: 1.0,
             style: GoogleFonts.nunito(fontSize: 18),
             
           ),
           value: inuse,
           onTap: () async {
             final provider = Provider.of<LocaleProvider>(context,listen:false);
             provider.setLocale(inuse);
             Data.local=inuse.toString();
             Data.favlang=inuse.toString();
             SharedPreferences prefs = await SharedPreferences.getInstance();
             prefs.setString('favlang', Data.local);
           },
         );
        },
      ).toList(),
            onChanged:(_) {

      },
            
            elevation: 8,
            style:TextStyle(color:Colors.white, fontSize: 18),
            icon: Icon(Icons.translate),
            iconDisabledColor: Colors.red,
            iconEnabledColor: Colors.white,
            isExpanded: false,
            
            dropdownColor: Color(0xFF5677ba),
                     
            ),
          )
        );
  }
}