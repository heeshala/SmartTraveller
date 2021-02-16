import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';


class TravelPass extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              'My Travel Pass',
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
          
        ),
      ),
    );
  }
}
