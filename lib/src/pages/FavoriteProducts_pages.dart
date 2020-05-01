import 'package:cached_network_image/cached_network_image.dart';
import 'package:easybuy_frontend/src/controllers/FavoriteProductsController.dart';
import 'package:easybuy_frontend/src/pages/swiper_targe.dart';
import 'package:easybuy_frontend/src/providers/productsProvider.dart';
import 'package:easybuy_frontend/src/utils/Session.dart';
import 'package:flutter/material.dart';

class FavoriteProductsPage extends StatefulWidget {
  FavoriteProductsPage();

  @override
  _FavoriteProductsPageState createState() => _FavoriteProductsPageState();
}

class _FavoriteProductsPageState extends State<FavoriteProductsPage> {
  final ProductsProvider products = ProductsProvider();
  int idProduct;
  final primary = Colors.teal;
  final secondary = Color(0xFFFFA000);

  List data;
  List productsFavoriteByUser;
  int idProject;
  FavoriteProductsController favoriteProductsController;
  Session session;
  Map user;

  _FavoriteProductsPageState() {
    session = new Session();
  }

  Future favoriteProducts() async {
    user = await session.getInformation();
    favoriteProductsController = new FavoriteProductsController();

    productsFavoriteByUser =
        await favoriteProductsController.getFavorite(context, user["id"]);

    print('info productsFavorite --->' '$productsFavoriteByUser');
    setState(() {});
    return productsFavoriteByUser;
  }

  @override
  void initState() {
    super.initState();
    favoriteProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(20, 116, 227, 1),
        iconTheme: new IconThemeData(color: Colors.white),
        title: Text('Mis favoritos',
            style: TextStyle(
              color: Colors.white,
            )),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(17.0),
        itemCount:
            productsFavoriteByUser == null ? 0 : productsFavoriteByUser.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              final productId = productsFavoriteByUser[index]["idProduct"];
              print(productId);
              final route = MaterialPageRoute(builder: (context) {
                return SwiperTarge(
                  productId: productId,
                );
              });
              Navigator.push(context, route);
            },
            child: Card(
              elevation: 5,
              child: Row(
                children: <Widget>[
                  Container(
                    height: 125,
                    width: 110,
                    padding: EdgeInsets.only(
                        left: 0, top: 10, bottom: 70, right: 20),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                productsFavoriteByUser[index]['url1']),
                            fit: BoxFit.cover)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          productsFavoriteByUser[index]['nameProduct'],
                          style: TextStyle(
                              color: Color.fromRGBO(20, 116, 227, 1),
                              fontWeight: FontWeight.w700,
                              fontSize: 17),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "costo: "
                          r"$"
                          "${productsFavoriteByUser[index]["cost"]}",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
