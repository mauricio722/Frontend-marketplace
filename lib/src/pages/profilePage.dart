import 'package:easybuy_frontend/src/controllers/profileController.dart';
import 'package:easybuy_frontend/src/pages/Navigation_page.dart';
import 'package:easybuy_frontend/src/pages/SoldHistory_page.dart';
import 'package:easybuy_frontend/src/utils/Session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../providers/animatedBotomBar.dart';
import '../search/search_delegate.dart';

import 'FavoriteProducts_pages.dart';
import 'inactives__page.dart';
import 'myshopping_page.dart';
import 'productsactives_pages.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage();

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int idUser;
  GlobalKey<FormState> keyForm = new GlobalKey();

  TextEditingController document = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController lastname = new TextEditingController();
  TextEditingController mobile = new TextEditingController();
  TextEditingController address = new TextEditingController();

  ProfilePageController profileController;
  Session session;
  Map user;

  _ProfilePageState() {
    print(idUser);
    profileController = ProfilePageController();
    this.name = TextEditingController();
    session = new Session();
  }

  void loadInformation() {
    session.getInformation().then((user) {
      this.user = user;
      idUser = int.parse(user["id"]);
      profileController.getUserInformation(user['email']).then((res) {
        setState(() {
          print('info------->' '$res');
          document.text = res['numDocument'].toString();
          name.text = res['name'];
          lastname.text = res["lastName"];
          mobile.text = res["cellPhone"];
          address.text = res["address"];
        });
      }).catchError((err) async {
        loadInformation();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadInformation();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar Mi Perfil',
          style: TextStyle(
            color: Colors.white,
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
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/profile.png"),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.all(15.0),
          child: new Form(
            key: keyForm,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.blueGrey[50],
              child: Column(
                children: <Widget>[
                  _createIcon(),
                  _createName(),
                  _createLastName(),
                  _createMobile(),
                  _createDocument(),
                  _createAddress(),
                  _createButton(),
                ],
              ),
            ),
          ),
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
                '${name.text}',
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

  Widget _createIcon() {
    return Stack(children: <Widget>[
      Container(
        padding: const EdgeInsets.only(top: 40),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Center(
                  child: Image.asset(
                    "assets/usuario.png",
                    height: 125,
                    width: 125,
                    fit: BoxFit.contain,
                  ),
                ))
          ],
        ),
      ),
    ]);
  }

  Widget _createName() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Form(
        child: new Theme(
          data: new ThemeData(
            primaryColor: Colors.teal,
            primaryColorDark: Colors.teal,
          ),
          child: TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                hintText: 'Nombre',
                labelText: 'Nombre ',
                icon:
                    Icon(Icons.person, color: Color.fromRGBO(20, 116, 227, 1))),
            controller: name,
            validator: (value) {
              if (value.length < 3) {
                return "Nombre Requerido!!";
              } else {
                return null;
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _createLastName() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Form(
        child: new Theme(
          data: new ThemeData(
            primaryColor: Colors.teal,
            primaryColorDark: Colors.teal,
          ),
          child: TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                hintText: 'Apellido',
                labelText: 'Apellido ',
                icon: Icon(
                  Icons.edit,
                  color: Color.fromRGBO(20, 116, 227, 1),
                )),
            controller: lastname,
            validator: (value) {
              if (value.length < 3) {
                return "Apellido Requerido!!";
              } else {
                return null;
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _createDocument() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Form(
        child: new Theme(
          data: new ThemeData(
            primaryColor: Colors.teal,
            primaryColorDark: Colors.teal,
          ),
          child: TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                hintText: 'Documento',
                labelText: 'Documento ',
                icon: Icon(Icons.art_track,
                    color: Color.fromRGBO(20, 116, 227, 1))),
            controller: document,
            validator: (value) {
              if (value.length < 3) {
                return "Documento Requerido!!";
              } else {
                return null;
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _createMobile() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Form(
        child: new Theme(
          data: new ThemeData(
            primaryColor: Colors.teal,
            primaryColorDark: Colors.teal,
          ),
          child: TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                hintText: 'Celular',
                labelText: 'Celular ',
                icon: Icon(Icons.phone_iphone,
                    color: Color.fromRGBO(20, 116, 227, 1))),
            controller: mobile,
            validator: (value) {
              if (value.length < 3) {
                return "Celular Requerido!!";
              } else {
                return null;
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _createAddress() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Form(
        child: new Theme(
          data: new ThemeData(
            primaryColor: Colors.teal,
            primaryColorDark: Colors.teal,
          ),
          child: TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                hintText: 'Direccion',
                labelText: 'Direccion ',
                icon: Icon(Icons.home, color: Color.fromRGBO(20, 116, 227, 1))),
            controller: address,
            validator: (value) {
              if (value.length < 3) {
                return "Direccion Requerida!!";
              } else {
                return null;
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _createButton() {
    return Container(
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
            child: ButtonTheme(
                padding: EdgeInsets.only(),
                height: 35.0,
                minWidth: 150.0,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0),
                    ),
                    child: Text('Actualizar'),
                    color: Color.fromRGBO(20, 116, 227, 1),
                    textColor: Colors.white,
                    onPressed: _submit))));
  }

  void _submit() async {
    if (!keyForm.currentState.validate()) return;
    keyForm.currentState.save();
    setState(() {});

    profileController.updateUser(idUser, {
      'name': name.text,
      'lastName': lastname.text,
      'numDocument': document.text,
      'cellPhone': mobile.text,
      'address': address.text,
    });
    _alert(context);
  }

  Widget _alert(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Informacion Actualizada satisfactoriamente',
              style: TextStyle(fontSize: 15),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    final route = MaterialPageRoute(builder: (context) {
                      return FancyBottomBarPage();
                    });
                    Navigator.pushAndRemoveUntil(context, route,
                        (Route<dynamic> route) {
                      return route.isFirst;
                    });
                  },
                  child: Text(
                    'volver a las categorias',
                    style: TextStyle(
                        color: Colors.teal, fontWeight: FontWeight.bold),
                  )),
            ],
          );
        });
  }
}
