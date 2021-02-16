import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:getwidget/getwidget.dart';

class Faq extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              'FAQ',
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
                title: 'What is Smart Traveller ?',
                content:
                    'Smart Traveller is a new concept introduced to Sri Lanka to make public transportation more convenient and efficient',
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
                title: 'How often do bus pass by ?',
                content:
                    'Buses of a specific route arrives at a stop at 15 minutes intervals',
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
                title: 'How can I use the transportation service ?',
                content:
                    'You are required to have a travel pass which will act as your payment method',
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
                title: 'Where can I buy a travel pass ?',
                content:
                    'You can buy a travel pass from any bus station,Keels, Cargills, Arpico outlets',
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
                title: 'How to topup my travel pass ?',
                content:
                    'You can topup your travel pass from any bus station,Keels, Cargills, Arpico outlets and partnered shops',
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
                title: 'How much credit should my travel pass have ?',
                content:
                    'The minimum credit amount is Rs.30',
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
                title: 'How much credit should my travel pass have ?',
                content:
                    'The minimum credit amount is Rs.30',
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
                title: 'Will I loose my credits if my travel pass is being lost ?',
                content:
                    'No, a travel pass is issued for a NIC or Passport so the credits will be transfered to the new travel pass',
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
                title: 'Can i get a refund of my credits ?',
                content:
                    'Yes, you can get refunded your remaining credits amount by returning your travel pass to a bus station, Keels, Cargills or Arpico outlets',
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
