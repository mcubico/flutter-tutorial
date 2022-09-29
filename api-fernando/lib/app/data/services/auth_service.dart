import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyDU3msk-PYJyxaNuTXG_AIeIdk42_SX5CQ';
  final _storage = const FlutterSecureStorage();

  static const String tokenKeyName = 'token';

  Future<bool> login({required String email, required String password}) async {
    final url = Uri.https(
      _baseUrl,
      '/v1/accounts:signInWithPassword',
      {'key': _firebaseToken},
    );

    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final httpResponse = await http.post(url, body: json.encode(authData));
    final dataResponse = json.decode(httpResponse.body);

    final bool loginSuccessful = httpResponse.statusCode == HttpStatus.ok &&
        dataResponse['error'] == null;
    if (loginSuccessful) {
      await _storage.write(key: tokenKeyName, value: dataResponse['idToken']);
    }

    return loginSuccessful;
  }

  Future logout() async => await _storage.delete(key: tokenKeyName);

  Future<String?> getToken() async => await _storage.read(key: tokenKeyName);

  Future<bool> registerUser(
      {required String email, required String password}) async {
    final url = Uri.https(
      _baseUrl,
      '/v1/accounts:signUp',
      {'key': _firebaseToken},
    );

    final Map<String, dynamic> userData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final httpResponse = await http.post(url, body: json.encode(userData));

    return httpResponse.statusCode == HttpStatus.ok;
  }
}
