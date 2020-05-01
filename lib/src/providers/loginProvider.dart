import 'dart:convert';
import 'package:easybuy_frontend/src/config/UrlConfig.dart';
import 'package:easybuy_frontend/src/utils/HttpClient.dart';
import 'package:easybuy_frontend/src/utils/token.dart';
import 'package:http/http.dart';

class LoginProvidier {
  String url = UrlConfig().getUri();
  String uri;
  HttpClient http;

  LoginProvidier() {
    http = HttpClient();
    uri = "$url/users";
  }

  Future<Map> login(data) async {
    Map users;
    try {
      Response res = await http.post('$uri/login', data);
      users = jsonDecode(res.body);
      print(users);
      print(users['token']);
      Token().setToken(users['token']);
    } catch (err) {
      print(err);
    }
    return users;
  }
}
