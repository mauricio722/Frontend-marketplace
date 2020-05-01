import 'dart:convert';
import 'package:easybuy_frontend/src/config/UrlConfig.dart';
import 'package:http/http.dart';
import '../utils/HttpClient.dart';

class SiginProvidier {
  String url = UrlConfig().getUri();
  String uri;
  HttpClient http;

  SiginProvidier() {
    http = HttpClient();
    uri = "$url/users";
  }

 Future<List> signin(data) async {
    List users;
    try {
      Response res = await http.post('$uri/create', data);
      print(res);
      users = jsonDecode(res.body);
    } catch (err) {

      print(err);
    }
    return users;
  }
}
