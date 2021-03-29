import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Align(
          alignment: Alignment.center ,
                  child: RichText(text: TextSpan(text:'ChiT',style: GoogleFonts.raleway(
            color: Colors.cyan,fontWeight: FontWeight.bold,fontSize: 65),
          children: <TextSpan>[
            TextSpan(
              text:'cHat',
              style: GoogleFonts.raleway(color: Colors.amber,fontWeight: FontWeight.bold,fontSize: 80),
            ),
            TextSpan(
              text:'  Messenger',
              style: GoogleFonts.raleway(color: Colors.black54,fontSize: 40),      
            )
          ]
          ),textAlign: TextAlign.center
          ),
        ),
      ),
    );
  }
}