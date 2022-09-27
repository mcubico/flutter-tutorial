import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyDU3msk-PYJyxaNuTXG_AIeIdk42_SX5CQ';

  Future<String?> login(
      {required String email, required String password}) async {
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

    return httpResponse.statusCode == HttpStatus.ok
        ? dataResponse['idToken']
        : null;
  }

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
    final dataResponse = json.decode(httpResponse.body);

    return httpResponse.statusCode == HttpStatus.ok;
  }
}
