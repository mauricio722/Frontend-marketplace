import 'dart:convert';

import 'package:easybuy_frontend/src/config/UrlConfig.dart';
import 'package:easybuy_frontend/src/utils/HttpClient.dart';
import 'package:http/http.dart';

class SearchProvider {
  HttpClient http;
  String url = UrlConfig().getUri();
  String uri;

  SearchProvider() {
    http = HttpClient();
    uri = "$url/products";
  }

  Future<List> getResult(query) async {
    List results;
    try {
      Response res = await http.get('$uri/name/$query');
      results = json.decode(res.body);

      return results;
    } catch (error) {
      return error;
    }
  }
}
