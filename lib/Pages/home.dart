import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_traveller/Pages/faq.dart';
import 'package:smart_traveller/Pages/passScan.dart';

import 'package:smart_traveller/Pages/routes.dart';

import 'package:smart_traveller/Pages/stops.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:smart_traveller/provider/local_provider.dart';
import 'package:smart_traveller/widget/language_picker_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  @override
  _NewHomeState createState() => _NewHomeState();
}

class _NewHomeState extends State<HomePage> {
  

  @override
  void initState() {
    
   
    Text sample = Text('Smart Traveller',
        textScaleFactor: 1.0,
        style: GoogleFonts.pacifico(
          textStyle:
              TextStyle(color: Colors.white, letterSpacing: .5, fontSize: 20),
        ));
    Text sample2 = Text('Smart Traveller',
        textScaleFactor: 1.0,
        style: GoogleFonts.nunito(
          textStyle:
              TextStyle(color: Colors.white, letterSpacing: .5, fontSize: 20),
        ));
    super.initState();
  
   
    //
    //
  }

 

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          'Smart Traveller',
          textScaleFactor: 1.0,
          style: GoogleFonts.pacifico(
            textStyle:
                TextStyle(color: Colors.white, letterSpacing: .5, fontSize: 20),
          ),
        ),
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
      ),
      body: bodyWidget(context),
      drawer: Container(
        height: MediaQuery.of(context).size.height,
        width: 250,
        child: Drawer(
          child: Container(
            color: Color(0xff025190),
            child: ListView(
              // Important: Remove any padding from the ListView.

              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text(
                    'Smart Traveller',
                    textScaleFactor: 1.0,
                    style: GoogleFonts.pacifico(
                      textStyle: TextStyle(
                          color: Colors.lightBlue[900],
                          letterSpacing: .5,
                          fontSize: 20),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      image: DecorationImage(
                          image: AssetImage("assets/images/nav.png"),
                          fit: BoxFit.cover)),
                ),
                Theme(
                  data: ThemeData(
                    splashColor: Colors.lightBlueAccent,
                    highlightColor: Colors.blue.withOpacity(.3),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.directions_bus, color: Colors.white),
                    title: Text(
                      AppLocalizations.of(context).routes,
                      textScaleFactor: 1.0,
                      //'Routes',
                      style:
                          GoogleFonts.nunito(fontSize: 18, color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Routes()));
                    },
                  ),
                ),
                Theme(
                  data: ThemeData(
                    splashColor: Colors.lightBlueAccent,
                    highlightColor: Colors.blue.withOpacity(.3),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.location_pin, color: Colors.white),
                    title: Text(
                      AppLocalizations.of(context).busstops,
                      textScaleFactor: 1.0,
                      //'Bus Stops',
                      style:
                          GoogleFonts.nunito(fontSize: 18, color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Stops()));
                    },
                  ),
                ),
                Theme(
                  data: ThemeData(
                    splashColor: Colors.lightBlueAccent,
                    highlightColor: Colors.blue.withOpacity(.3),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.lightbulb, color: Colors.white),
                    title: Text(
                      AppLocalizations.of(context).faq,
                      textScaleFactor: 1.0,
                      //'FAQ',
                      style:
                          GoogleFonts.nunito(fontSize: 18, color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Faq()));
                    },
                  ),
                ),
                Theme(
                  data: ThemeData(
                    splashColor: Colors.lightBlueAccent,
                    highlightColor: Colors.blue.withOpacity(.3),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.credit_card_outlined,
                      color: Colors.white,
                    ),
                    title: Text(
                      AppLocalizations.of(context).mypass,
                      textScaleFactor: 1.0,
                      //'My Travel Pass',
                      style:
                          GoogleFonts.nunito(fontSize: 18, color: Colors.white),
                    ),
                    // Within the `FirstRoute` widget
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => NfcScan()));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 90),
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        height: 1.0,
                        width: 250,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                //Language
                Theme(
                  data: ThemeData(
                    splashColor: Colors.lightBlueAccent,
                    highlightColor: Colors.blue.withOpacity(.3),
                  ),

                  child: LanguagePickerWidget(),
                  // Within the `FirstRoute` widget
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bodyWidget(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              height: 250,
              width: displayWidth,
              child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/2223-01.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: Text(
                          AppLocalizations.of(context).smartest,
                          textScaleFactor: 1.0,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: ElevatedButton(
                          onPressed: () {
                            _website();
                          },
                          child: Text(
                            AppLocalizations.of(context).moreinfo,
                            textScaleFactor: 1.0,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.nunito(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            primary: Color(0xff025190),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: EdgeInsets.all(10),
              ),
            ),
          ),

          //Buttons
          SliverToBoxAdapter(
              child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //Routes
                      ClipOval(
                        child: Material(
                          color: Color(0xff025190), // Button color
                          child: InkWell(
                            splashColor: Colors.blue, // Splash color
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Routes()));
                            },
                            child: SizedBox(
                                width: 56,
                                height: 56,
                                child: Icon(Icons.directions_bus,
                                    color: Colors.white)),
                          ),
                        ),
                      ),

//Stops
                      ClipOval(
                        child: Material(
                          color: Color(0xff025190), // Button color

                          child: InkWell(
                            splashColor: Colors.blue, // Splash color

                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Stops()));
                            },

                            child: SizedBox(
                                width: 56,
                                height: 56,
                                child: Icon(Icons.location_pin,
                                    color: Colors.white)),
                          ),
                        ),
                      ),

