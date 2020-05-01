import 'package:flutter/material.dart';

class Alerts {
  void successRegisterAlert(BuildContext context, String message) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Text('Compras'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(message),
                Image.asset(
                  "",
                  fit: BoxFit.contain,
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.pushReplacementNamed(context, '/'),
              ),
            ],
          );
        });
  }
}
