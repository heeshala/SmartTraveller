import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class Faq extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              AppLocalizations.of(context).faq,
              style: GoogleFonts.pacifico(
                textStyle: TextStyle(
                    color: Colors.white, letterSpacing: .5, fontSize: 20),
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.blue,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Container(
              child: ListView(
            children: <Widget>[
              //1
              GFAccordion(
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
                collapsedTitleBackgroundColor: Colors.blueAccent,
                expandedTitleBackgroundColor: Colors.lightBlue[300],
                contentBackgroundColor: Colors.blueGrey[50],
                textStyle: TextStyle(color: Colors.white),
              ),
              //2
              GFAccordion(
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
                expandedTitleBackgroundColor: Colors.lightBlue[300],
                contentBackgroundColor: Colors.blueGrey[50],
                textStyle: TextStyle(color: Colors.white),
              ),
              //3
              GFAccordion(
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
              ),
              //4
              GFAccordion(
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
              ),
              //5
              GFAccordion(
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
              ),
              //6
              GFAccordion(
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
              ),
              
              //7
              GFAccordion(
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
              ),
              //8
              GFAccordion(
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
              ),
              //9
              GFAccordion(
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
              ),

            ],
          )),
        ),
      ),
    );
  }
}
