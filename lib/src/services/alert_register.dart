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
            title: Text('Registro'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(message),
                Image.asset(
                  "assets/error.jpg",
                  fit: BoxFit.contain,
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        });
  }

  void successRegisterAlert(BuildContext context, String message) {
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
                Text(message),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Ok',
                  style: TextStyle(
                    color: Colors.teal,
                    
                  ),
                ),
                onPressed: () => Navigator.pushReplacementNamed(context, '/'),
              ),
            ],
          );
        });
  }
}
