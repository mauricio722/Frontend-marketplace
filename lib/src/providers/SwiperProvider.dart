import 'dart:convert';

import 'package:http/http.dart';

import '../config/UrlConfig.dart';
import '../utils/HttpClient.dart';

class SwiperProvider {
  String url = UrlConfig().getUri();
  String uri;
  HttpClient http;

  SwiperProvider() {
    http = HttpClient();
    uri = "$url/products";
  }

  Future<List> getproductdetail(id) async {
    List productdetail;
    try {
      Response res = await http.get('$uri/images/$id');
      productdetail = json.decode(res.body);
      return productdetail;
    } catch (error) {
      return null;
    }
  }
}
