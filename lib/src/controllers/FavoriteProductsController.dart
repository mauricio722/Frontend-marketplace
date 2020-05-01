import 'package:easybuy_frontend/src/providers/FavoriteProductsProviders.dart';
import 'package:flutter/material.dart';


class FavoriteProductsController {
  FavoriteProductsProvider favoriteProductsProvider;
  FavoriteProductsController() {
    favoriteProductsProvider = FavoriteProductsProvider();
  }

  Future<Map> getFavoriteByProductAndUser(int idUser,int idProduct) async{
    return await favoriteProductsProvider.getFavoriteByProductAndUser(idUser,idProduct);
  }

  Future<List<dynamic>> getFavorite(BuildContext context, idUser) async {
    return await favoriteProductsProvider.getFavorite(idUser);
  }
  
    Future<List<dynamic>>  getFavoriteByProduct(BuildContext context, idProduct) async {
    return await favoriteProductsProvider.getFavoriteByProduct(idProduct);
  }

  Future<Map> createFavorite(BuildContext context,Map data) async {
    return await favoriteProductsProvider.createFavorite(data);
  }
   Future deleteFavorite(idFavorite) async {
    return await favoriteProductsProvider.deleteFavorite(idFavorite);
  }
 
  
}
