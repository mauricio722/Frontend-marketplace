import 'dart:convert';

import 'package:easybuy_frontend/src/config/UrlConfig.dart';
import 'package:easybuy_frontend/src/utils/HttpClient.dart';
import 'package:http/http.dart';

class UserProvider {
  
  HttpClient http;
  String url = UrlConfig().getUri();
  String uri;

  UserProvider(){
    http = HttpClient();
    uri = '$url/users';
  }

  Future<List> getUsers(id) async{
    List user;

    try{
      Response res = await http.get('$uri/getUser/$id');
      user = jsonDecode(res.body);
    }catch(error){
      return error;
    }
    return  user;
  }
}