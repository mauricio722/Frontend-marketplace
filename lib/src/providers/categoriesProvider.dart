import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/UrlConfig.dart';
import '../utils/HttpClient.dart';

class CategoriesProvider {
  HttpClient client;
  List<dynamic> categories = [];

  String _url = UrlConfig().getUri();
  Future<List<dynamic>> categoriesList(id) async {
    http.Response res = await http.get('$_url/productscategory/$id');
    categories = json.decode(res.body);

    return categories;
  }
}
