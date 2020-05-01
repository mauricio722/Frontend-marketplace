import 'package:cached_network_image/cached_network_image.dart';
import 'package:easybuy_frontend/src/controllers/myshoppingController.dart';
import 'package:easybuy_frontend/src/pages/shopping.dart';
import 'package:easybuy_frontend/src/pages/swiper_targe.dart';
import 'package:easybuy_frontend/src/providers/myshoppingProvider.dart';
import 'package:flutter/material.dart';

class Myshopping extends StatefulWidget {
  final int idUser;

  Myshopping({this.idUser});

  @override
  _ProductspageState createState() => _ProductspageState(idUser: idUser);
}

class _ProductspageState extends State<Myshopping> {
  final MyShoppingProvider products = MyShoppingProvider();
  MyshoppingController myshoppingController;
  int idProduct;
  List myshopping;
  List data;
  int idUser;
  final primary = Colors.teal;
  final secondary = Color(0xFFFFA000);

  _ProductspageState({this.idUser});

  Future myShopping() async {
    myshoppingController = new MyshoppingController();

    myshopping = await myshoppingController.myshopping(context, idUser);

    setState(() {});
    return myshopping;
  }

  @override
  void initState() {
    super.initState();
    myShopping();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.white),
        backgroundColor: Color.fromRGBO(20, 116, 227, 1),
        title: Text(
          'Mis compras',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(17.0),
        itemCount: myshopping == null ? 0 : myshopping.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
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
                                myshopping[index]['url1']),
                            fit: BoxFit.cover)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          myshopping[index]['nameProduct'],
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
                          "${myshopping[index]["cost"]}",
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
