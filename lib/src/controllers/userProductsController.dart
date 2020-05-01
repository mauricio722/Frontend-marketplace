import 'package:easybuy_frontend/src/providers/userProductsProvider.dart';

class UserProductsController {
  UserProductsProvider userProductsProvider;
  UserProductsController() {
    userProductsProvider = new UserProductsProvider();
  }
  Future<List<dynamic>> getProductsidUser(context, id) async {
    return await userProductsProvider.getproduct(id);
  }
}
