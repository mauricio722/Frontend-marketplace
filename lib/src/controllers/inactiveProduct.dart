import 'package:easybuy_frontend/src/providers/inactiveProvider.dart';

class InactiveProductsController {
  InactiveProductsProvider inactiveProductsProvider;
  InactiveProductsController() {
    inactiveProductsProvider = new InactiveProductsProvider();
  }
  Future<List<dynamic>> getProductsidUser(context, id) async {
    return await inactiveProductsProvider.getproductInactive(id);
  }
}
