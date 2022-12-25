import 'dart:developer';

import 'package:LetsGo_Scan/views/login/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';

class IntroScreenDefault extends StatefulWidget {
  const IntroScreenDefault({Key? key}) : super(key: key);

  @override
  IntroScreenDefaultState createState() => IntroScreenDefaultState();
}

class IntroScreenDefaultState extends State<IntroScreenDefault> {
  List<ContentConfig> listContentConfig = [];

  @override
  void initState() {
    super.initState();

    listContentConfig.add(
      const ContentConfig(
        title: "Let'sGo",
        description:
            "Bienvenue ! Conslutez les differents étapes pour l'utilisation de l'application",
        backgroundColor: Color(0xFF302E76),
      ),
    );
    listContentConfig.add(
      const ContentConfig(
        title: "Scan",
        description:
            "Scanner les billets et les pass de votre événement en présentant le code-barre devant l'appareil.",
        pathImage: "images/scan.png",
        backgroundColor: Color(0xFF302E76),
      ),
    );
    listContentConfig.add(
      const ContentConfig(
        title: "Synchronisation",
        description:
            "En Wi-Fi ou via réseau mobile, la validation des billets est transmise au serveur en temps réel et synchronisée avec les autres appareils.",
        pathImage: "images/photo_ruler.png",
        backgroundColor: Color(0xFF302E76),
      ),
    );
    listContentConfig.add(
      const ContentConfig(
        title: "Statistiques",
        description:
            "Consultez en temps réel les statistiques de votre (vos) appareil (s). Restez connecté au WiFi pour une synchronisation optimale des données.",
        pathImage: "images/photo_ruler.png",
        backgroundColor: Color(0xFF302E76),
      ),
    );
    listContentConfig.add(
      const ContentConfig(
        title: "Pré-contrôle",
        description:
            "Permet un pré-contrôle multiple événements à l'entrée principale sans validation directe sur l'événement.",
        pathImage: "images/photo_ruler.png",
        backgroundColor: Color(0xFF302E76),
      ),
    );
    listContentConfig.add(
      const ContentConfig(
        title: "Let's Go",
        description: "Scanner vos premiers billets dès maintenant",
        pathImage: "images/photo_ruler.png",
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
