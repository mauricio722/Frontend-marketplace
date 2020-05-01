import 'package:cached_network_image/cached_network_image.dart';
import 'package:easybuy_frontend/src/controllers/profileController.dart';
import 'package:easybuy_frontend/src/pages/FavoriteProducts_pages.dart';
import 'package:easybuy_frontend/src/pages/Navigation_page.dart';
import 'package:easybuy_frontend/src/pages/SoldHistory_page.dart';
import 'package:easybuy_frontend/src/pages/inactives__page.dart';
import 'package:easybuy_frontend/src/pages/products_page.dart';
import 'package:easybuy_frontend/src/pages/productsactives_pages.dart';
import 'package:easybuy_frontend/src/pages/swiper_targe.dart';
import 'package:easybuy_frontend/src/providers/navigationProvider.dart';
import 'package:easybuy_frontend/src/providers/offerProvider.dart';
import 'package:easybuy_frontend/src/providers/suggestionsProvider.dart';
import 'package:easybuy_frontend/src/utils/Session.dart';
import 'package:flutter/material.dart';
import '../providers/productsProvider.dart';
import '../search/search_delegate.dart';
import '../utils/network_image.dart';
import 'myshopping_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final NavigationProvider navigation = NavigationProvider();
  final SuggestionsProvider suggestion = SuggestionsProvider();
  final ProductsProvider products = ProductsProvider();
  OfferProvider offer = OfferProvider();
  List categories;
  List navigations;
  List maxnavigations;
  List suggestionsData = [];
  List productsuggestion = [];
  List suggestions = [];
  List category = [];
  final primary = Colors.teal;
  final secondary = Colors.yellow;
  ScrollController _scrollController;
  Session session;
  Map user;
  int idUser;
  ProfilePageController profileController;
  String name;

  _HomeState() {
    session = new Session();
    profileController = new ProfilePageController();

    //_scrollController = new ScrollController();
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

    offer.getcategorys().then((resp) {
      setState(() {
        categories = resp;
      });
    });

    navigation.getNavigation(idUser).then((resp) {
      setState(() {
        navigations = resp;
      });
    });

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
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.white),
        backgroundColor: Color.fromRGBO(20, 116, 227, 1),
        title: Text(
          'EasyBuy',
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: Drawer(
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
              leading:
                  Icon(Icons.payment, color: Colors.pinkAccent, size: 22.0),
              title: Text('Pagos Recibidos'),
              onTap: () {
                Navigator.pushNamed(context, 'PaymentReceived');
              },
            ),
            ListTile(
              leading:
                  Icon(Icons.vpn_key, color: Colors.blueAccent, size: 22.0),
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
      ),
      body: Container(
        color: Colors.black.withOpacity(0.03),
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
          const SizedBox(height: 10.0),
          GestureDetector(
            onTap: () {
              showSearch(
                context: context,
                delegate: Search(idUser),
              );
            },
            child: Container(
              width: 400,
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
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'buscar producto',
                          style: TextStyle(
                              color: Colors.black45,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 150),
                        child: Icon(Icons.search),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  'Te Puede Interesar',
                  style: TextStyle(
                      color: Colors.indigo,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0),
                ),
              ),
              Container(
                //padding: EdgeInsets.all(1.0),
                height: 200,
                width: 415,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: suggestions.length != 0
                      ? suggestions.length
                      : productsuggestion.length,
                  itemBuilder: (BuildContext context, int index) =>
                      GestureDetector(
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
                              height: 130,
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
                                        colors: [
                                      Colors.black,
                                      Colors.black12
                                    ])),
                              ),
                            ),
                            Positioned(
                              left: 10,
                              bottom: 10,
                              width: 145,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        suggestions.length == 0
                                            ? productsuggestion[index]
                                                ['nameProduct']
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
                                            : suggestions[index]['cost']
                                                .toString(),
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
              const SizedBox(height: 16.0),
              Text(
                'Categorias',
                style: TextStyle(
                    color: Colors.indigo,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0),
              ),
              categoriesss(idUser),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "visto recientemente",
                      style: TextStyle(
                          color: Colors.indigo,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              _builderNavigation(context),
              const SizedBox(height: 20.0),
            ],
          ),
        ])),
      ),
    );
  }

  Widget _builderNavigation(BuildContext context) {
    return Container(
      height: 400,
      margin: EdgeInsets.all(5.0),
      child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) =>
              SizedBox(width: 10.0),
          controller: _scrollController,
          // padding: EdgeInsets.all(17.0),
          itemCount: navigations == null ? 0 : navigations.length,
          itemBuilder: (BuildContext context, int index) =>
              card(context, navigations[index])),
    );
  }

  Widget card(BuildContext context, project) {
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
                          color: Colors.indigo,
                          fontWeight: FontWeight.w700,
                          fontSize: 17),
                    ),
                    Text(
                      "Celulares y tablets",
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

  Widget _initial() {
    print(suggestions);
    return Card(
      child: Container(
        child: Row(
          children: <Widget>[
            const SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('EasyBuy',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                      ),
                      textAlign: TextAlign.center),
                  Text('Compra Facil Compra Rapido',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 17.0,
                      ),
                      textAlign: TextAlign.justify),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              margin: EdgeInsets.only(left: 20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/jar-loading.gif'),
                image: NetworkImage(
                    'https://www.elcomercio.com/files/content_thumbnail_guaifai/uploads/2018/01/16/5a5e6e2162130.png'),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 0.0),
          ],
        ),
      ),
    );
  }

  IconData getIcon(int id) {
    switch (id) {
      case 1:
        return Icons.home;
        break;
      case 2:
        return Icons.shopping_basket;
        break;
      case 3:
        return Icons.spa;
        break;
      case 4:
        return Icons.child_friendly;
      case 5:
        return Icons.import_contacts;
      case 6:
        return Icons.music_note;
      case 7:
        return Icons.build;
      case 8:
        return Icons.phone_android;
      case 9:
        return Icons.fitness_center;
      case 10:
        return Icons.tv;
      default:
        return Icons.category;
    }
  }

  Widget categoriesss(idUser) {
    return Container(
      height: 100,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          vertical: 6.0,
          horizontal: 16.0,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: categories == null ? 0 : categories.length,
        itemBuilder: (context, index) {
          IconData icon = getIcon(categories[index]['idcategory']);

          return Column(
            children: <Widget>[
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Color.fromRGBO(27, 249, 12, 0)),
                  ),
                  child: IconButton(
                    icon: Icon(
                      icon,
                      color: Color.fromRGBO(20, 116, 227, 1),
                      size: 55.0,
                    ),
                    onPressed: () {
                      final idProduct = categories[index]["idcategory"];
                      final route = MaterialPageRoute(builder: (context) {
                        return Productspage(
                          idProduct: idProduct,
                        );
                      });
                      Navigator.push(context, route);
                    },
                  ),
                  height: 50,
                  width: 50,
                ),
                onTap: () {},
              ),
              const SizedBox(height: 5.0),
            ],
          );
        },
        separatorBuilder: (context, index) => SizedBox(
          width: 10.0,
        ),
      ),
    );
  }
}
