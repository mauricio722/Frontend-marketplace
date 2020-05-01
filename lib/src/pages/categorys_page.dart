import 'package:easybuy_frontend/src/controllers/myshoppingController.dart';
import 'package:easybuy_frontend/src/controllers/profileController.dart';
import 'package:easybuy_frontend/src/pages/FavoriteProducts_pages.dart';
import 'package:easybuy_frontend/src/pages/Navigation_page.dart';
import 'package:easybuy_frontend/src/pages/SoldHistory_page.dart';
import 'package:easybuy_frontend/src/pages/inactives__page.dart';
import 'package:easybuy_frontend/src/pages/myshopping_page.dart';
import 'package:easybuy_frontend/src/pages/productsactives_pages.dart';
import 'package:easybuy_frontend/src/providers/categoriesProvider.dart';
import 'package:easybuy_frontend/src/utils/Session.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:convert';
import '../config/UrlConfig.dart';
import '../search/search_delegate.dart';
import '../utils/HttpClient.dart';
import 'products_page.dart';

class CategoriesPage extends StatefulWidget {
  CategoriesPage();

  @override
  _CategoriesPage createState() => _CategoriesPage();
}

class _CategoriesPage extends State<CategoriesPage> {
  List data;
  List categoriesData;
  List productsByUser;
  List productsInactivesByUser;
  List myshopping;
  Session session;
  Map user;
  int idUser;
  String name;
  ProfilePageController profileController;

  String _url = UrlConfig().getUri();
  var cat = {};

  _CategoriesPage() {
    session = new Session();
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

  Future myShopping() async {
    user = await session.getInformation();
    print('info------->' '$user');

    idUser = int.parse(user["id"]);
    MyshoppingController().myshopping(context, user["id"]).then((res) {
      myshopping = res;
      print(productsInactivesByUser);
    });
  }

  CategoriesProvider categoriesProvider;

  getCategories() async {
    categoriesProvider = new CategoriesProvider();
    HttpClient client = new HttpClient();
    http.Response response = await client.get('$_url/categories');
    print(response.body);
    data = json.decode(response.body);

    setState(() {
      categoriesData = data;
    });
  }

  @override
  void initState() {
    super.initState();

    getCategories();
    myShopping();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Categorias',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          //iconTheme: new IconThemeData(color: Colors.white),
          backgroundColor: Color.fromRGBO(20, 116, 227, 1),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              color: Colors.white,
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: Search(idUser),
                );
              },
            )
          ],
          iconTheme: new IconThemeData(color: Colors.white),
        ),
        body: Container(
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
                    backgroundColor: Colors.cyan,
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
                    icon: FontAwesomeIcons.basketballBall,
                    color: Colors.white,
                    backgroundColor: Colors.green,
                    title: "Deportes",
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  final idProduct = 5;
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
                    icon: FontAwesomeIcons.bookOpen,
                    color: Colors.white,
                    backgroundColor: Colors.pink,
                    title: "Libros ",
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  final idProduct = 6;
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
                    icon: FontAwesomeIcons.guitar,
                    color: Colors.white,
                    backgroundColor: Colors.purple,
                    title: "Musica ",
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  final idProduct = 7;
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
                    icon: FontAwesomeIcons.tools,
                    color: Colors.white,
                    backgroundColor: Colors.teal,
                    title: "Herramientas",
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  final idProduct = 8;
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
                    icon: FontAwesomeIcons.mobileAlt,
                    color: Colors.white,
                    backgroundColor: Colors.blueGrey,
                    title: "Celulares ",
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  final idProduct = 10;
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
                    icon: FontAwesomeIcons.tv,
                    color: Colors.white,
                    backgroundColor: Colors.redAccent,
                    title: "Electrodomesticos",
                  ),
                ),
              ),
            ],
          ),
        ));
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
                child:
                    Text(title, style: TextStyle(color: color, fontSize: 9.8)))
          ],
        ),
      ),
    );
  }
}
