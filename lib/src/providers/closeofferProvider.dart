import 'package:easybuy_frontend/src/config/UrlConfig.dart';
import 'package:easybuy_frontend/src/utils/HttpClient.dart';

class CloseofferProvider {
  HttpClient http;
  String url = UrlConfig().getUri();
  String uri;

  CloseofferProvider() {
    http = HttpClient();
    uri = "$url/products";
  }

  Future closeOffer(id, body) async {
    try {
      await http.put('$uri/close/$id', body);

      return print('se actualizo el estado');
    } catch (error) {
      return [];
    }
  }
}
