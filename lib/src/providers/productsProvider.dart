import 'dart:convert';

import 'package:easybuy_frontend/src/config/UrlConfig.dart';
import 'package:easybuy_frontend/src/utils/HttpClient.dart';
import 'package:http/http.dart';

class ProductsProvider {
  HttpClient http;
  String url = UrlConfig().getUri();
  String uri;

  ProductsProvider() {
    http = HttpClient();
    uri = "$url/products";
  }

  Future<List> getproduct(id) async {
    print(id);
    List products;
    try {
      Response res = await http.get('$uri/categorys/$id');
      products = json.decode(res.body);

      return products;
    } catch (error) {
      return null;
    }
  }

  Future<Map> deleteproducts(idProduct) async {
    Map products;
    try {
      print('$uri/delete/$idProduct');
      Response res = await http.delete('$uri/delete/$idProduct');
      // products = jsonDecode(res.body);
    } catch (err) {
      print(err);
    }
    return products;
  }



}
