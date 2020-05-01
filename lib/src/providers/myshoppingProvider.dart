import 'dart:convert';

import 'package:easybuy_frontend/src/config/UrlConfig.dart';
import 'package:easybuy_frontend/src/utils/HttpClient.dart';
import 'package:http/http.dart';

class MyShoppingProvider {
  HttpClient http;
  String url = UrlConfig().getUri();
  List project;

  String uri;

  MyShoppingProvider() {
    http = HttpClient();
    uri = url;
  }

  Future<Map> createShopping(data) async {
    Map project;
    print(data);
    try {
      Response res = await http.post('$uri/products/myshopping/create', data);
      project = jsonDecode(res.body);
    } catch (err) {
      print(err);
    }
    return project;
  }

  Future<List<dynamic>> myshopping(id) async {
    List products;
    try {
      Response res = await http.get('$uri/products/myshopping/$id');
      products = json.decode(res.body);

      return products;
    } catch (error) {
      return null;
    }
  }
}
