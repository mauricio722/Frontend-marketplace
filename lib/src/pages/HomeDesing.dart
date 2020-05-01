import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easybuy_frontend/src/controllers/profileController.dart';
import 'package:easybuy_frontend/src/pages/FavoriteProducts_pages.dart';
import 'package:easybuy_frontend/src/pages/Navigation_page.dart';
import 'package:easybuy_frontend/src/pages/SoldHistory_page.dart';
import 'package:easybuy_frontend/src/pages/categorys_page.dart';
import 'package:easybuy_frontend/src/pages/inactives__page.dart';
import 'package:easybuy_frontend/src/pages/myshopping_page.dart';
import 'package:easybuy_frontend/src/pages/products_page.dart';
import 'package:easybuy_frontend/src/pages/productsactives_pages.dart';
import 'package:easybuy_frontend/src/pages/swiper_targe.dart';
import 'package:easybuy_frontend/src/providers/navigationProvider.dart';
import 'package:easybuy_frontend/src/providers/productsProvider.dart';
import 'package:easybuy_frontend/src/providers/suggestionsProvider.dart';
import 'package:easybuy_frontend/src/search/search_delegate.dart';
import 'package:easybuy_frontend/src/utils/Session.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../utils/network_image.dart';

class ProfileSevenPage extends StatefulWidget {
  static final String path = "lib/src/pages/profile/profile7.dart";

  @override
  _ProfileSevenPageState createState() => _ProfileSevenPageState();
}

class _ProfileSevenPageState extends State<ProfileSevenPage> {
  final NavigationProvider navigation = NavigationProvider();
  final SuggestionsProvider suggestion = SuggestionsProvider();
  final ProductsProvider products = ProductsProvider();

  List suggestionsData = [];
  List productsuggestion = [];
  List suggestions = [];
  List navigations = [];
  Session session;
  int idUser;
  Map user;
  String name;
  ProfilePageController profileController;
  String nameCategory = '';

  _ProfileSevenPageState() {
    session = new Session();
    profileController = new ProfilePageController();
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

  Future _session() async {
    user = await session.getInformation();

    idUser = int.parse(user["id"]);

    suggestion.getSuggestions(idUser).then((resp) {
      setState(() {
        suggestions = resp;
      });
    });

    products.getproduct(8).then((resp) {
      setState(() {
        productsuggestion = resp;
      });
    });

    navigation.getNavigation(idUser).then((resp) {
      setState(() {
        navigations = resp;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _session();
    loadInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
        appBar: AppBar(
          centerTitle: true,
          iconTheme: new IconThemeData(color: Colors.white),
          backgroundColor: Color.fromRGBO(20, 116, 227, 1),
          elevation: 0.0,
          title: Text(
            'EasyBuy',
            style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),
        ),
        drawer: drawer(context),
        //backgroundColor: Color.fromRGBO(255, 255, 255, .9),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(15.0),
                    width: double.infinity,
                    height: 330,
                    color: Color.fromRGBO(20, 116, 227, 1),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        height: 90,
                        margin: EdgeInsets.only(top: 60),
                        child: GestureDetector(
                          onTap: () {
                            showSearch(
                              context: context,
                              delegate: Search(idUser),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(15.0),
                            child: Card(
                              elevation: 5.0,
                              child: Container(
                                padding: EdgeInsets.all(0.0),
                                width: 320,
                                height: 50,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      child: Container(
                                        margin: EdgeInsets.fromLTRB(
                                            10.0, 0.0, 0.0, 0.0),
                                        child: Text(
                                          'buscar producto',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.0),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 200),
                                      child: Icon(Icons.search),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                          width: 400,
                          height: 290,
                          padding: EdgeInsets.all(20.0),
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              elevation: 10.0,
                              child: _buildCategories())),
                    ],
                  )
                ],
              ),
              sugerencias(context),
              Text(
                "visto recientemente",
                style: TextStyle(
                    color: Colors.blue,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0),
              ),
              _builderNavigation(context),
            ],
          ),
        ));
  }

  Widget _builderNavigation(BuildContext context) {
    return Container(
      height: 400,
      margin: EdgeInsets.all(5.0),
      child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) =>
              SizedBox(width: 10.0),
          // controller: _scrollController,
          // padding: EdgeInsets.all(17.0),
          itemCount: navigations.length == 0 || navigations.length == null
              ? 0
              : navigations.length,
          itemBuilder: (BuildContext context, int index) =>
              card(context, navigations[index])),
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

