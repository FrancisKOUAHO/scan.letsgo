import 'dart:async';

import 'package:flutter/material.dart';

import '../../database/db_provider.dart';
import '../home/home_screen.dart';
import 'intro_screen_default.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final DatabaseProvider? db = DatabaseProvider();
  dynamic _token = '';

  @override
  void initState() {
    _token = db!.getToken().then((value) => _token = value);
    navigate();
    super.initState();
  }

  void navigate() {
    Future.delayed(const Duration(seconds: 3), () {
      if (_token != '') {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const IntroScreenDefault()),
                (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffedf3fa),
        body: Stack(
          children: <Widget>[
            Center(
              child: AnimatedContainer(
                duration: const Duration(seconds: 2),
                width: 100,
                height: 100,
                child: Image.asset('assets/logo/appstore.png',
                    width: 100, height: 100),
              ),
            ),
            const Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'LetsGo',
                  style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 15,
                      color: Color(0xFF302E76)
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

