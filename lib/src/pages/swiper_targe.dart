import 'package:easybuy_frontend/src/controllers/FavoriteProductsController.dart';
import 'package:easybuy_frontend/src/controllers/myshoppingController.dart';
import 'package:easybuy_frontend/src/pages/PhotoViewPage.dart';
import 'package:easybuy_frontend/src/pages/updateProduct.dart';
import 'package:easybuy_frontend/src/providers/PaymentsProviders.dart';
import 'package:easybuy_frontend/src/providers/getTokenProvider.dart';
import 'package:easybuy_frontend/src/providers/getUserProvider.dart';
import 'package:easybuy_frontend/src/providers/sendnotificationsProvider.dart';
import 'package:easybuy_frontend/src/utils/Session.dart';
import 'package:easybuy_frontend/src/utils/network_image.dart';
import 'package:easybuy_frontend/src/utils/token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../providers/SwiperProvider.dart';

class SwiperTarge extends StatefulWidget {
  final int productId;
  SwiperTarge({
    this.productId,
  });
  @override
  _SwiperTargeState createState() =>
      _SwiperTargeState(productId: this.productId);
}

class _SwiperTargeState extends State<SwiperTarge> {
  bool isMyProduct;
  SwiperProvider swiper = SwiperProvider();
  GetTokenProvider gettoken = GetTokenProvider();
  UserProvider userprovider = UserProvider();
  SendNotificationsProvider notification = new SendNotificationsProvider();
  int productId;
  List productdetails;
  List dataUser;
  List nameUser;
  int idUser;
  MyshoppingController myshoppingController;
  PaymentsProviders paymentsProviders;
  Token token;
  Map favoriteProductsData;
  FavoriteProductsController favoriteProductsController;
  List<dynamic> favoriteProducts;
  ProgressDialog progressDialog;
  final List images = [];
  Session session;
  Map user;
  Map favoriteUser;

  _SwiperTargeState({this.productId}) {
    isMyProduct = false;
    paymentsProviders = new PaymentsProviders();
    token = new Token();
    session = new Session();
    favoriteProductsController = FavoriteProductsController();
    myshoppingController = MyshoppingController();

    session.getInformation().then((user) {
      idUser = int.parse(user["id"]);
    });

    print(productId);

    getFavoriteProducts();
  }

  Future getFavoriteProducts() async {
    user = await session.getInformation();

    swiper.getproductdetail(productId).then((res) {
      setState(() {
        idUser = int.parse(user["id"]);

        isMyProduct = res[0]['idusuario'] == idUser;

        productdetails = res;
        for (var data in productdetails) {
          images.add(data["Url1"]);
          images.add(data["Url2"]);
          images.add(data["Url3"]);

          print(images);
        }
        print(productdetails);
      });
    });
  }

  Future sendData() async {
    await userprovider.getUsers(idUser).then((resp) {
      nameUser = resp;
    });

    token.setString('nameUser', nameUser[0]['name']);
    token.setString('lastName', nameUser[0]['lastName']);
  }

  Future<bool> isSaved(int idUser, int idProduct) async {
    favoriteUser = await favoriteProductsController.getFavoriteByProductAndUser(
        idUser, idProduct);

    return favoriteUser != null && favoriteUser.isNotEmpty;
  }

  void removeItem(int id) async {
    favoriteProductsController.deleteFavorite(id);
  }

  void saveItem(BuildContext context, Map datos) async {
    favoriteProductsController.createFavorite(context, datos);
  }

