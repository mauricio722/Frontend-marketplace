import 'package:flutter/material.dart';
import '../controllers/loginController.dart';
import '../providers/loginProvider.dart';
import '../providers/ChangePasswordProvider.dart';
import '../utils/validatorPassword.dart';

class ChangePasswordPage extends StatefulWidget {
  ChangePasswordPage();

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePasswordPage> {
  int idUser;
  TextEditingController emails;
  TextEditingController nueva;
  TextEditingController vieja;
  ChangePasswordProvider provider;
  LoginController loginController;
  LoginProvidier loginProvidier;
  final formKey = GlobalKey<FormState>();

  _ChangePasswordState() {
    this.emails = TextEditingController();
    this.vieja = TextEditingController();
    this.provider = ChangePasswordProvider();
    this.nueva = TextEditingController();
    this.loginController = LoginController();
    this.loginProvidier = LoginProvidier();
  }

  @override
  Widget build(BuildContext context) {
    final email = TextFormField(
      controller: emails,
      keyboardType: TextInputType.emailAddress,
      autofocus: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Email",
      ),
      validator: validateEmail,
    );

    final oldpassword = TextFormField(
      controller: vieja,
      obscureText: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "contraseña anterior",
      ),
      validator: validatePasswordold,
    );

    final newpassword = TextFormField(
      controller: nueva,
      obscureText: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "contraseña nueva",
      ),
      validator: validatePassword,
    );

    final loginButton = Material(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.blue,
        child: MaterialButton(
            padding: EdgeInsets.symmetric(horizontal: 70, vertical: 10),
            child: Text(
              "Guardar",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            onPressed: _onSubmit));

    return Scaffold(
      appBar: new AppBar(
        iconTheme: new IconThemeData(color: Colors.white),
        backgroundColor: Color.fromRGBO(20, 116, 227, 1),
        title:
            Text('Cambiar Contraseña', style: TextStyle(color: Colors.white)),
        actions: <Widget>[],
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30.0),
                  SizedBox(
                    height: 150.0,
                    child: Image.asset(
                      "assets/change.png",
                      height: 127,
                      width: 127,
                    ),
                  ),
                  SizedBox(height: 25.0),
                  email,
                  SizedBox(height: 25.0),
                  oldpassword,
                  SizedBox(height: 25.0),
                  newpassword,
                  SizedBox(height: 25.0),
                  loginButton,
                ],
              )),
        ),
      ),
    );
  }

  void _onSubmit() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      if (nueva.text != null) {
        Map body = {
          "password": vieja.text,
          "newPassword": nueva.text,
          'email': emails.text
        };
        await provider.changePassword(emails.text, body);
        _alert(context);
      }
    }
  }
}

Widget _alert(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'se ha cambiado la contraseña exitosamente',
            style: TextStyle(
                color: Colors.black, fontSize: 17, fontStyle: FontStyle.normal),
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/');
                },
                child: Text(
                  'ok',
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ],
        );
      });
}
