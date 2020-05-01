import 'package:easybuy_frontend/src/providers/navigationProvider.dart';
import 'package:flutter/material.dart';

class NavigationController {
  NavigationProvider navigationProvider;
  NavigationController() {
    navigationProvider = NavigationProvider();
  }
  Future<Map> createNavigation(BuildContext context, data) async {
    return await navigationProvider.createNavigation(data);
  }

  Future<List<dynamic>> getNavigation(BuildContext context, idUser) async {
    return await navigationProvider.getNavigation(idUser);
  }

     Future<List<dynamic>>  getNavigationByProduct(BuildContext context, idProduct) async {
    return await navigationProvider.getNavigationByProduct(idProduct);
  }


  Future deleteNavigation(idNavigation) async {
    return await navigationProvider.deleteNavigation(idNavigation);
  }
  
}
