import 'package:cached_network_image/cached_network_image.dart';
import 'package:easybuy_frontend/src/controllers/NavigationController.dart';
import 'package:easybuy_frontend/src/controllers/inactiveProduct.dart';
import 'package:easybuy_frontend/src/controllers/profileController.dart';
import 'package:easybuy_frontend/src/controllers/userProductsController.dart';
import 'package:easybuy_frontend/src/pages/FavoriteProducts_pages.dart';
import 'package:easybuy_frontend/src/pages/Navigation_page.dart';
import 'package:easybuy_frontend/src/pages/SoldHistory_page.dart';
import 'package:easybuy_frontend/src/pages/inactives__page.dart';
import 'package:easybuy_frontend/src/pages/myshopping_page.dart';
import 'package:easybuy_frontend/src/pages/productsactives_pages.dart';
import 'package:easybuy_frontend/src/pages/swiper_targe.dart';
import 'package:easybuy_frontend/src/providers/navigationProvider.dart';
import 'package:easybuy_frontend/src/providers/productsProvider.dart';
import 'package:easybuy_frontend/src/search/search_delegate.dart';
import 'package:easybuy_frontend/src/utils/Session.dart';
import 'package:easybuy_frontend/src/utils/alert_EmpyCategory.dart';
import 'package:easybuy_frontend/src/utils/network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class Productspage extends StatefulWidget {
  final int idProduct;

  Productspage({this.idProduct});

  @override
  _ProductspageState createState() =>
      _ProductspageState(idProduct: this.idProduct);
}

class _ProductspageState extends State<Productspage> {
  final ProductsProvider products = ProductsProvider();
  NavigationProvider navigator;

  int idProduct;

  List data;
  List listproduct = [];
  AlertCategory alertCategory;
  int idUser;
  List productsByUser;
  List productsInactivesByUser;
  NavigationController navigationController;
  Session session;
  Map user;
  ProfilePageController profileController;
  String nameCategory = '';
  String name;

  int idProject;
  final primary = Colors.teal;
  final secondary = Color(0xFFFFA000);

  _ProductspageState({this.idProduct}) {
    this.alertCategory = AlertCategory();
    navigator = new NavigationProvider();
    session = new Session();
    getProductos();
  }

  void loadInformation() {
    session.getInformation().then((user) {
      profileController.getUserInformation(user['email']).then((res) {
        setState(() {
          print('info---->' '$res');
          name = res['name'];
        });
      }).catchError((err) async {
        loadInformation();
      });
    });
  }

  Future getProductsByUser() async {
    user = await session.getInformation();
    idUser = int.parse(user["id"]);
    print(idUser);
    UserProductsController().getProductsidUser(context, idUser).then((res) {
      productsByUser = res;

      print(productsByUser);
    });
  }

  Future getProductsInactivesByUser() async {
    InactiveProductsController().getProductsidUser(context, idUser).then((res) {
      productsInactivesByUser = res;

      print(productsInactivesByUser);
    });
  }

