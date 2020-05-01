import 'dart:convert';

import 'package:easybuy_frontend/src/config/UrlConfig.dart';
import 'package:easybuy_frontend/src/utils/HttpClient.dart';
import 'package:http/http.dart';

class SendNotificationsProvider {
  HttpClient http;
  String url = UrlConfig().getUri();
  String uri;

  SendNotificationsProvider() {
    http = HttpClient();
    uri = '$url/notifications';
  }

  Future<Map> sendNotidication(body) async {
    Map notification;
    print('==========================================');
    print(body);
    print('===========================================');
    try {
      Response res = await http.post('$uri/send', body);
      notification = jsonDecode(res.body);

      print('#################################');
      print(notification);
      print('#################################');
    } catch (error) {
      print(error);
      return null;
    }
    return notification;
  }

  
}