import 'dart:convert';

import 'package:easybuy_frontend/src/config/UrlConfig.dart';
import 'package:easybuy_frontend/src/utils/HttpClient.dart';
import 'package:easybuy_frontend/src/utils/token.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Session {
  String uri;
  HttpClient http;
  Token token;
    String url = UrlConfig().getUri();

  Session() {
    uri = "$url/users";
    http = new HttpClient();
    token = new Token();
  }
   void start(body,data) {
    print('start session');
    token.setToken(body['token']);
    token.setString('id', body['id'].toString());
    token.setString('email', body['email']);
    token.setString('password', data['password']);
  }

  Future<Map> getInformation() async {
    final user = {
      'id': await token.getString('id'),
      'email': await token.getString('email'),
      'password': await token.getString('password'),
      'token': await token.getToken(),
    };
    return user;
  }

  Future<bool> renovate() async {
    final email = await token.getString('email');
    final password = await token.getString('password');
    print({'email': email, 'password': password});
    if (email != '' && password != '') {
      Response response = await http.post('$uri/login', {'email': email, 'password': password});
      try {
        Map user = jsonDecode(response.body);
        user['password'] = password;
        this.start(user,user);
        return true;
      } catch (e) {
        return false;
      }
    }
    return false;
  }
  Future close(context) {
    print('close session');
    token.setToken('');
    token.setString('id', '');
    token.setString('email', '');
    token.setString('password', '');
    Token().setNumber('c', 0);
    return Navigator.pushReplacementNamed(context, '/');
  }
}
