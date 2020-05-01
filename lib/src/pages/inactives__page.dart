import 'package:cached_network_image/cached_network_image.dart';
import 'package:easybuy_frontend/src/controllers/inactiveProduct.dart';
import 'package:easybuy_frontend/src/pages/updateProduct.dart';
import 'package:easybuy_frontend/src/providers/closeofferProvider.dart';
import 'package:easybuy_frontend/src/providers/inactiveProvider.dart';
import 'package:easybuy_frontend/src/providers/productsProvider.dart';
import 'package:easybuy_frontend/src/providers/userProductsProvider.dart';
import 'package:easybuy_frontend/src/utils/Session.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../providers/animatedBotomBar.dart';

class Productsinactives extends StatefulWidget {
  @override
  _ProductspageState createState() => _ProductspageState();
}

class _ProductspageState extends State<Productsinactives> {
  final InactiveProductsProvider products = InactiveProductsProvider();
  final UserProductsProvider product = UserProductsProvider();

  final CloseofferProvider closeoffer = CloseofferProvider();
  InactiveProductsController inactivesProductsController;
  List listproduc;
  List productsInactivesByUser;
  Map user;
  int id;
  Session session;
  ProgressDialog progressDialog;

  final primary = Colors.teal;
  final secondary = Color(0xFFFFA000);

  _ProductspageState() {
    session = new Session();
    _information();
  }

  void _information() async {
    user = await session.getInformation();
    id = int.parse(user["id"]);
    products.getproductInactive(id).then((resp) {
      setState(() {
        productsInactivesByUser = resp;
        print(productsInactivesByUser);
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
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Productos Inactivos',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(20, 116, 227, 1),
      ),
      body: ListView.builder(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(17.0),
          itemCount: productsInactivesByUser == null
              ? 0
              : productsInactivesByUser.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
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
                                          productsInactivesByUser[index]
                                              ['Url1']),
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
                                  productsInactivesByUser[index]['nameProduct'],
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
                                  "${productsInactivesByUser[index]["cost"]}",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
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
                                                                productsInactivesByUser[
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
                                                              title: Image(
                                                                  image: AssetImage(
                                                                      'assets/error.jpg')),
                                                              content: Text(
                                                                  "esta seguro que desea eliminarlo?"),
                                                              actions: <Widget>[
                                                                FlatButton(
                                                                  child: Text(
                                                                      "si"),
                                                                  onPressed:
                                                                      () async {
                                                                    await ProductsProvider()
                                                                        .deleteproducts(productsInactivesByUser[index]
                                                                            [
                                                                            "idProduct"])
                                                                        .then(
                                                                            (resp) {
                                                                      Navigator.pushNamedAndRemoveUntil(
                                                                          context,
                                                                          'inactives',
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
                                                                  },
                                                                ),
                                                                FlatButton(
                                                                  child: Text(
                                                                      "no"),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                )
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
                                                          "Republicar",
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
                          )
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

  void progress() {
    progressDialog = new ProgressDialog(context);
    progressDialog.style(
      message: 'Republicando oferta... ',
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

  Widget _alertCloseoffer(BuildContext context, index) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text(
              '¿Quieres activar tú producto?',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 15.0,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    final route = MaterialPageRoute(builder: (context) {
                      return FancyBottomBarPage();
                    });
                    Navigator.push(context, route);
                  },
                  child: Text(
                    'cancelar',
                    style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  )),
              FlatButton(
                  onPressed: () {
                    progress();
                    progressDialog.show();
                    Future.delayed(Duration(seconds: 2), () {
                      closeoffer.closeOffer(
                          productsInactivesByUser[index]["idProduct"],
                          {'idstate': 1}).then((res) {
                        Navigator.pushNamedAndRemoveUntil(context, 'inactives',
                            (Route<dynamic> route) {
                          print(route);
                          return route.isFirst;
                        });
                        setState(() {});
                      });
                    });
                  },
                  child: Text(
                    'activar producto',
                    style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  )),
            ],
          );
        });
  }
}
