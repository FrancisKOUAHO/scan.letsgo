import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import '../login/sign_in.dart';

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
        title: "Bienvenue !",
        description:
            "Conslutez les differents étapes pour l'utilisation de l'application",
        backgroundColor: Color(0xff4376FF),
      ),
    );
    listContentConfig.add(
      const ContentConfig(
        title: "Scan",
        description:
            "Scanner les billets et les pass de votre événement en présentant le code-barre devant l'appareil.",
        pathImage: "assets/images/scan.png",
        backgroundColor: Color(0xff4376FF),
      ),
    );
    listContentConfig.add(
      const ContentConfig(
        title: "Synchronisation",
        description:
            "En Wi-Fi ou via réseau mobile, la validation des billets est transmise au serveur en temps réel et synchronisée avec les autres appareils.",
        pathImage: "assets/images/synchronize.png",
        backgroundColor: Color(0xff4376FF),
      ),
    );
    listContentConfig.add(
      const ContentConfig(
        title: "Statistiques",
        description:
            "Consultez en temps réel les statistiques de votre (vos) appareil (s). Restez connecté au WiFi pour une synchronisation optimale des données.",
        pathImage: "assets/images/statistiques.png",
        backgroundColor: Color(0xff4376FF),
      ),
    );
    listContentConfig.add(
      const ContentConfig(
        title: "Let's Go Scan",
        description: "Scanner vos premiers billets dès maintenant",
        backgroundColor: Color(0xff4376FF),
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
      renderNextBtn: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white, // Couleur du bouton "Next"
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          "Suivant",
          style: TextStyle(
            color: Colors.black, // Couleur du texte "Suivant"
            fontSize: 10,
          ),
        ),
      ),
      renderDoneBtn: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white, // Couleur du bouton "Done"
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          "Terminer",
          style: TextStyle(
            color: Colors.black, // Couleur du texte "Terminer"
            fontSize: 10,
          ),
        ),
      ),
      renderSkipBtn: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white, // Couleur du bouton "Skip"
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          "Passer",
          style: TextStyle(
            color: Colors.black, // Couleur du texte "Passer"
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}