//Email

                      ClipOval(
                        child: Material(
                          color: Color(0xff025190), // Button color

                          child: InkWell(
                            splashColor: Colors.blue, // Splash color

                            onTap: () {
                              _sendMail();
                            },

                            child: SizedBox(
                                width: 56,
                                height: 56,
                                child: Icon(Icons.email, color: Colors.white)),
                          ),
                        ),
                      ),

//SOS
                      ClipOval(
                        child: Material(
                          color: Colors.red, // Button color

                          child: InkWell(
                            splashColor: Colors.red, // Splash color

                            onTap: () {
                              _makingPhoneCall();
                            },

                            child: SizedBox(
                                width: 56,
                                height: 56,
                                child: Center(
                                    child: Text(
                                  "SOS",
                                  textScaleFactor: 1.0,
                                  style: GoogleFonts.nunito(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: .5,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
          //Important box
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  width: displayWidth,
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/b2-01.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppLocalizations.of(context).important,
                              textScaleFactor: 1.0,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunito(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context).il1,
                            textScaleFactor: 1.0,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.nunito(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w800),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              AppLocalizations.of(context).il2,
                              textScaleFactor: 1.0,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunito(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  AppLocalizations.of(context).il3,
                                  textScaleFactor: 1.0,
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.nunito(
                                      fontSize: 17,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800),
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: ' 1955',
                                      style: GoogleFonts.nunito(
                                          fontSize: 17,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          _complaint1();
                                        }),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  AppLocalizations.of(context).il4,
                                  textScaleFactor: 1.0,
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.nunito(
                                      fontSize: 17,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800),
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: ' 0112333222',
                                      style: GoogleFonts.nunito(
                                          fontSize: 17,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          _cpb();
                                        }),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    margin: EdgeInsets.all(10),
                  ),
                ),
              ],
            ),
          ),

          SliverFillRemaining(
            hasScrollBody: false,
            // fillOverscroll: true, // Set true to change overscroll behavior. Purely preference.
            child: Align(
                alignment: Alignment.bottomCenter,
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                      color: Colors.black,
                      letterSpacing: .5,
                      fontSize: 15,
                    )),
                    children: [
                      TextSpan(text: 'Made with ❤️ in 🇱🇰'),
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }

  _makingPhoneCall() async {
    const url = 'tel:119';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  _complaint1() async {
    const url = 'tel:1955';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  _cpb() async {
    const url = 'tel:0112333222';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  _website() async {
    const url = 'http://smarttraveller.lk/';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  _sendMail() async {
    final Uri _emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'contact@smarttraveller.lk',
        queryParameters: {'subject': 'Mobile Application Inquiry'});

    var url = _emailLaunchUri.toString().replaceAll("+", "%20");
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
