import 'dart:convert';

import 'package:easybuy_frontend/src/config/UrlConfig.dart';
import 'package:easybuy_frontend/src/utils/HttpClient.dart';
import 'package:http/http.dart';

class UpdateProductProvider {
  String url2 = UrlConfig().getUri();

  HttpClient http;
  String url = UrlConfig().getUri();
  String uri;
  String uri2;

  updateProductProvider() {
    http = HttpClient();
    uri = "$url/actualizar";
  }

  UpdateProductProvider() {
    http = HttpClient();
    uri = '$url';
    uri2 = "$url2/products";
  }

  Future<Map> updateproducts(product, id) async {
    Map products;

    print(product);
    try {
      Response res = await http.put('$url/products/update/$id', product);
      products = jsonDecode(res.body);
    } catch (err) {
      print(err);
    }
    return products;
  }

  Future<List> updateimages(images, id) async {
    List photo;   
    try {
      Response res = await http.put('$uri2/images/$id', images);
      photo = jsonDecode(res.body);

      print(photo);

      return photo;
    } catch (error) {
      print(error);
      return photo;
    }
  }


  Future<List> getproductdetail(id) async {
    List productdetail;
    try{
      Response res = await http.get('$uri/images/$id');
      productdetail = json.decode(res.body);
      return  productdetail;
    }catch(error){
      
      return null;
    }
  }

   

  Future<Map> updatecategory(data) async {
    Map categories;
    try {
      Response res = await http.put('$uri/categories',{});
      categories = jsonDecode(res.body);

      return categories;
    } catch (error) {
      print(error);
      return categories;
    }
  }

 
}
