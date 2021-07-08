import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    return DropdownButton(
      value: inuse,
      items: L10n.all.map(
        (inuse){

          final lang= L10n.getLang(inuse.languageCode);
         return DropdownMenuItem(
           child: Text(
             lang,
             style: TextStyle(fontSize: 15),
           ),
           value: inuse,
           onTap: (){
             final provider = Provider.of<LocaleProvider>(context,listen:false);
             provider.setLocale(inuse);
             Data.local=inuse.toString();
           },
         );
        },
      ).toList(),
      onChanged:(_) {

      },
    );
  }
}