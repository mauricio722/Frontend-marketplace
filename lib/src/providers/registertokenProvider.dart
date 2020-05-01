import 'dart:convert';

import 'package:easybuy_frontend/src/config/UrlConfig.dart';
import 'package:easybuy_frontend/src/utils/HttpClient.dart';
import 'package:http/http.dart';

class RegistertokenProvider {
  HttpClient http;
  String url = UrlConfig().getUri();
  String uri;

  RegistertokenProvider() {
    http = HttpClient();
    uri = '$url/notifications';
  }

  Future<List> registertoken(body) async {
    List deviceToken;
    print('##################################');
    print(body);
    print('##################################');
    try {
      Response res = await http.post('$uri/registerTokendevice', body);
      deviceToken = jsonDecode(res.body);
    } catch (error) {
      print(error);
      return null;
    }
    return deviceToken;
  }

  Future<Map> updateTokenDevice(body, idUser) async {
    Map deviceToken;

    try{
      Response res = await http.post('$uri/updateToken/$idUser', body);
      deviceToken = jsonDecode(res.body);
    }catch (error) {
      return null;
    }

    return deviceToken;
  }

  
}