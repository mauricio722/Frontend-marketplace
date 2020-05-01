import 'package:cached_network_image/cached_network_image.dart';
import 'package:easybuy_frontend/src/controllers/NavigationController.dart';
import 'package:easybuy_frontend/src/providers/animatedBotomBar.dart';
import 'package:easybuy_frontend/src/providers/navigationProvider.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  final int idUser;
  Navigation({this.idUser});

  @override
  _ProductspageState createState() => _ProductspageState(idUser: idUser);
}

class _ProductspageState extends State<Navigation> {
  final NavigationProvider products = NavigationProvider();
  NavigationController navigationController;
  List navigation;
  int idUser;
  final primary = Colors.teal;
  final secondary = Color(0xFFFFA000);
  List<dynamic> navigationProduct;

  _ProductspageState({this.idUser}) {}

  Future myNavigation() async {
    navigationController = new NavigationController();

    navigation = await navigationController.getNavigation(context, idUser);

    setState(() {});
    return navigation;
  }

  @override
  void initState() {
    super.initState();
    myNavigation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(20, 116, 227, 1),
        iconTheme: new IconThemeData(color: Colors.white),
        title: Text('Productos vistos',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
            )),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              navigationController.deleteNavigation(idUser);
              _alert(context);
            },
            child: Icon(
              Icons.delete_forever,
              size: 30,
            ),
            textColor: Colors.white,
          )
        ],
      ),
      body: ListView.builder(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(17.0),
          itemCount: navigation == null ? 0 : navigation.length,
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
                                  navigation[index]['url1']),
                              fit: BoxFit.cover)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            navigation[index]['nameProduct'],
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
                            "${navigation[index]["cost"]}",
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
          }),
    );
  }

  Widget _alert(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text('Seccion eliminada satisfactoriamente'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    final route = MaterialPageRoute(builder: (context) {
                      return FancyBottomBarPage();
                    });
                    Navigator.push(context, route);
                  },
                  child: Text('volver a las categorias')),
            ],
          );
        });
  }
}
