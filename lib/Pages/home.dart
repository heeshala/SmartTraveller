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
  Image myImage;

  @override
  void initState() {
    myImage = Image.asset("assets/images/background.png");
    super.initState();
    
    
    //
    //
  }

  @override
  void didChangeDependencies() {
    //super.didChangeDependencies();
    precacheImage(myImage.image, context);
    
    super.didChangeDependencies();
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
        flexibleSpace: Image(
          image: AssetImage('assets/images/home.png'),
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.transparent,
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
                      AppLocalizations.of(context).routes,
                      //'Routes',
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
                       AppLocalizations.of(context).busstops,
                      //'Bus Stops',
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
                       AppLocalizations.of(context).faq,
                      //'FAQ',
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
                      AppLocalizations.of(context).mypass,
                      //'My Travel Pass',
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
    return Center(
      child: Container(
          height: displayHeight,
          width: displayWidth,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.fill)),
          child: Stack(children: <Widget>[
            Positioned(
              top: displayHeight * 0.04,
              
              left: 0,
              right: 0,
              child: Text(
                'Smartest way to get ',
                textAlign: TextAlign.center,
                style: GoogleFonts.philosopher(
                  textStyle: TextStyle(
                      color: Colors.blue[900],
                      letterSpacing: .5,
                      fontSize: displayWidth * 0.07,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned(
              top: displayHeight * 0.09,
              
              left: 0,
              right: 0,
              child: Text(
                'around Sri Lanka',
                textAlign: TextAlign.center,
                style: GoogleFonts.philosopher(
                  textStyle: TextStyle(
                      color: Colors.blue[900],
                      letterSpacing: .5,
                      fontSize: displayWidth * 0.07,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned(
              top: displayHeight * 0.18,
              
              left: 0,
              right: 0,
              child: Text(
                'No more need of pennies',
                textAlign: TextAlign.center,
                style: GoogleFonts.philosopher(
                  textStyle: TextStyle(
                      color: Colors.teal[900],
                      letterSpacing: .5,
                      fontSize: displayWidth * 0.07,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Positioned(
              top: displayHeight * 0.26,
              
              left: 0,
              right: 0,
              child: Text(
                'Just TAP & GO',
                textAlign: TextAlign.center,
                style: GoogleFonts.philosopher(
                  textStyle: TextStyle(
                      color: Colors.red[800],
                      letterSpacing: .5,
                      fontSize: displayWidth * 0.07,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            //Live Tracking
            Positioned(
              top: displayHeight * 0.408,
              left: displayWidth * 0.09,
              child: ButtonTheme(
                buttonColor: Color.fromRGBO(246, 175, 73, 1),
                child: Container(
                  height: displayHeight * 0.042,
                  width: displayWidth * 0.35,
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
                              style: GoogleFonts.philosopher(
                                  textStyle: TextStyle(
                                      fontSize: displayWidth * 0.06,
                                      color: Colors.white)),
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
            Positioned(
                bottom: displayHeight * 0.18,
                right: displayWidth * 0.05,
                child: FlatButton(
                  minWidth: displayWidth * 0.17,
                  height: displayHeight * 0.2,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: _makingPhoneCall,
                  child: Text(
                    "",
                  ),
                )),

            //Mail
            Positioned(
                bottom: displayHeight * 0.05,
                right: displayWidth * 0.05,
                child: FlatButton(
                  minWidth: displayWidth * 0.17,
                  height: displayHeight * 0.10,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
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
        queryParameters: {'subject': 'Mobile Application Inquiry'});

    var url = _emailLaunchUri.toString().replaceAll("+", "%20");
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
