import 'dart:convert';

import 'package:easybuy_frontend/src/config/UrlConfig.dart';
import 'package:easybuy_frontend/src/utils/HttpClient.dart';
import 'package:http/http.dart';

class InactiveProductsProvider {
  HttpClient http;
  String url = UrlConfig().getUri();
  String uri;

  InactiveProductsProvider() {
    http = HttpClient();
    uri = url;
  }

  Future<List<dynamic>> getproductInactive(id) async {
    List products;
    try {
      Response res = await http.get('$uri/products/getUsers/$id');
      products = json.decode(res.body);

      return products;
    } catch (error) {
      return null;
    }
  }
}
