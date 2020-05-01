import 'dart:convert';

import 'package:easybuy_frontend/src/config/UrlConfig.dart';
import 'package:easybuy_frontend/src/utils/HttpClient.dart';
import 'package:http/http.dart';

class FavoriteProductsProvider {
  HttpClient http;
  String uri = UrlConfig().getUri();
  List project;
  List<dynamic> dataProduct;

  FavoriteProductsProvider() {
    http = HttpClient();
  }

  Future<Map> createFavorite(Map data) async {
    Map project;
    print(data);
    try {
      Response res = await http.post('$uri/products/favoriteProducts', data);
      project = jsonDecode(res.body);
    } catch (err) {
      print(err);
    }
    return project;
  }

  Future<List<dynamic>> getFavorite(idUser) async {
    try {
      Response res = await http.get('$uri/products/favoriteProducts/$idUser');
      project = jsonDecode(res.body);
      return project;
    } catch (err) {
      return null;
    }
  }

  Future<Map> getFavoriteByProductAndUser(idUser, idProduct) async {
    Map data;
    try {
      Response res = await http.get(
          '$uri/products/productsFavorite/user/$idUser/product/$idProduct');
      data = jsonDecode(res.body);
      print(data);
    
      return data;
    } catch (err) {
      return null;
    }
  }

  Future<List<dynamic>> getFavoriteByProduct(idProduct) async {
    try {
      Response response =
          await http.get('$uri/products/favoriteProducts/products/$idProduct');

      dataProduct = json.decode(response.body);

      return dataProduct;
    } catch (err) {
      return null;
    }
  }

  Future deleteFavorite(idFavorite) async {
    try {
      Response response =
          await http.delete('$uri/products/favoriteProducts/$idFavorite');

      return jsonDecode(response.body);
    } catch (err) {
      return null;
    }
  }
}
