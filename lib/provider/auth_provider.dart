import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/url.dart';
import '../database/db_provider.dart';
import '../utils/routers.dart';
import '../views/home/home.dart';
import '../views/login/sign_in.dart';

class AuthenticationProvider extends ChangeNotifier {
  ///Base Url
  final requestBaseUrl = AppUrl.baseUrl;

  ///Setter
  bool _isLoading = false;
  String _resMessage = '';

  //Getter
  bool get isLoading => _isLoading;

  String get resMessage => _resMessage;

  void registerUser({
    required String email,
    required String password,
    required String fullName,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = '$requestBaseUrl/auth/register';

    final body = {'full_name': fullName, 'email': email, 'password': password};

    print('body: $body');

    try {
      http.Response req = await http.post(Uri.parse(url), body: body);

      if (req.statusCode == 200 || req.statusCode == 201) {
        _isLoading = false;
        _resMessage = 'Inscription réussie';
        PageNavigator(ctx: context).nextPageOnly(page: const SignIn());
        notifyListeners();
      } else {
        final res = json.decode(req.body);

        _resMessage = res.body['message'];

        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = 'Erreur de connexion';
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = 'Une erreur est survenue';
      notifyListeners();
      print(':::: $e');
    }
  }

  //Login
  void loginUser({
    required String email,
    required String password,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = '$requestBaseUrl/auth/login';

    final body = {'email': email, 'password': password};

    try {
      http.Response req = await http.post(Uri.parse(url), body: body);

      if (req.statusCode == 200 || req.statusCode == 201) {
        final res = json.decode(req.body);
        _isLoading = false;
        _resMessage = 'Connexion réussie !';
        notifyListeners();

        ///Save users data and then navigate to homepage
        final token = res['token'];

        DatabaseProvider().saveToken(token);

        if (token.isNotEmpty) {
          PageNavigator(ctx: context).nextPageOnly(page: const Home());
        }
      } else {
        final res = json.decode(req.body);

        print('res: $res');

        _resMessage = res['message'];

        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = 'Erreur de connexion';
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = 'Une erreur est survenue';
      notifyListeners();

      print(':::: $e');
    }
  }

  void clear() {
    _resMessage = '';
    _isLoading = false;
    notifyListeners();
  }
}
