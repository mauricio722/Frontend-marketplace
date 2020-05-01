import 'dart:convert';
import 'package:http/http.dart';
import '../utils/HttpClient.dart';
import 'package:easybuy_frontend/src/config/UrlConfig.dart';

class RememberPasswordProvider {
  HttpClient http;
  String uri;

  RememberPasswordProvider() {
  uri = UrlConfig().getUri();

    http = HttpClient();
  }

  Future<Map> recoverPassword(email, data) async {
    try {
      Response res = await http.put('$uri/users/recoverPassword/$email', data);
      return jsonDecode(res.body);
    } catch (err) {
      print(err);

      return null;
    }
  }
}
