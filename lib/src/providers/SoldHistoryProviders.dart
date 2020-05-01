import 'dart:convert';
import 'package:http/http.dart';
import '../config/UrlConfig.dart';
import '../utils/HttpClient.dart';

class SoldHistoryProduct{

  String url = UrlConfig().getUri();
  HttpClient http;
  SoldHistoryProduct() {
    http = HttpClient();
  }

  Future<List> getSoldProducts(int idUser) async {
  List productdetail;
  print(idUser);
  try {
    Response res = await http.get('$url/products/history/$idUser');
    productdetail = json.decode(res.body);
    print(res.body);
    return productdetail;
  } catch (error) {
    return null;
  }
}

}



