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
  dynamic _user;

  @override
  void initState() {
    super.initState();

    db!.getUser().then((value) {
      setState(() {
        _user = value;
      });
    });

    navigate();
  }

  void navigate() {
    Future.delayed(const Duration(seconds: 3), () {
      if (_user != null) {
        PageNavigator(ctx: context).nextPageOnly(page: const HomeScreen());
      } else {
        PageNavigator(ctx: context)
            .nextPageOnly(page: const IntroScreenDefault());
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
                    const Color(0xFF5B7CB8).withOpacity(0.5),
                    const Color(0xFF5B7CB8).withOpacity(1),
                    const Color(0xFF5B7CB8).withOpacity(1),
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
                    children: [],
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
