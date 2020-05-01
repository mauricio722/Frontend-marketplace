import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertCategory {
  void errorAlert(
    BuildContext context,
    String message,
  ) async {
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
                Text(message),
                Container(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: RaisedButton(
                      elevation: 10.0,
                      child: Text('Regresar'),
                      color: Color.fromRGBO(20, 116, 227, 1),
                      textColor: Colors.white,
                      shape: StadiumBorder(),
                      onPressed: () {
                        Navigator.pushNamed(context, 'botombar');
                      },
                    )),
              ],
            ),
          );
        });
  }

  void showAlert(BuildContext context, String title, String message,
      IconData icon, Color color) {
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
                Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Container(
                      width: 90,
                      height: 90,
                      child: Icon(
                        icon,
                        size: 80.0,
                        color: color,
                      ),
                    )),
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(message),
                FlatButton(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text('Continuar'),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'Navigator');
                    }),
              ],
            ),
          );
        });
  }
}
