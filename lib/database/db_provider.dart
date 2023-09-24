import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../constants/url.dart';
import '../utils/routers.dart';
import '../views/login/sign_in.dart';

class DatabaseProvider extends ChangeNotifier {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  final requestBaseUrl = AppUrl.baseUrl;

  String _token = '';

  String get token => _token;

  void saveToken(String token) async {
    SharedPreferences value = await _pref;
    value.setString('token', token);
  }

  void saveUserId(String id) async {
    SharedPreferences value = await _pref;

    value.setString('id', id);
  }

  void saveUserDetails(String user) async {
    SharedPreferences value = await _pref;
    value.setString('user', user);
  }

  Future<String> getToken() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('token')) {
      String data = value.getString('token')!;
      _token = data;
      notifyListeners();
      return data;
    } else {
      _token = '';
      notifyListeners();
      return '';
    }
  }

  Future<dynamic> getUser() async {
    String url = '$requestBaseUrl/auth/me';
    http.Response req = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await getToken()}'
    });

    return json.decode(req.body);
  }

  void logOut(BuildContext context) async {
    final value = await _pref;

    value.clear();

    PageNavigator(ctx: context).nextPageOnly(page: const SignIn());
  }
}