  Widget _buildCategories() {
    return Container(
      height: 300,
      child: GridView.count(
        // padding: EdgeInsets.only(left: 10.0, right: 10.0),
        scrollDirection: Axis.vertical,
        crossAxisCount: 3,

        children: <Widget>[
          GestureDetector(
            onTap: () {
              final idProduct = 1;
              final route = MaterialPageRoute(builder: (context) {
                return Productspage(
                  idProduct: idProduct,
                );
              });
              Navigator.push(context, route);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Category(
                backgroundColor: Colors.pink,
                color: Colors.white,
                icon: FontAwesomeIcons.couch,
                title: "Hogar",
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              final idProduct = 2;
              final route = MaterialPageRoute(builder: (context) {
                return Productspage(
                  idProduct: idProduct,
                );
              });
              Navigator.push(context, route);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Category(
                backgroundColor: Colors.blue,
                color: Colors.white,
                title: "Moda",
                icon: FontAwesomeIcons.tshirt,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              final idProduct = 3;
              final route = MaterialPageRoute(builder: (context) {
                return Productspage(
                  idProduct: idProduct,
                );
              });
              Navigator.push(context, route);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Category(
                icon: FontAwesomeIcons.female,
                color: Colors.white,
                backgroundColor: Colors.orange,
                title: "Belleza",
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              final idProduct = 4;
              final route = MaterialPageRoute(builder: (context) {
                return Productspage(
                  idProduct: idProduct,
                );
              });
              Navigator.push(context, route);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Category(
                icon: FontAwesomeIcons.dice,
                color: Colors.white,
                backgroundColor: Colors.indigo,
                title: "juguetes",
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              final idProduct = 9;
              final route = MaterialPageRoute(builder: (context) {
                return Productspage(
                  idProduct: idProduct,
                );
              });
              Navigator.push(context, route);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Category(
                icon: FontAwesomeIcons.footballBall,
                color: Colors.white,
                backgroundColor: Colors.green,
                title: "Deportes",
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              final route = MaterialPageRoute(builder: (context) {
                return CategoriesPage();
              });
              Navigator.push(context, route);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Category(
                icon: Icons.add,
                color: Colors.grey,
                backgroundColor: Colors.white,
                title: "Ver mas ",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sugerencias(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        padding: EdgeInsets.all(5.0),
        child: Text(
          'Te Puede Interesar',
          style: TextStyle(
              color: Color.fromRGBO(20, 116, 227, 1),
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: 17.0),
        ),
      ),
      Container(
        //padding: EdgeInsets.all(1.0),
        height: 200,
        width: double.infinity,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: suggestions.length != 0
              ? suggestions.length
              : productsuggestion.length,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
            onTap: () {
              if (suggestions.length == 0) {
                final idproduct = productsuggestion[index]['idProduct'];
                final route = MaterialPageRoute(builder: (context) {
                  return SwiperTarge(
                    productId: idproduct,
                  );
                });
                Navigator.push(context, route);
              } else {
                final idproduct = suggestions[index]['idProduct'];
                final route = MaterialPageRoute(builder: (context) {
                  return SwiperTarge(
                    productId: idproduct,
                  );
                });
                Navigator.push(context, route);
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: 140,
                      height: 180,
                      child: PNetworkImage(
                        suggestions.length == 0
                            ? productsuggestion[index]['Url1']
                            : suggestions[index]['url1'].toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      width: 160,
                      height: 60,
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [Colors.black, Colors.black12])),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      bottom: 10,
                      width: 145,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                suggestions.length == 0
                                    ? productsuggestion[index]['nameProduct']
                                    : suggestions[index]['nameProduct'],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1),
                              ),
                              Text(
                                suggestions.length == 0
                                    ? productsuggestion[index]['cost']
                                        .toString()
                                    : suggestions[index]['cost'].toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  Widget card(BuildContext context, project) {

      switch (project['idcategory']) {
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
    return GestureDetector(
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
                            project['url1'].toString()),
                        fit: BoxFit.cover)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      project["nameProduct"],
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w700,
                          fontSize: 17),
                    ),
                    Text(
                      nameCategory,
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    Text(
                      "costo: " "${project["cost"].toString()}",
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
        onTap: () {
          if (!(project["idstate"] == 3)) {
            final productId = project["idProduct"];
            final route = MaterialPageRoute(builder: (context) {
              return SwiperTarge(
                productId: productId,
              );
            });
            Navigator.push(context, route);
          } else {
            print("vendida");
          }
        });
  }
}

class Category extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final Color backgroundColor;

  const Category(
      {Key key,
      @required this.icon,
      @required this.title,
      @required this.color,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        margin: EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: color,
            ),
            SizedBox(
              height: 5.0,
            ),
            Flexible(
                child: Text(title,
                    style: TextStyle(
                      color: color,
                    )))
          ],
        ),
      ),
    );
  }
}
