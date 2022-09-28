import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  static const String _tokenKeyName = 'token';

  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyDU3msk-PYJyxaNuTXG_AIeIdk42_SX5CQ';
  final _storage = const FlutterSecureStorage();


  Future<bool> login({required String email, required String password}) async {
    final url = Uri.https(
      _baseUrl,
      '/v1/accounts:signInWithPassword',
      {'key': _firebaseToken},
    );

    final Map<String, dynamic> userData = {
      'email': email,
      'password': password
    };

    final httpResponse = await http.post(url, body: json.encode(userData));
    final dataResponse = json.decode(httpResponse.body);

    final bool loginSuccessful = httpResponse.statusCode == HttpStatus.ok;
    if (loginSuccessful) {
      await _storage.write(key: _tokenKeyName, value: dataResponse['idToken']);
    }

    return loginSuccessful;
  }

  Future logout() async => await _storage.delete(key: _tokenKeyName);

  Future<String?> getToken() async => await _storage.read(key: _tokenKeyName);

  Future<bool> registerUser(
      {required String email, required String password}) async {
    final url = Uri.https(
      _baseUrl,
      '/v1/accounts:signUp',
      {'key': _firebaseToken},
    );

    final Map<String, dynamic> userData = {
      'email': email,
      'password': password
    };

    final httpResponse = await http.post(url, body: json.encode(userData));

    return httpResponse.statusCode == HttpStatus.ok;
  }
}
