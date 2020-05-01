import 'dart:convert';
import 'dart:io';

import 'package:easybuy_frontend/src/config/UrlConfig.dart';
import 'package:easybuy_frontend/src/utils/HttpClient.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as https;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

class OfferProvider {
  HttpClient http;
  String url = UrlConfig().getUri();
  String url2 = UrlConfig().getUri();
  String uri;
  String uri2;

  OfferProvider() {
    http = HttpClient();
    uri = '$url';
    uri2 = "$url2/products";
  }

  Future<List> getcategorys() async {
    List categorys;

    try {
      Response res = await http.get('$uri/categories');
      categorys = json.decode(res.body);
      return categorys;
    } catch (error) {
      return [];
    }
  }

  Future<Map> registerProduct(body) async {
    Map product;
    print(body);
    try {
      Response res = await http.post('$uri/products', body);
      product = jsonDecode(res.body);
    } catch (error) {
      print(error);
      return null;
    }
    return product;
  }

  Future<String> uploadImagen(File foto) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dqgcu283t/image/upload?upload_preset=x1tmfezu');
    final mimeType = mime(foto.path).split('/');

    final imageUploadRequest = https.MultipartRequest('POST', url);

    final file = await https.MultipartFile.fromPath('file', foto.path,
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('algo salio mal');
      print(resp.body);
      return null;
    }

    final respData = json.decode(resp.body);
    //print(respData['secure_url']);

    return respData['secure_url'];
  }

  Future<List> registerImages(images) async {
    List photo;

    try {
      Response res = await http.post('$uri2/images', images);
      photo = jsonDecode(res.body);

      return photo;
    } catch (error) {
      print(error);
      return error;
    }
  }
}
