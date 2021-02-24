import 'package:flutter/material.dart';
import 'package:smart_traveller/Pages/faq.dart';
import 'package:smart_traveller/Pages/passScan.dart';

import 'package:smart_traveller/Pages/routes.dart';

import 'package:smart_traveller/Pages/stops.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _NewHomeState createState() => _NewHomeState();
}

class _NewHomeState extends State<HomePage> {
  Image myImage;
  @override
  void initState() {
    myImage = Image.asset("assets/images/background.png");
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(myImage.image, context);
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          'Smart Traveller',
          style: GoogleFonts.pacifico(
            textStyle:
                TextStyle(color: Colors.white, letterSpacing: .5, fontSize: 20),
          ),
        ),
      ),
      body: bodyWidget(context),
      drawer: Container(
        height: 640.0,
        width: 250,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(35), bottomRight: Radius.circular(35)),
          child: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text(
                    'Smart Traveller',
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
                    title: Text(
                      'Routes',
                      style: TextStyle(fontSize: 15),
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
                    title: Text(
                      'Bus Stops',
                      style: TextStyle(fontSize: 15),
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
                    title: Text(
                      'FAQ',
                      style: TextStyle(fontSize: 15),
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
                    title: Text(
                      'My Travel Pass',
                      style: TextStyle(fontSize: 15),
                    ),
                    // Within the `FirstRoute` widget
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => NfcScan()));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bodyWidget(BuildContext context) {
    return Center(
      child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover)),
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30.00),
              child: Text(
                'Smartest way to get',
                style: GoogleFonts.philosopher(
                  textStyle: TextStyle(
                      color: Colors.blue[900],
                      letterSpacing: .5,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.00),
              child: Text(
                'around Sri Lanka',
                style: GoogleFonts.philosopher(
                  textStyle: TextStyle(
                      color: Colors.blue[900],
                      letterSpacing: .5,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.00),
              child: Text(
                'No more need of pennies',
                style: GoogleFonts.philosopher(
                  textStyle: TextStyle(
                      color: Colors.teal[900],
                      letterSpacing: .5,
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.00),
              child: Text(
                'Just TAP & GO',
                style: GoogleFonts.philosopher(
                  textStyle: TextStyle(
                      color: Colors.red[800],
                      letterSpacing: .5,
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 53.0, right: 168.0),
              child: ButtonTheme(
                buttonColor: Color.fromRGBO(246, 175, 73, 1),
                child: Container(
                  height: 20.0,
                  width: 120,
                  child: RaisedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Routes()));
                      },
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Marquee(
                              text: "Live Tracking",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                              scrollAxis: Axis.horizontal,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              blankSpace: 20.0,
                              velocity: 40.0,
                            ),
                          )
                        ],
                      )),
                ),
              ),
            ),

            //Telephone
            Padding(
                padding: const EdgeInsets.only(top: 30.00, left: 260.0),
                child: FlatButton(
                  minWidth: 63.0,
                  height: 120.0,
                  onPressed: _makingPhoneCall,
                  child: Text(
                    "",
                  ),
                )),

            //Mail
            Padding(
                padding: const EdgeInsets.only(top: 15.00, left: 265.0),
                child: FlatButton(
                  minWidth: 60.0,
                  height: 60.0,
                  onPressed: _sendMail,
                  child: Text(
                    "",
                  ),
                )),
          ])),
    );
  }

  _makingPhoneCall() async {
    const url = 'tel:0094770637236';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  _sendMail() async {
    final Uri _emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'contact@smarttraveller.com',
        queryParameters: {'subject': 'Mobile App Inquiry'});

    var url = _emailLaunchUri.toString();
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
