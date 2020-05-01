import 'dart:convert';
import 'package:http/http.dart';
import '../config/UrlConfig.dart';
import '../utils/HttpClient.dart';

class PaymentsReceivedProvider{

  String url = UrlConfig().getUri();
  HttpClient http;
  PaymentsReceivedProvider() {
    http = HttpClient();
  }

  Future<List> getPaymentsReceived(int idDealer) async {
  print(idDealer);
  try {
    Response res = await http.get('$url/products/paymentsReceived/$idDealer');

    return json.decode(res.body);
  } catch (error) {
    return null;
  }
}

}



