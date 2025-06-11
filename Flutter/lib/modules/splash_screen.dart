import 'dart:async';
import 'package:flutter/material.dart';
import '../../helpers/ColorsSys.dart';
import 'Login/LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'SplashScreen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, LoginScreen.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/splash_illustration.png', // place your image here
              height: 200,
            ),
            const SizedBox(height: 40),
            const Text(
              "RICE\nDETDETECTION\nSYSTEM",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'ComicSansMS', // Use a fun or round font
              ),
            ),
            const SizedBox(height: 20),
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: "THE SMART WAY TO ",
                    style: TextStyle(color: Colors.orange, fontSize: 14),
                  ),
                  TextSpan(
                    text: "DIAGNOSE\n",
                    style: TextStyle(color: Colors.green, fontSize: 14),
                  ),
                  TextSpan(
                    text: "CROP DISEASES",
                    style: TextStyle(color: Colors.green, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
