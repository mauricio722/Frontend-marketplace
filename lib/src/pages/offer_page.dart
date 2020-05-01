import 'dart:io';
import 'package:easybuy_frontend/src/pages/Navigation_page.dart';
import 'package:easybuy_frontend/src/pages/SoldHistory_page.dart';
import 'package:easybuy_frontend/src/providers/animatedBotomBar.dart';
import 'package:easybuy_frontend/src/providers/offerProvider.dart';
import 'package:easybuy_frontend/src/utils/Session.dart';
import 'package:easybuy_frontend/src/utils/token.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easybuy_frontend/src/utils/Utils.dart' as utils;
import 'package:progress_dialog/progress_dialog.dart';

import '../search/search_delegate.dart';
import 'FavoriteProducts_pages.dart';
import 'inactives__page.dart';
import 'myshopping_page.dart';
import 'productsactives_pages.dart';
import 'package:easybuy_frontend/src/controllers/profileController.dart';

class OfferPage extends StatefulWidget {
  @override
  _OfferPage createState() => _OfferPage();
}

class _OfferPage extends State<OfferPage> {
  final formkey = GlobalKey<FormState>();
  final OfferProvider category = OfferProvider();
  Iterable<dynamic> iteratorCategories = [];
  String opcionseleccionada = 'categorias ';
  OfferProvider offer;
  List categorias;
  List productsByUser;
  ProgressDialog progressDialog;
  Session session;

  int idcategory;
  Map productss;
  String opts;
  String url1;
  String url2;
  String url3;
  File foto1;
  File foto2;
  File foto3;
  Token token;
  int idUser;
  Map user;

  TextEditingController nameproduct;
  TextEditingController characteristics;
  TextEditingController cost;
  TextEditingController categorys;
  TextEditingController image1;
  TextEditingController image2;
  TextEditingController image3;
  ProfilePageController profileController;
  String name;

