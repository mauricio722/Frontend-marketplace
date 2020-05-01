import 'package:easybuy_frontend/src/utils/token.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpClient {
  Token token;
  HttpClient() {
    token = new Token();
  }

  Future<http.Response> get(uri) async {
    String token = await this.token.getToken();
    print(
        '-----------------------------------------token---------------------------------');
    print(token);
    return http.get(uri, headers: {"token": token});
  }

  Future<http.Response> post(uri, body) async {
    body = json.encode(body);
    String token = await this.token.getToken();
    print(
        '-----------------------------------------token---------------------------------');
    return http.post(uri,
        headers: {"Content-Type": "application/json", "token": token},
        body: body);
  }

  Future<http.Response> put(uri, body) async {
    body = json.encode(body);
    String token = await this.token.getToken();
    print(
        '-----------------------------------------token---------------------------------');
    print(token);
    return http.put(uri,
        headers: {"Content-Type": "application/json", "token": token},
        body: body);
  }

  Future<http.Response> delete(uri) async {
    String token = await this.token.getToken();
    print(
        '-----------------------------------------token---------------------------------');
    return http.delete(uri, headers: {"token": token});
  }
}
