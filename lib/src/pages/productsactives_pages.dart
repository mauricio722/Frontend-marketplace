import 'package:cached_network_image/cached_network_image.dart';
import 'package:easybuy_frontend/src/controllers/userProductsController.dart';
import 'package:easybuy_frontend/src/pages/swiper_targe.dart';
import 'package:easybuy_frontend/src/pages/updateProduct.dart';
import 'package:easybuy_frontend/src/providers/closeofferProvider.dart';
import 'package:easybuy_frontend/src/providers/productsProvider.dart';
import 'package:easybuy_frontend/src/providers/userProductsProvider.dart';
import 'package:easybuy_frontend/src/utils/Session.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../providers/animatedBotomBar.dart';

class Productsactives extends StatefulWidget {
  @override
  _ProductspageState createState() => _ProductspageState();
}

class _ProductspageState extends State<Productsactives> {
  final UserProductsProvider products = UserProductsProvider();
  final CloseofferProvider closeoffer = CloseofferProvider();
  UserProductsController userProductsController;
  List listproduct;
  List productsByUser;
  int id;
  Map user;
  final primary = Colors.teal;
  final secondary = Color(0xFFFFA000);
  Session session;
  ProgressDialog progressDialog;

  _ProductspageState() {
    session = new Session();
    _information();
  }

  void _information() async {
    user = await session.getInformation();
    id = int.parse(user["id"]);
    products.getproduct(id).then((resp) {
      setState(() {
        productsByUser = resp;
      });
    });
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _information();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(20, 116, 227, 1),
        iconTheme: new IconThemeData(color: Colors.white),
        title: Text(
          'Productos Activos',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(17.0),
          itemCount: productsByUser == null ? 0 : productsByUser.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                final productId = productsByUser[index]["idProduct"];
                print(productId);
                final route = MaterialPageRoute(builder: (context) {
                  return SwiperTarge(
                    productId: productId,
                  );
                });
                Navigator.push(context, route);
              },
              child: Container(
                child: Card(
                  elevation: 5,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              height: 125,
                              width: 110,
                              padding: EdgeInsets.only(
                                  left: 0, top: 10, bottom: 70, right: 20),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          productsByUser[index]['Url1']),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "${productsByUser[index]["nameProduct"]}",
                                  style: TextStyle(
                                      color: Color.fromRGBO(20, 116, 227, 1),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "costo: " "${productsByUser[index]["cost"]}",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                        '                                                    '),
                                    PopupMenuButton(
                                        icon: Icon(
                                          Icons.menu,
                                          color:
                                              Color.fromRGBO(20, 116, 227, 1),
                                        ),
                                        itemBuilder: (context) => [
                                              PopupMenuItem(
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final route =
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                        return UpdateProduct(
                                                            product:
                                                                productsByUser[
                                                                    index]);
                                                      });
                                                      Navigator.push(
                                                          context, route);
                                                    },
                                                    child: Container(
                                                        child: Row(
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons.edit,
                                                          color:
                                                              Colors.green[300],
                                                        ),
                                                        SizedBox(
                                                          width: 3.0,
                                                        ),
                                                        Text(
                                                          "Editar",
                                                        ),
                                                      ],
                                                    ))),
                                                value: 1,
                                              ),
                                              PopupMenuItem(
                                                child: GestureDetector(
                                                    onTap: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              content: Text(
                                                                "está seguro que desea eliminarlo?",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontSize:
                                                                      17.0,
                                                                ),
                                                              ),
                                                              actions: <Widget>[
                                                                FlatButton(
                                                                  child: Text(
                                                                    "No",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .teal,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          17.0,
                                                                    ),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                ),
                                                                FlatButton(
                                                                  child: Text(
                                                                    "Si",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .teal,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          17.0,
                                                                    ),
                                                                  ),
                                                                  onPressed:
                                                                      () async {
                                                                    Future.delayed(
                                                                        Duration(
                                                                            seconds:
                                                                                2),
                                                                        () async {
                                                                      await ProductsProvider()
                                                                          .deleteproducts(productsByUser[index]
                                                                              [
                                                                              "idProduct"])
                                                                          .then(
                                                                              (resp) {
                                                                        Navigator.pushNamedAndRemoveUntil(
                                                                            context,
                                                                            'actives',
                                                                            (Route<dynamic>
                                                                                route) {
                                                                          print(
                                                                              route);
                                                                          return route
                                                                              .isFirst;
                                                                        });
                                                                        setState(
                                                                            () {});
                                                                      });
                                                                    });
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          });
                                                    },
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons.delete,
                                                          color: Colors.red,
                                                        ),
                                                        SizedBox(
                                                          width: 3.0,
                                                        ),
                                                        Text(
                                                          "Eliminar",
                                                        ),
                                                      ],
                                                    )),
                                                value: 1,
                                              ),
                                              PopupMenuItem(
                                                child: GestureDetector(
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons.close,
                                                          color: Colors.blue,
                                                        ),
                                                        SizedBox(
                                                          width: 3.0,
                                                        ),
                                                        Text(
                                                          "Cerrar Oferta",
                                                        ),
                                                      ],
                                                    ),
                                                    onTap: () {
                                                      _alertCloseoffer(
                                                          context, index);
                                                    }),
                                                value: 1,
                                              ),
                                            ]),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget _alertCloseoffer(BuildContext context, index) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text('¿Está seguro que desea cerrar esta oferta?'),
            content: Text(
                'Al presionar aceptar, el producto quedará inactivo, pero podrá volver a publicarlo en mis "productos inactivos"'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    final route = MaterialPageRoute(builder: (context) {
                      return FancyBottomBarPage();
                    });
                    Navigator.push(context, route);
                  },
                  child: Text('Cancelar')),
              FlatButton(
                  onPressed: () {
                    progress();
                    progressDialog.show();
                    Future.delayed(Duration(seconds: 2), () {
                      closeoffer.closeOffer(productsByUser[index]["idProduct"],
                          {'idstate': 2}).then((rep) {
                        Navigator.pushNamedAndRemoveUntil(context, 'actives',
                            (Route<dynamic> route) {
                          print(route);
                          return route.isFirst;
                        });
                        setState(() {});
                      });
                    });
                  },
                  child: Text('Cerrar Oferta')),
            ],
          );
        });
  }

  void progress() {
    progressDialog = new ProgressDialog(context);
    progressDialog.style(
      message: 'Cerrando oferta... ',
      borderRadius: 06.0,
      backgroundColor: Colors.white,
      progressWidget: SizedBox(
        width: 10.0,
        height: 10.0,
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.teal),
          strokeWidth: 2.0,
        ),
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
