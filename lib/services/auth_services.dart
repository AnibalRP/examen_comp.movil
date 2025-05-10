import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthServices extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyCwQYMMlROaHlO12wGuTuIwBxTezL2iBdU';

  login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };

    final url = Uri.https(
      _baseUrl,
      '/v1/accounts:signInWithPassword',
      {'key': _firebaseToken},
    );

    final response = await http.post(
      url,
      body: json.encode(authData),
    );

    final Map<String, dynamic> decodedResponse = json.decode(response.body);

    if (decodedResponse.containsKey('idToken')) {
      return null; // login exitoso
    } else {
      return decodedResponse['error']['message'];
    }
  }

  create_user(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };

    final url = Uri.https(
      _baseUrl,
      '/v1/accounts:signUp',
      {'key': _firebaseToken},
    );

    final response = await http.post(
      url,
      body: json.encode(authData),
    );

    final Map<String, dynamic> decodedResponse = json.decode(response.body);

    if (decodedResponse.containsKey('idToken')) {
      return null; // registro exitoso
    } else {
      return decodedResponse['error']['message'];
    }
  }
}
