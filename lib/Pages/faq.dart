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
                colors: [Color(0xFF5677ba), Color(0xFF63b6e2)],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
              ),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight:Radius.circular(20) ),
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
          child: Container(
            child: Accordion(
              maxOpenSections: 1,
              headerBackgroundColor: Color(0xff025190),
              headerTextStyle: GoogleFonts.nunito(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 17 / curlScale,
                      fontWeight: FontWeight.bold)),
              children: [
                AccordionSection(
                  paddingBetweenClosedSections: 12.0,
                  paddingBetweenOpenSections: 12.0,
                  isOpen: false,
                  headerText: AppLocalizations.of(context).q1,
                  content: Text(AppLocalizations.of(context).a1,
                      textScaleFactor: 1.0,
                      style: GoogleFonts.nunito(fontSize: 15)),
                ),
                AccordionSection(
                  paddingBetweenClosedSections: 12.0,
                  paddingBetweenOpenSections: 12.0,
                  isOpen: false,
                  headerText: AppLocalizations.of(context).q2,
                  content: Text(AppLocalizations.of(context).a2,
                      textScaleFactor: 1.0,
                      style: GoogleFonts.nunito(fontSize: 15)),
                ),
                AccordionSection(
                  paddingBetweenClosedSections: 12.0,
                  paddingBetweenOpenSections: 12.0,
                  isOpen: false,
                  headerText: AppLocalizations.of(context).q3,
                  content: Text(AppLocalizations.of(context).a3,
                      textScaleFactor: 1.0,
                      style: GoogleFonts.nunito(fontSize: 15)),
                ),
                AccordionSection(
                  paddingBetweenClosedSections: 12.0,
                  paddingBetweenOpenSections: 12.0,
                  isOpen: false,
                  headerText: AppLocalizations.of(context).q4,
                  content: Text(AppLocalizations.of(context).a4,
                      textScaleFactor: 1.0,
                      style: GoogleFonts.nunito(fontSize: 15)),
                ),
                AccordionSection(
                  paddingBetweenClosedSections: 12.0,
                  paddingBetweenOpenSections: 12.0,
                  isOpen: false,
                  headerText: AppLocalizations.of(context).q5,
                  content: Text(AppLocalizations.of(context).a5,
                      textScaleFactor: 1.0,
                      style: GoogleFonts.nunito(fontSize: 15)),
                ),
                AccordionSection(
                  paddingBetweenClosedSections: 12.0,
                  paddingBetweenOpenSections: 12.0,
                  isOpen: false,
                  headerText: AppLocalizations.of(context).q6,
                  content: Text(AppLocalizations.of(context).a6,
                      textScaleFactor: 1.0,
                      style: GoogleFonts.nunito(fontSize: 15)),
                ),
                AccordionSection(
                  paddingBetweenClosedSections: 12.0,
                  paddingBetweenOpenSections: 12.0,
                  isOpen: false,
                  headerText: AppLocalizations.of(context).q7,
                  content: Text(AppLocalizations.of(context).a7,
                      textScaleFactor: 1.0,
                      style: GoogleFonts.nunito(fontSize: 15)),
                ),
                AccordionSection(
                  paddingBetweenClosedSections: 12.0,
                  paddingBetweenOpenSections: 12.0,
                  isOpen: false,
                  headerText: AppLocalizations.of(context).q8,
                  content: Text(AppLocalizations.of(context).a8,
                      textScaleFactor: 1.0,
                      style: GoogleFonts.nunito(fontSize: 15)),
                ),
                AccordionSection(
                  paddingBetweenClosedSections: 12.0,
                  paddingBetweenOpenSections: 12.0,
                  isOpen: false,
                  headerText: AppLocalizations.of(context).q9,
                  content: Text(AppLocalizations.of(context).a9,
                      textScaleFactor: 1.0,
                      style: GoogleFonts.nunito(fontSize: 15)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
