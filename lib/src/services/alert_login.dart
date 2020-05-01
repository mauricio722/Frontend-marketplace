import 'package:easybuy_frontend/src/providers/animatedBotomBar.dart';
import 'package:flutter/material.dart';

class Alerts {
  void errorAlert(BuildContext context, String message) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  "assets/error.png",
                  height: 70,
                  width: 70,
                  fit: BoxFit.contain,
                ),
                Text(message),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pushNamed(context, 'register'),
                child: Text(
                  'Registrarme',
                  style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FlatButton(
                child: Text(
                  'cancelar',
                  style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        });
  }

  void successLoginAlert(BuildContext context, String message) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  "assets/otra.png",
                  height: 70,
                  width: 70,
                  fit: BoxFit.contain,
                ),
                Text('Bienvenido'),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text(
                    'Ok',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  onPressed: () {
                    final route = MaterialPageRoute(builder: (context) {
                      return FancyBottomBarPage();
                    });
                    Navigator.pushAndRemoveUntil(
                        context, route, ModalRoute.withName('botombar'));
                  }),
            ],
          );
        });
  }
}
