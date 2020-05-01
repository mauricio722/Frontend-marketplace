import 'dart:convert';

import 'package:easybuy_frontend/src/config/UrlConfig.dart';
import 'package:easybuy_frontend/src/utils/HttpClient.dart';
import 'package:http/http.dart';

class ProfilePageProvider {
  HttpClient http;
  String uri = UrlConfig().getUri();

  ProfilePageProvider() {
    http = HttpClient();
  }

  Future<Map> updateUser(idUser, data) async {
    print('provider');
    print(data);
    print(uri);
    print(idUser);

    Map user;
    try {
      print('aqui');
      Response response = await http.put('$uri/users/update/$idUser', data);
      user = jsonDecode(response.body);
      return user;
    } catch (e) {
      return null;
    }
  }

   Future<Map> getUserInformation(email) async {
    try {
      Response response = await http.get('$uri/users/$email');
      return jsonDecode(response.body);
    } catch (err) {
      return null;
    }
  }
}
