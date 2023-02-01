import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:LetsGo_Scan/widgets/globals.dart' as globals;

import '../../constants/url.dart';
import '../../models/reservation.model.dart';
import '../../theme/LetsGo_theme.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Reservation>> reservationsFuture = getReservationList();

  static Future<List<Reservation>> getReservationList() async {
    String url =
        '${AppUrl.baseUrl}/reservations/reservationAndOrganisator/${globals.userID}';
    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);
    globals.reservations = body.length;
    return body.map<Reservation>(Reservation.fromJson).toList();
  }

  Widget buildReservations(List<Reservation> reservations) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LetsGoTheme.main,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(5),
        itemCount: reservations.length,
        itemBuilder: (context, index) {
          final reservation = reservations[index];
          if (reservations.isEmpty) {
            return const Center(
              child: Text('vous n\'avez pas de réservations'),
            );
          }
          return Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(0),
                          ),
                          child: Image.network(
                            'https://picsum.photos/seed/180/600',
                            width: 80,
                            height: MediaQuery.of(context).size.height * 0.13,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.13,
                            decoration: const BoxDecoration(
                              color: Color(0xFFEEEEEE),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(10),
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 10, 10, 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 260,
                                        decoration: const BoxDecoration(
                                          color: Colors.transparent,
                                        ),
                                        child: Text(
                                          '${reservation.activities!['name'].substring(0, 30)}...',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 5, 0, 0),
                                        child: Container(
                                          width: 260,
                                          decoration: const BoxDecoration(
                                            color: Colors.transparent,
                                          ),
                                          child: Text(
                                            'Réservé par : ${reservation.users!['full_name']}',
                                            style: const TextStyle(
                                              color: Color(0xFFA0A0A0),
                                              fontWeight: FontWeight.w300,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 5, 0, 0),
                                        child: Container(
                                          width: 260,
                                          decoration: const BoxDecoration(
                                            color: Colors.transparent,
                                          ),
                                          child: Text(
                                            'Réservation pour : ${reservation.number_of_places}',
                                            style: const TextStyle(
                                              color: Color(0xFFA0A0A0),
                                              fontWeight: FontWeight.w300,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 7, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 5, 0),
                                                  child: Icon(
                                                    Icons.qr_code,
                                                    color: Colors.black,
                                                    size: 16,
                                                  ),
                                                ),
                                                Text(
                                                  reservation.date_of_session!
                                                      .substring(0, 10),
                                                  style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(20, 0, 0, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 5, 0),
                                                    child: Icon(
                                                      Icons.access_time,
                                                      color: Colors.black,
                                                      size: 16,
                                                    ),
                                                  ),
                                                  Text(
                                                    reservation
                                                        .time_of_session!,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(20, 0, 0, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 5, 0),
                                                    child: Icon(
                                                      Icons.euro,
                                                      color: Colors.black,
                                                      size: 16,
                                                    ),
                                                  ),
                                                  Text(
                                                    reservation.total_price!,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Reservation>>(
      future: reservationsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          final reservations = snapshot.data!;
          return buildReservations(reservations);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else {
          return const Center(
            child: Text('No data'),
          );
        }
      },
    );
  }
}
