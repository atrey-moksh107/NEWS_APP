import 'dart:async';

import 'package:api_project/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;

    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/32.png',
            fit:  BoxFit.cover,

            height: height * .5,
            ),
            SizedBox(height: height * 0.04,),
            Text('TOP HEADLINES', style: GoogleFonts.anton(letterSpacing: .6, color: Colors.grey.shade700),),
            SizedBox(height: height * 0.04,),
            SpinKitChasingDots(
              color: Colors.blueGrey,
              size: 40,
            )
          ],
        ),
      ),
    );
  }
}
