import 'package:easybuy_frontend/src/pages/myshopping_page.dart';
import 'package:easybuy_frontend/src/providers/PaymentsProviders.dart';
import 'package:easybuy_frontend/src/providers/sendnotificationsProvider.dart';
import 'package:easybuy_frontend/src/utils/alert_EmpyCategory.dart';
import 'package:easybuy_frontend/src/utils/token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Payments extends StatefulWidget {
  @override
  _PaymentsState createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  FlutterWebviewPlugin flutterWebviewPlugin;
  PaymentsProviders paymentsProviders;
  SendNotificationsProvider notification = new SendNotificationsProvider();
  AlertCategory alert;
  Token token;
  String url;
  int c;
  _PaymentsState() {
    c = 0;
    alert = new AlertCategory();
    token = new Token();
    token.getString('url').then((url) {
      setState(() {
        this.url = url;
      });
    });
    paymentsProviders = new PaymentsProviders();
    flutterWebviewPlugin = new FlutterWebviewPlugin();
    flutterWebviewPlugin.onUrlChanged.listen((String url) async {
      if (url.contains('success') && c < 1) {
        c++;
        flutterWebviewPlugin.close();
        final idUser = await token.getNumber('idUser');
        final idProduct = await token.getNumber('idProduct');
        final idDealer = await token.getNumber('idDealer');
        final costProduct = await token.getNumber('costProduct');
        final deviceToken = await token.getString('deviceToken');
        final nameUser = await token.getString('nameUser');
        final lastname = await token.getString('lastName');

        await notification.sendNotidication({
          "deviceToken": deviceToken,
          "nameUser": nameUser,
          "lastnameUser": lastname,
        }).then((resp){
          print('nnotificacion enviada');
          print(resp);
        });

        bool res = await paymentsProviders.success({
          'idProduct': idProduct,
          'idusuario': idUser,
          'idDealer': idDealer,
          'costProduct': costProduct,
          'url': url
        });
        if (res) {
          alert.showAlert(context, 'pago exito!', 'gracias por tu compra!',
              Icons.cloud_done, Colors.green);
          Future.delayed(Duration(seconds: 3)).then((resp) {
            Navigator.pushNamedAndRemoveUntil(context, 'botombar',
                (Route<dynamic> route) {
              print(route);
              return route.isFirst;
            });
          });
        } else {}
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.white,
        ),
        backgroundColor: Color.fromRGBO(20, 116, 227, 1),
        title: Text(
          'Metodo de pago',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
        ),
      ),
      body: url != null
          ? WebviewScaffold(
              url: url,
            )
          : Text('Cargando...'),
    ));
  }
}
