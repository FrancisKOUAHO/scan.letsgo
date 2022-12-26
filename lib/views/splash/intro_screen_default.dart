import 'package:LetsGo_Scan/views/home/home_screen.dart';
import 'package:LetsGo_Scan/views/login/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';

import '../../database/db_provider.dart';
import '../../utils/routers.dart';

class IntroScreenDefault extends StatefulWidget {
  const IntroScreenDefault({Key? key}) : super(key: key);

  @override
  IntroScreenDefaultState createState() => IntroScreenDefaultState();
}

class IntroScreenDefaultState extends State<IntroScreenDefault> {
  List<ContentConfig> listContentConfig = [];

  final DatabaseProvider? db = DatabaseProvider();

  dynamic _user;

  @override
  void initState() {
    super.initState();

    listContentConfig.add(
      const ContentConfig(
        title: "Bienvenue !",
        description:
            "Conslutez les differents étapes pour l'utilisation de l'application",
        backgroundColor: Color(0xFF302E76),
      ),
    );
    listContentConfig.add(
      const ContentConfig(
        title: "Scan",
        description:
            "Scanner les billets et les pass de votre événement en présentant le code-barre devant l'appareil.",
        pathImage: "assets/images/scan.png",
        backgroundColor: Color(0xFF302E76),
      ),
    );
    listContentConfig.add(
      const ContentConfig(
        title: "Synchronisation",
        description:
            "En Wi-Fi ou via réseau mobile, la validation des billets est transmise au serveur en temps réel et synchronisée avec les autres appareils.",
        pathImage: "assets/images/synchronize.png",
        backgroundColor: Color(0xFF302E76),
      ),
    );
    listContentConfig.add(
      const ContentConfig(
        title: "Statistiques",
        description:
            "Consultez en temps réel les statistiques de votre (vos) appareil (s). Restez connecté au WiFi pour une synchronisation optimale des données.",
        pathImage: "assets/images/statistiques.png",
        backgroundColor: Color(0xFF302E76),
      ),
    );
    listContentConfig.add(
      const ContentConfig(
        title: "Let's Go Scan",
        description: "Scanner vos premiers billets dès maintenant",
        backgroundColor: Color(0xFF302E76),
      ),
    );
  }

  void onDonePress() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignIn()));
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      key: UniqueKey(),
      listContentConfig: listContentConfig,
      onDonePress: onDonePress,
    );
  }
}
