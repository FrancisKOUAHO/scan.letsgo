import 'dart:async';

import 'package:LetsGo_Scan/views/splash/intro_screen_default.dart';
import 'package:flutter/material.dart';

import '../../database/db_provider.dart';
import '../../utils/routers.dart';
import '../home/home_screen.dart';

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
    super.initState();
    _token = db!.getToken().then((value) => _token = value);
    navigate();

    navigate();
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
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Splash.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF302E76).withOpacity(0.5),
                    const Color(0xFF302E76).withOpacity(0.5),
                    const Color(0xFF302E76).withOpacity(1),
                    const Color(0xFF302E76).withOpacity(1),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.2, 0.5, 1, 1],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: const [],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
