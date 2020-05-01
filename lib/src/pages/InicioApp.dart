import 'package:easybuy_frontend/src/utils/Session.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class InicioApp extends StatefulWidget {


  @override
  _InicioAppState createState() => _InicioAppState();
}



class _InicioAppState extends State<InicioApp> {

Session session;

_InicioAppState(){
  session = Session();
}
@override
void initState() { 
  super.initState();

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/fondo.jpg'), fit: BoxFit.cover)),
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                margin: const EdgeInsets.all(48.0),
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 48.0),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(10.0)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    //nitidez imagen
                    sigmaX: 0.0,
                    sigmaY: 0.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(height: 10.0),
                      Text(
                        "EasyBuy",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20.0),
                      Text("Compra fácil, compra rápido",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 17.0)),
                      const SizedBox(height: 60.0),
                      SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          elevation: 10.0,
                          highlightElevation: 0,
                          color: Color.fromRGBO(20, 116, 227, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Text("Crea tu cuenta aquí",
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          onPressed: () {
                            Navigator.of(context).pushNamed('register');
                          },
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Text.rich(TextSpan(children: [
                        TextSpan(text: "Ya tienes una cuenta? "),
                        WidgetSpan(
                            child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('LoginPage');
                          },
                          child: Text("Ingresa",
                              style: TextStyle(
                                color: Color.fromRGBO(20, 116, 227, 1),
                                fontWeight: FontWeight.bold,
                              )),
                        ))
                      ])),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
