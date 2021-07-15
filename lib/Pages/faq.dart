import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:accordion/accordion.dart';

class Faq extends StatelessWidget {
  
  Widget build(BuildContext context) {
    final curlScale = MediaQuery.of(context).textScaleFactor;
    
    return MaterialApp(
      
        home: Scaffold(
          appBar: AppBar(
            shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(30),
      ),
    ),
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              AppLocalizations.of(context).faq,
              textScaleFactor: 1.0,
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                    color: Colors.white, letterSpacing: .5, fontSize: 25),
              ),
            ),
            centerTitle: true,
            flexibleSpace: Container(
               decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                    colors: [
                      Color(0xFF5677ba),
                      Color(0xFF63b6e2)
                    ],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
            ),
           backgroundColor: Colors.transparent,
           elevation: 0.0,
            leading: IconButton(
              icon: Icon(Icons.navigate_before, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Container(
             


              child:Container(
                
                child: Accordion(
          maxOpenSections: 1,
          headerBackgroundColor: Color(0xff025190),
          headerTextStyle:GoogleFonts.nunito(textStyle: TextStyle(
                color: Colors.white, fontSize: 17/curlScale, fontWeight: FontWeight.bold)),
          
          children: [
            AccordionSection(
                
                paddingBetweenClosedSections: 12.0,
                paddingBetweenOpenSections: 12.0,
                isOpen: false,
                headerText:  AppLocalizations.of(context).q1,
                content: Text(AppLocalizations.of(context).a1,textScaleFactor: 1.0,style: GoogleFonts.nunito(fontSize: 15)),
            ),
            AccordionSection(
                paddingBetweenClosedSections: 12.0,
                paddingBetweenOpenSections: 12.0,
                isOpen: false,
                headerText:  AppLocalizations.of(context).q2,
                content: Text(AppLocalizations.of(context).a2,textScaleFactor: 1.0,style: GoogleFonts.nunito(fontSize: 15)),
            ),
            AccordionSection(
                paddingBetweenClosedSections: 12.0,
                paddingBetweenOpenSections: 12.0,
                isOpen: false,
                headerText:  AppLocalizations.of(context).q3,
                content: Text(AppLocalizations.of(context).a3,textScaleFactor: 1.0,style: GoogleFonts.nunito(fontSize: 15)),
            ),
            AccordionSection(
                paddingBetweenClosedSections: 12.0,
                paddingBetweenOpenSections: 12.0,
                isOpen: false,
                headerText:  AppLocalizations.of(context).q4,
                content: Text(AppLocalizations.of(context).a4,textScaleFactor: 1.0,style: GoogleFonts.nunito(fontSize: 15)),
            ),
            AccordionSection(
                paddingBetweenClosedSections: 12.0,
                paddingBetweenOpenSections: 12.0,
                isOpen: false,
                headerText:  AppLocalizations.of(context).q5,
                content: Text(AppLocalizations.of(context).a5,textScaleFactor: 1.0,style: GoogleFonts.nunito(fontSize: 15)),
            ),
            AccordionSection(
                paddingBetweenClosedSections: 12.0,
                paddingBetweenOpenSections: 12.0,
                isOpen: false,
                headerText:  AppLocalizations.of(context).q6,
                content: Text(AppLocalizations.of(context).a6,textScaleFactor: 1.0,style: GoogleFonts.nunito(fontSize: 15)),
            ),
            AccordionSection(
                paddingBetweenClosedSections: 12.0,
                paddingBetweenOpenSections: 12.0,
                isOpen: false,
                headerText:  AppLocalizations.of(context).q7,
                content: Text(AppLocalizations.of(context).a7,textScaleFactor: 1.0,style: GoogleFonts.nunito(fontSize: 15)),
            ),
            AccordionSection(
                paddingBetweenClosedSections: 12.0,
                paddingBetweenOpenSections: 12.0,
                isOpen: false,
                headerText:  AppLocalizations.of(context).q8,
                content: Text(AppLocalizations.of(context).a8,textScaleFactor: 1.0,style: GoogleFonts.nunito(fontSize: 15)),
            ),
            AccordionSection(
                paddingBetweenClosedSections: 12.0,
                paddingBetweenOpenSections: 12.0,
                isOpen: false,
                headerText:  AppLocalizations.of(context).q9,
                content: Text(AppLocalizations.of(context).a9,textScaleFactor: 1.0,style: GoogleFonts.nunito(fontSize: 15)),
            ),
           
          ],
        ),
              ),
              //1
             /* Padding(
                padding: const EdgeInsets.only(top:18.0),
                child: GFAccordion(
                  
                  title: AppLocalizations.of(context).q1,
                  content:
                      AppLocalizations.of(context).a1,
                  collapsedIcon: Icon(
                    Icons.arrow_drop_down_outlined,
                    color: Colors.white,
                  ),
                  expandedIcon: Icon(
                    Icons.arrow_drop_up_outlined,
                    color: Colors.white,
                  ),
                  collapsedTitleBackgroundColor: Color(0xFF219ffc),
                  expandedTitleBackgroundColor: Colors.lightBlue[300],
                  contentBackgroundColor: Color(0xFF62dbd4),
                  textStyle: TextStyle(color: Colors.white),
                  titleBorderRadius: BorderRadius.circular(12),
                  contentBorderRadius: BorderRadius.circular(12),
                ),
              ),
              //2
              Padding(
                padding: const EdgeInsets.only(top:6.0),
                child: GFAccordion(
                  title: AppLocalizations.of(context).q2,
                  content:
                      AppLocalizations.of(context).a2,
                  collapsedIcon: Icon(
                    Icons.arrow_drop_down_outlined,
                    color: Colors.white,
                  ),
                  expandedIcon: Icon(
                    Icons.arrow_drop_up_outlined,
                    color: Colors.white,
                  ),
                  collapsedTitleBackgroundColor: Colors.blueAccent,
                  expandedTitleBackgroundColor: Color(0xFF00d7fe),
                  contentBackgroundColor: Colors.blueGrey[50],
                  textStyle: TextStyle(color: Colors.white),
                  
                  titleBorderRadius: BorderRadius.circular(12),
                  contentBorderRadius: BorderRadius.circular(12),
                ),
              ),
              //3
              Padding(
                padding: const EdgeInsets.only(top:6.0),
                child: GFAccordion(
                  title: AppLocalizations.of(context).q3,
                  content:
                      AppLocalizations.of(context).a3,
                  collapsedIcon: Icon(
                    Icons.arrow_drop_down_outlined,
                    color: Colors.white,
                  ),
                  expandedIcon: Icon(
                    Icons.arrow_drop_up_outlined,
                    color: Colors.white,
                  ),
                  collapsedTitleBackgroundColor: Colors.blueAccent,
                  expandedTitleBackgroundColor: Colors.lightBlue[300],
                  contentBackgroundColor: Colors.blueGrey[50],
                  textStyle: TextStyle(color: Colors.white),
                  titleBorderRadius: BorderRadius.circular(12),
                  contentBorderRadius: BorderRadius.circular(12),
                ),
              ),
              //4
              Padding(
                padding: const EdgeInsets.only(top:6.0),
                child: GFAccordion(
                  title: AppLocalizations.of(context).q4,
                  content:
                      AppLocalizations.of(context).a4,
                  collapsedIcon: Icon(
                    Icons.arrow_drop_down_outlined,
                    color: Colors.white,
                  ),
                  expandedIcon: Icon(
                    Icons.arrow_drop_up_outlined,
                    color: Colors.white,
                  ),
                  collapsedTitleBackgroundColor: Colors.blueAccent,
                  expandedTitleBackgroundColor: Colors.lightBlue[300],
                  contentBackgroundColor: Colors.blueGrey[50],
                  textStyle: TextStyle(color: Colors.white),
                  titleBorderRadius: BorderRadius.circular(12),
                  contentBorderRadius: BorderRadius.circular(12),
                ),
              ),
              //5
              Padding(
                padding: const EdgeInsets.only(top:6.0),
                child: GFAccordion(
                  title: AppLocalizations.of(context).q5,
                  content:
                      AppLocalizations.of(context).a5,
                  collapsedIcon: Icon(
                    Icons.arrow_drop_down_outlined,
                    color: Colors.white,
                  ),
                  expandedIcon: Icon(
                    Icons.arrow_drop_up_outlined,
                    color: Colors.white,
                  ),
                  collapsedTitleBackgroundColor: Colors.blueAccent,
                  expandedTitleBackgroundColor: Colors.lightBlue[300],
                  contentBackgroundColor: Colors.blueGrey[50],
                  textStyle: TextStyle(color: Colors.white),
                  titleBorderRadius: BorderRadius.circular(12),
                  contentBorderRadius: BorderRadius.circular(12),
                ),
              ),
              //6
              Padding(
                padding: const EdgeInsets.only(top:6.0),
                child: GFAccordion(
                  title: AppLocalizations.of(context).q6,
                  content:
                      AppLocalizations.of(context).a6,
                  collapsedIcon: Icon(
                    Icons.arrow_drop_down_outlined,
                    color: Colors.white,
                  ),
                  expandedIcon: Icon(
                    Icons.arrow_drop_up_outlined,
                    color: Colors.white,
                  ),
                  collapsedTitleBackgroundColor: Colors.blueAccent,
                  expandedTitleBackgroundColor: Colors.lightBlue[300],
                  contentBackgroundColor: Colors.blueGrey[50],
                  textStyle: TextStyle(color: Colors.white),
                  titleBorderRadius: BorderRadius.circular(12),
                  contentBorderRadius: BorderRadius.circular(12),
                ),
              ),
              
              //7
              Padding(
                padding: const EdgeInsets.only(top:6.0),
                child: GFAccordion(
                  title: AppLocalizations.of(context).q7,
                  content:
                      AppLocalizations.of(context).a7,
                  collapsedIcon: Icon(
                    Icons.arrow_drop_down_outlined,
                    color: Colors.white,
                  ),
                  expandedIcon: Icon(
                    Icons.arrow_drop_up_outlined,
                    color: Colors.white,
                  ),
                  collapsedTitleBackgroundColor: Colors.blueAccent,
                  expandedTitleBackgroundColor: Colors.lightBlue[300],
                  contentBackgroundColor: Colors.blueGrey[50],
                  textStyle: TextStyle(color: Colors.white),
                  titleBorderRadius: BorderRadius.circular(12),
                  contentBorderRadius: BorderRadius.circular(12),
                ),
              ),
              //8
              Padding(
                padding: const EdgeInsets.only(top:6.0),
                child: GFAccordion(
                  title: AppLocalizations.of(context).q8,
                  content:
                      AppLocalizations.of(context).a8,
                  collapsedIcon: Icon(
                    Icons.arrow_drop_down_outlined,
                    color: Colors.white,
                  ),
                  expandedIcon: Icon(
                    Icons.arrow_drop_up_outlined,
                    color: Colors.white,
                  ),
                  collapsedTitleBackgroundColor: Colors.blueAccent,
                  expandedTitleBackgroundColor: Colors.lightBlue[300],
                  contentBackgroundColor: Colors.blueGrey[50],
                  textStyle: TextStyle(color: Colors.white),
                  titleBorderRadius: BorderRadius.circular(12),
                  contentBorderRadius: BorderRadius.circular(12),
                ),
              ),
              //9
              Padding(
                padding: const EdgeInsets.only(top:6.0),
                child: GFAccordion(
                  title: AppLocalizations.of(context).q9,
                  content:
                      AppLocalizations.of(context).a9,
                  collapsedIcon: Icon(
                    Icons.arrow_drop_down_outlined,
                    color: Colors.white,
                  ),
                  expandedIcon: Icon(
                    Icons.arrow_drop_up_outlined,
                    color: Colors.white,
                  ),
                  collapsedTitleBackgroundColor: Colors.blueAccent,
                  expandedTitleBackgroundColor: Colors.lightBlue[300],
                  contentBackgroundColor: Colors.blueGrey[50],
                  textStyle: TextStyle(color: Colors.white),
                  titleBorderRadius: BorderRadius.circular(12),
                  contentBorderRadius: BorderRadius.circular(12),
                ),
              ),
*/
           
          ),
        ),
      
    );
  }

  
}
