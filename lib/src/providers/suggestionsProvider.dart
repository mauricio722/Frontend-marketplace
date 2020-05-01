import 'dart:convert';
import 'package:easybuy_frontend/src/config/UrlConfig.dart';
import 'package:easybuy_frontend/src/utils/HttpClient.dart';
import 'package:http/http.dart';
class SuggestionsProvider {
  HttpClient http;
  String url = UrlConfig().getUri();
  List project;
    List<dynamic> dataProduct; 
  String uri;
  SuggestionsProvider() {
    http = HttpClient();
    uri = url;
  }
  Future<List<dynamic>> getSuggestions(idUser) async {
    List products;
    try {
      Response res = await http.get('$uri/products/suggestions/$idUser');
      products = json.decode(res.body);
      
    } catch (error) {
      return [];
    }
    return products;
  }

  Future<List<dynamic>> getMaxSuggestions(idCategory, cost) async {
    List products;
    try {
      Response res = await http.get('$uri/products/maxsuggestion/$idCategory/cost/$cost');
      products = json.decode(res.body);
      return products;
    } catch (error) {
      return [];
    }
  }

  
}