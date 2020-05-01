import 'dart:convert';

import 'package:easybuy_frontend/src/config/UrlConfig.dart';
import 'package:easybuy_frontend/src/utils/HttpClient.dart';
import 'package:http/http.dart';

class GetTokenProvider {
  HttpClient http;
  String url = UrlConfig().getUri();
  String uri;

  GetTokenProvider() {
    http = HttpClient();
    uri = '$url/notifications';
  }

  Future<List> getToken(id) async {
    print('**************');
    print(id);
    print('****************');
    List notification;
    print(id);
    try {
      Response res = await http.get('$uri/getToken/$id');
      notification = jsonDecode(res.body);
      print(notification);
    } catch (error) {
      print(error);
      return null;
    }
    return notification;
  }

  
}