import 'package:easybuy_frontend/src/utils/HttpClient.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:easybuy_frontend/src/config/UrlConfig.dart';

class ChangePasswordProvider {
  HttpClient client;
  String _url;
  ChangePasswordProvider() {
    client = new HttpClient();
    _url = UrlConfig().getUri();
  }
  Future<Map<String, dynamic>> changePassword(email, body) async {
    try {
      Response response = await client.put('$_url/users/$email/changepassword', body);
      Map res = json.decode(response.body);
      if (res != null) {
        return {"message": '¡Contraseña Actualizada!'};
      }
      return {"message": 'Opps!, algo salió mal'};
    } catch (error) {
      return {"message": 'Contraseña actual incorrecta'};
    }
  }
}
