import 'package:flutter/material.dart';
import 'dart:async';
import 'package:lol_api/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  Color colorGrey = const Color(0xFFA09B8C);
  Color colorBlue = const Color(0xFF005A82);

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MyHomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF091428),
      ),
      child: Stack(
        children: [
          Center(
              child: Text(
            'LOL.GG',
            style: TextStyle(
                color: colorGrey,
                decoration: TextDecoration.none,
                fontFamily: 'LoLFontBold'),
          )),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 200.0, right: 150, left: 150),
              child: LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(colorGrey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
