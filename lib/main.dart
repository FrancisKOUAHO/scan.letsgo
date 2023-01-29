import 'package:LetsGo_Scan/provider/auth_provider.dart';
import 'package:LetsGo_Scan/views/splash/splash_screen.dart';
import 'package:LetsGo_Scan/widgets/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'database/db_provider.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final DatabaseProvider? db = DatabaseProvider();
  dynamic _user = '';

  @override
  void initState() {
    super.initState();
    _user = db!.getUser().then((value) => {
          if (value != null)
            {
              globals.userID = value['id'],
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => DatabaseProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