  _OfferPage() {
    session = new Session();
    this.nameproduct = TextEditingController();
    this.categorys = TextEditingController();
    this.cost = TextEditingController();
    this.characteristics = TextEditingController();
    this.image1 = TextEditingController();
    this.image2 = TextEditingController();
    this.image3 = TextEditingController();
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

    categorias = [];

    category.getcategorys().then((res) {
      setState(() {
        iteratorCategories = res;
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
        title: Text(
          'Crear Oferta',
          style: TextStyle(
            color: Colors.white,
            backgroundColor: Color.fromRGBO(20, 116, 227, 1),
          ),
        ),
        iconTheme: new IconThemeData(color: Colors.white),
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Card(
                  color: Colors.white,
                  child: Column(
                    key: formkey,
                    children: <Widget>[
                      _images(),
                      _nameProduct(),
                      _cost(),
                      _characteristics(),
                      _categorys(),
                      _createbutton(),
                    ],
                  ),
                ),
              ],
            ),
          ],
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
              accountName: Text(
                "Hola",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
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
    );
  }

  Widget _nameProduct() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Form(
        child: new Theme(
          data: new ThemeData(
            primaryColor: Colors.teal,
            primaryColorDark: Colors.teal,
          ),
          child: new TextFormField(
            controller: nameproduct,
            decoration: new InputDecoration(
                border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: new BorderSide(color: Colors.blue)),
                labelText: 'Nombre del Producto',
                prefixIcon: const Icon(
                  Icons.edit,
                  color: Color.fromRGBO(20, 116, 227, 1),
                ),
                prefixText: ' ',
                suffixStyle: const TextStyle(color: Colors.green)),
          ),
        ),
      ),
    );
  }

  Widget _characteristics() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Form(
        child: new Theme(
          data: new ThemeData(
            primaryColor: Colors.teal,
            primaryColorDark: Colors.teal,
          ),
          child: new TextFormField(
            controller: characteristics,
            autofocus: false,
            maxLines: 7,
            textCapitalization: TextCapitalization.sentences,
            decoration: new InputDecoration(
                border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: new BorderSide(color: Colors.blue)),
                labelText: 'caracteristicas',
                prefixIcon: const Icon(
                  Icons.local_mall,
                  color: Color.fromRGBO(20, 116, 227, 1),
                ),
                prefixText: ' ',
                suffixStyle: const TextStyle(color: Colors.teal)),
          ),
        ),
      ),
    );
  }

  Widget _cost() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Form(
        child: new Theme(
          data: new ThemeData(
            primaryColor: Colors.teal,
            primaryColorDark: Colors.teal,
          ),
          child: new TextFormField(
            keyboardType: TextInputType.numberWithOptions(decimal: false),
            controller: cost,
            decoration: new InputDecoration(
                border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: new BorderSide(color: Colors.blue)),
                labelText: 'Precio',
                prefixIcon: const Icon(
                  Icons.monetization_on,
                  color: Color.fromRGBO(20, 116, 227, 1),
                ),
                suffixStyle: const TextStyle(color: Colors.teal)),
            validator: (value) {
              if (utils.isNumeric(value)) {
                return null;
              } else {
                return 'solo numeros';
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _categorys() {
    return Container(
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 6.0, vertical: 20.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Center(
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            isExpanded: false,
                            hint: Text(opcionseleccionada),
                            items: iteratorCategories.map((category) {
                              //print(category);
                              return DropdownMenuItem(
                                value: category['idcategory'],
                                child: Text(category['nomcategory']),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                for (var item in iteratorCategories) {
                                  if (item['idcategory'] == value) {
                                    opcionseleccionada = item['nomcategory'];
                                    idcategory = item["idcategory"];
                                  }
                                }
                              });
                            }),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }

  Widget _images() {
    return Container(
      decoration: ShapeDecoration(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      padding: EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              alertselectPhoto1(context);
            },
            child: Container(
              width: 95,
              height: 120,
              child: Image(
                image: AssetImage(foto1?.path ?? 'assets/no-image2.jpg'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              alertselectPhoto2(context);
            },
            child: Container(
              height: 120,
              width: 95,
              child: Image(
                image: AssetImage(foto2?.path ?? 'assets/no-image2.jpg'),
                fit: BoxFit.contain,
                repeat: ImageRepeat.noRepeat,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              alertselectPhoto3(context);
            },
            child: Container(
              height: 120,
              width: 95,
              child: Image(
                image: AssetImage(foto3?.path ?? 'assets/no-image2.jpg'),
                fit: BoxFit.contain,
              ),
            ),
          )
        ],
      ),
    );
  }

  _procesarImagen(ImageSource origen) async {
    foto1 = await ImagePicker.pickImage(source: origen);
  }

  _procesarImagen2(ImageSource origen) async {
    foto2 = await ImagePicker.pickImage(source: origen);
  }

  _procesarImagen3(ImageSource origen) async {
    foto3 = await ImagePicker.pickImage(source: origen);
  }

  void alertselectPhoto1(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17.0)),
            elevation: 10.0,
            title: Text('Selecciona tu foto'),
            content: Text(
                'Puedes tomarla con tu camara o seleccionarla de la galeria'),
            actions: <Widget>[
              FlatButton(
                shape: CircleBorder(),
                // color: Colors.blue,
                splashColor: Colors.yellow,
                padding: EdgeInsets.all(10.0),
                onPressed: () async {
                  await _procesarImagen(ImageSource.camera);
                  setState(() {
                    if (foto1 != null) {
                      Navigator.pop(context);
                    }
                  });
                },
                child: Icon(
                  Icons.add_a_photo,
                  color: Color.fromRGBO(20, 116, 227, 1),
                  size: 35.0,
                ),
              ),
              FlatButton(
                  shape: CircleBorder(),
                  // color: Colors.blue,
                  splashColor: Colors.yellow,
                  padding: EdgeInsets.all(10.0),
                  onPressed: () async {
                    await _procesarImagen(ImageSource.gallery);
                    setState(() {
                      if (foto1 != null) {
                        Navigator.pop(context);
                      }
                    });
                  },
                  child: Icon(
                    Icons.add_photo_alternate,
                    color: Color.fromRGBO(20, 116, 227, 1),
                    size: 40.0,
                  ))
            ],
          );
        });
  }

  void alertselectPhoto2(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17.0)),
            elevation: 10.0,
            title: Text('Selecciona tu foto'),
            content: Text(
                'Puedes tomarla con tu camara o seleccionarla de la galeria'),
            actions: <Widget>[
              FlatButton(
                shape: CircleBorder(),
                splashColor: Colors.yellow,
                padding: EdgeInsets.all(10.0),
                onPressed: () async {
                  await _procesarImagen2(ImageSource.camera);
                  setState(() {
                    if (foto2 != null) {
                      Navigator.pop(context);
                    }
                  });
                },
                child: Icon(
                  Icons.add_a_photo,
                  color: Color.fromRGBO(20, 116, 227, 1),
                  size: 35.0,
                ),
              ),
              FlatButton(
                  shape: CircleBorder(),
                  splashColor: Colors.yellow,
                  padding: EdgeInsets.all(10.0),
                  onPressed: () async {
                    await _procesarImagen2(ImageSource.gallery);
                    setState(() {
                      if (foto2 != null) {
                        Navigator.pop(context);
                      }
                    });
                  },
                  child: Icon(
                    Icons.add_photo_alternate,
                    color: Color.fromRGBO(20, 116, 227, 1),
                    size: 40.0,
                  ))
            ],
          );
        });
  }

  void alertselectPhoto3(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17.0)),
            elevation: 10.0,
            title: Text('Selecciona tu foto'),
            content: Text(
                'Puedes tomarla con tu camara o seleccionarla de la galeria'),
            actions: <Widget>[
              FlatButton(
                shape: CircleBorder(),
                splashColor: Color.fromRGBO(20, 116, 227, 1),
                padding: EdgeInsets.all(10.0),
                onPressed: () async {
                  await _procesarImagen3(ImageSource.camera);
                  setState(() {
                    if (foto3 != null) {
                      Navigator.pop(context);
                    }
                  });
                },
                child: Icon(
                  Icons.add_a_photo,
                  color: Color.fromRGBO(20, 116, 227, 1),
                  size: 35.0,
                ),
              ),
              FlatButton(
                  shape: CircleBorder(),
                  splashColor: Colors.yellow,
                  padding: EdgeInsets.all(10.0),
                  onPressed: () async {
                    await _procesarImagen3(ImageSource.gallery);
                    setState(() {
                      if (foto3 != null) {
                        Navigator.pop(context);
                      }
                    });
                  },
                  child: Icon(
                    Icons.add_photo_alternate,
                    color: Color.fromRGBO(20, 116, 227, 1),
                    size: 40.0,
                  ))
            ],
          );
        });
  }

  _createbutton() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: ButtonTheme(
            minWidth: 175.0,
            height: 40.0,
            child: RaisedButton.icon(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              color: Color.fromRGBO(20, 116, 227, 1),
              textColor: Colors.white,
              label: Text('Publicar'),
              icon: Icon(Icons.check),
              onPressed: _submit,
            )),
      ),
    );
  }

  void _submit() async {
    if (foto1 != null) {
      progress();
      progressDialog.show();

      url1 = await category.uploadImagen(foto1);
      url2 = await category.uploadImagen(foto2);
      url3 = await category.uploadImagen(foto3);
      var costo = int.parse(this.cost.text);

      print(url1);

      category.registerImages({'url1': url1, 'url2': url2, 'url3': url3}).then(
          (res) {
        print(res);
        for (var inf in res) {
          category.registerProduct({
            'nameProduct': this.nameproduct.text,
            'image': inf["idimage"],
            'idusuario': idUser,
            'characteristics': this.characteristics.text,
            'cost': costo,
            'idstate': 1,
            'idcategory': idcategory
          });
        }
        Future.delayed(Duration(seconds: 3)).then((value) {
          _alert(context);
        });
      });
    }
  }

  Widget _alert(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Producto públicado exitosamente',
              style: TextStyle(
                color: Color.fromRGBO(20, 116, 227, 1),
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                height: 1,
              ),
            ),
            content: Text(
              'ahora tú producto está activo,pero lo podras inactivar,eliminar o editar. Se notificará cuando alguien esté interesado en tú producto',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 17.0,
                height: 1,
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
                    'volver al inicio',
                    style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      height: 1,
                    ),
                  )),
            ],
          );
        });
  }

  void progress() {
    progressDialog = new ProgressDialog(context);
    progressDialog.style(
      message: 'Publicando',
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
