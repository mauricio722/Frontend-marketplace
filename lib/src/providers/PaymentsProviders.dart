import 'dart:convert';

import 'package:easybuy_frontend/src/config/UrlConfig.dart';
import 'package:easybuy_frontend/src/utils/HttpClient.dart';
import 'package:http/http.dart';

class PaymentsProviders {
  HttpClient http;
  UrlConfig configUri;
  String uri;
  PaymentsProviders() {
    http = new HttpClient();
    configUri = new UrlConfig();
    uri = configUri.getUri();
  }
  Future<String> pay(payment) async {
    Response response = await http.post('$uri/payments', payment);
    try {
      final res = jsonDecode(response.body);
      return res['link'];
    } catch (e) {
      return "";
    }
  }

  Future<bool> success(payment) async {
    Response response = await http.post('$uri/payments/success', payment);
    try {
      final res = jsonDecode(response.body);
      print("uy quieto");
      print(res);
      return res['success'];
    } catch (e) {}
    return false;
  }

  Future<bool> payout(payout) async {
    try {
      Response response = await http.post('$uri/payments/payout', payout);
      final res = jsonDecode(response.body);
      return res['success'];
    } catch (e) {}
    return false;
  }
}
