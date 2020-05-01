import 'dart:convert';
import 'package:easybuy_frontend/src/config/UrlConfig.dart';
import 'package:easybuy_frontend/src/utils/HttpClient.dart';
import 'package:http/http.dart';

class NavigationProvider {
  HttpClient http;
  String url = UrlConfig().getUri();
  List project;
    List<dynamic> dataProduct; 


  String uri;

  NavigationProvider() {
    http = HttpClient();
    uri = url;
  }

  Future<Map> createNavigation(data) async {
    Map project;
    print(data);
    try {
      Response res = await http.post('$uri/products/navigation/create', data);
      print(res);
      project = jsonDecode(res.body);
    } catch (err) {
      print(err);
      return err;
    }
    return project;
  }

  Future<List<dynamic>> getNavigation(id) async {
    List products;
    try {
      Response res = await http.get('$uri/products/navigation/$id');
      products = json.decode(res.body);

    } catch (error) {
      return [];
    }
    return products;
  }

   Future<List<dynamic>> getNavigationByProduct(idProduct) async {

    try {
      Response response = await http.get('$uri/products/navigation/products/$idProduct');

      dataProduct = json.decode(response.body);

      
      
    } catch (err) {
      return [];
    }

    return dataProduct;
  }

  Future deleteNavigation(idNavigation) async {

    try {
      Response response = await http.delete('$uri/products/deletenavigationproduct/$idNavigation');


      return jsonDecode(response.body);
    } catch (err) {
      return [];
    }
  }

   Future<List<dynamic>> getMaxNavigation(idUser) async {
    try {
      Response response = await http.get('$uri/products/maxnavigation/$idUser');
      dataProduct = json.decode(response.body);
    } catch (err) {
      return [];
    }

    return dataProduct;
  }

   
}