  @override
  void initState() {
    super.initState();

    getFavoriteProducts();
    // _informationFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromRGBO(20, 116, 227, 1),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: check(),
          )
        ],
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: productdetails == null ? 0 : productdetails.length,
        itemBuilder: (BuildContext context, int index) => _card(context, index),
      ),
    );
  }

  Widget _card(BuildContext context, int index) {
    print(images[0]);
    return GestureDetector(
      onTap: () {
        final route = MaterialPageRoute(builder: (context) {
          return PhotoViewPage(images: images);
        });
        Navigator.push(context, route);
      },
      child: Container(
        child: Stack(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Container(
                height: 600,
                color: Colors.teal[50],
                child: Swiper(
                  itemCount: images.length,
                  itemBuilder: (BuildContext context, int index) {
                    print("#" "##");
                    print(index);

                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: PNetworkImage(
                        images[index],
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                  itemWidth: 300,
                  layout: SwiperLayout.STACK,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(16.0, 280.0, 16.0, 16.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0)),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${productdetails[index]["nameProduct"]}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    r"$" "${productdetails[index]["cost"]}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  SizedBox(height: 10.0),
                  Divider(),
                  SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "${productdetails[index]["characteristics"]}",
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  InkWell(
                    onTap: () {
                      if (isMyProduct) {
                        final route = MaterialPageRoute(builder: (context) {
                          return UpdateProduct(
                              product: productdetails[0], idUser: idUser);
                        });
                        Navigator.push(context, route);
                      } else {
                        progress();
                        progressDialog.show();

                        paymentsProviders.pay({
                          'idusuario': idUser,
                          'idProduct': productdetails[0]['idProduct'],
                          'price': productdetails[0]['cost'],
                          'name': 'Compra',
                          'total': productdetails[0]['cost'],
                          'description': productdetails[0]['characteristics']
                        }).then((url) async {
                          print(url);
                          token.setString('url', url);
                          token.setNumber(
                              'idProduct', productdetails[0]['idProduct']);
                          token.setNumber('idUser', idUser);
                          token.setNumber('idUser', idUser);
                          token.setNumber(
                              'idDealer', productdetails[0]['idusuario']);
                          token.setNumber(
                              'costProduct', productdetails[0]['cost']);
                          print(url);

                          gettoken
                              .getToken(productdetails[0]['idusuario'])
                              .then((resp) {
                            setState(() {
                              dataUser = resp;

                              print('//////////////////////////////');
                              print(dataUser[0]['deviceToken']);
                              print('//////////////////////////////');

                              token.setString(
                                  'deviceToken', dataUser[0]['deviceToken']);
                            });
                          });

                          Future.delayed(Duration(seconds: 3)).then((value) {
                            Navigator.pushReplacementNamed(context, 'Payments');
                          });
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(20, 116, 227, 1),
                              Color.fromRGBO(20, 116, 227, 1)
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 5.0,
                                color: Color.fromRGBO(20, 116, 227, 1))
                          ]),
                      child: Row(
                        children: <Widget>[
                          Spacer(),
                          !isMyProduct
                              ? Text(
                                  'Comprar',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 21),
                                )
                              : Text(
                                  'Editar',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 21),
                                ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget check() {
    return FutureBuilder(
        future: isSaved(idUser, productId),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          print("asadas");
          print(snapshot.data);
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
            case ConnectionState.active:
              return Icon(Icons.favorite_border);
            case ConnectionState.done:
              return GestureDetector(
                child: Icon(
                  snapshot.data ? Icons.favorite : Icons.favorite_border,
                  color: snapshot.data ? Colors.red : null,
                ),
                onTap: () {
                  print(snapshot.data);
                  if (snapshot.data) {
                    print("paso por aca");
                    print(favoriteUser);

                    removeItem(favoriteUser["id"]);
                  } else {
                    saveItem(
                        context, {'idProduct': productId, 'idusuario': idUser});
                    print("po aca");
                  }
                  setState(() {});
                },
              );
          }
        });
  }

  void progress() {
    progressDialog = new ProgressDialog(context);
    progressDialog.style(
      message: 'Espere Por Favor',
      borderRadius: 15.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.teal),
      ),
      elevation: 20.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w300),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 17.0, fontWeight: FontWeight.w300),
    );
  }
}