  Future getProductos() async {
    listproduct = await products.getproduct(idProduct);
    print(listproduct);

    if (listproduct.length == 0) {
      alertCategory.errorAlert(context,
          "Lo sentimos, en el momento no hay productos disponibles para esta categoría");
    }

    switch (idProduct) {
      case 1:
        nameCategory = 'Hogar';
        break;

      case 2:
        nameCategory = 'Moda';
        break;
      case 3:
        nameCategory = 'Belleza y cuidado';
        break;
      case 4:
        nameCategory = 'Juguetes y bebes';
        break;
      case 5:
        nameCategory = 'libros';
        break;
      case 6:
        nameCategory = 'Instrumentos musicales';
        break;
      case 7:
        nameCategory = 'Herramientas y industria';
        break;
      case 8:
        nameCategory = 'Celulares y tablets';
        break;
      case 9:
        nameCategory = 'Deportes';
        break;
      case 10:
        nameCategory = 'Electrodomesticos';
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getProductsByUser();
    getProductos();
    getProductsInactivesByUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(20, 116, 227, 1),
          iconTheme: new IconThemeData(color: Colors.white),
          elevation: 0,
          title: Text(
            nameCategory,
            style: TextStyle(color: Colors.white),
          ),
        ),
        //drawer: drawer(context),
        body: card(context));
  }

  Widget card(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(6),
      itemCount: listproduct.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            final int productId = listproduct[index]["idProduct"];
            final int cost = listproduct[index]["cost"];
            final int idstate = listproduct[index]["idstate"];
            navigator.createNavigation({
              'idProduct': productId,
              'idusuario': idUser,
              'idCategory': idProduct,
              'cost': cost,
              'idstate': idstate
            });
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
                  padding:
                      EdgeInsets.only(left: 0, top: 10, bottom: 70, right: 20),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              listproduct[index]['Url1']),
                          fit: BoxFit.cover)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        listproduct[index]['nameProduct'],
                        style: TextStyle(
                            color: Color.fromRGBO(20, 116, 227, 1),
                            fontWeight: FontWeight.w700,
                            fontSize: 17),
                      ),
                      Text(
                        nameCategory,
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      Text(
                        "costo: " "${listproduct[index]["cost"]}",
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
    );
  }

  Widget drawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill, image: AssetImage('assets/drawer.jpg')),
            ),
            accountName: Text("Hola",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                )),
            accountEmail: Text(
              '$name',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                height: 1,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.check_circle, color: Colors.teal, size: 22.0),
            title: Text('Productos Activos'),
            onTap: () {
              final route = MaterialPageRoute(builder: (context) {
                return Productsactives();
              });
              Navigator.push(context, route);
            },
          ),
          ListTile(
            leading: Icon(Icons.error, color: Colors.orange, size: 22.0),
            title: Text('Productos Inactivos'),
            onTap: () {
              final route = MaterialPageRoute(builder: (context) {
                return Productsinactives();
              });
              Navigator.push(context, route);
            },
          ),
          ListTile(
            leading: Icon(Icons.local_mall, color: Colors.blue, size: 22.0),
            title: Text('Mis Compras'),
            onTap: () {
              final route = MaterialPageRoute(builder: (context) {
                return Myshopping(
                  idUser: idUser,
                );
              });
              Navigator.push(context, route);
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite, color: Colors.red, size: 22.0),
            title: Text('Mis Favoritos'),
            onTap: () {
              final route = MaterialPageRoute(builder: (context) {
                return FavoriteProductsPage();
              });
              Navigator.push(context, route);
            },
          ),
          ListTile(
            leading: Icon(Icons.monetization_on,
                color: Colors.yellow[600], size: 22.0),
            title: Text('Historial De Ventas'),
            onTap: () {
              final route = MaterialPageRoute(builder: (context) {
                return SoldHistoryPage(
                  idUser: idUser,
                );
              });
              Navigator.push(context, route);
            },
          ),
          ListTile(
            leading:
                Icon(Icons.remove_red_eye, color: Colors.indigo, size: 22.0),
            title: Text('Historial de productos vistos'),
            onTap: () {
              final route = MaterialPageRoute(builder: (context) {
                return Navigation(
                  idUser: idUser,
                );
              });
              Navigator.push(context, route);
            },
          ),
          ListTile(
            leading: Icon(Icons.payment, color: Colors.pinkAccent, size: 22.0),
            title: Text('Pagos Recibidos'),
            onTap: () {
              Navigator.pushNamed(context, 'PaymentReceived');
            },
          ),
          ListTile(
            leading: Icon(Icons.vpn_key, color: Colors.blueAccent, size: 22.0),
            title: Text('Cambiar contraseña'),
            onTap: () {
              Navigator.pushNamed(context, 'changepass');
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.brown, size: 22.0),
            title: Text('Cerrar Sesión'),
            onTap: () {
              session.close(context);
            },
          ),
        ],
      ),
    );
  }
}
