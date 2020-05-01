import 'package:easybuy_frontend/src/providers/myshoppingProvider.dart';
import 'package:flutter/cupertino.dart';

class MyshoppingController {
  MyShoppingProvider myShoppingProvider;
  MyshoppingController() {
    myShoppingProvider = new MyShoppingProvider();
  }

  Future<Map> createShopping(BuildContext context, data) async {
    return await myShoppingProvider.createShopping(data);
  }

  Future<List<dynamic>> myshopping(BuildContext context, id) async {
    return await myShoppingProvider.myshopping(id);
  }
}
