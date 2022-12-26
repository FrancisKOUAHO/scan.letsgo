import 'package:LetsGo_Scan/views/Profil/settings_scren.dart';
import 'package:flutter/material.dart';

import '../../database/db_provider.dart';
import '../../theme/letsgo_theme.dart';
import '../../utils/routers.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  final double profilHeight = 144;
  final DatabaseProvider? db = DatabaseProvider();

  dynamic _user;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
      future: db!.getUser(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          _user = snapshot.data;
          return Scaffold(
              extendBodyBehindAppBar: true,
              body: Stack(
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(
                        height: 150,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: 130,
                                height: 130,
                                clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.network(
                                  'https://picsum.photos/seed/58/600',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 10, 0, 0),
                                child: Text(
                                  _user != null ? _user['full_name'] : 'User',
                                  style: const TextStyle(
                                    fontFamily: 'Outfit',
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: Text(
                                  'Paris, France',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xBA777777),
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          InkWell(
                            onTap: null,
                            child: SizedBox(
                              width: 110,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Icon(
                                    Icons.sports_basketball_outlined,
                                    color: LetsGoTheme.main,
                                    size: 23,
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    'ACTIVITÉS',
                                    style: TextStyle(
                                      color: LetsGoTheme.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    '01',
                                    style: TextStyle(
                                      color: LetsGoTheme.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: SizedBox(
                              width: 110,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.local_activity_outlined,
                                    color: LetsGoTheme.main,
                                    size: 23,
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    'RESERVATION',
                                    style: TextStyle(
                                      color: LetsGoTheme.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    '17',
                                    style: TextStyle(
                                      color: LetsGoTheme.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              PageNavigator(ctx: context).nextPageOnly(page: const SettingsScren());
                            },
                            child: SizedBox(
                              width: 110,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.settings,
                                    color: LetsGoTheme.main,
                                    size: 23,
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    'Paramètres',
                                    style: TextStyle(
                                      color: LetsGoTheme.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    '7',
                                    style: TextStyle(
                                      color: LetsGoTheme.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 12, 0, 0),
                                child: Text(
                                  'Mes amis',
                                  style: LetsGoTheme.subTitle,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: double.infinity,
                            height: 100,
                            decoration: const BoxDecoration(),
                            child: const Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0, 2, 0, 0),
                              child: Center(
                                child: Text(
                                  'Aucun ami pour le moment',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xBA777777),
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              )
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 12, 0, 20),
                                child: Text(
                                  'Liste de activités',
                                  style: LetsGoTheme.subTitle,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ));
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
