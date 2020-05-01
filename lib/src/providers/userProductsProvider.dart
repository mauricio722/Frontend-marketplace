import 'dart:convert';

import 'package:easybuy_frontend/src/config/UrlConfig.dart';
import 'package:easybuy_frontend/src/utils/HttpClient.dart';
import 'package:http/http.dart';

class UserProductsProvider {
  HttpClient http;
  String url = UrlConfig().getUri();
  String uri;

  UserProductsProvider() {
    http = HttpClient();
    uri = url;
  }

  Future<List<dynamic>> getproduct(id) async {
    List products;
    try {
      Response res = await http.get('$uri/products/getuser/$id');
      products = json.decode(res.body);

      return products;
    } catch (error) {
      return null;
    }
  }
}
