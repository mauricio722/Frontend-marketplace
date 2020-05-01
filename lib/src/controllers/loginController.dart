import 'package:easybuy_frontend/src/providers/loginProvider.dart';
import 'package:easybuy_frontend/src/services/alert_login.dart';
import 'package:easybuy_frontend/src/utils/Session.dart';
import 'package:easybuy_frontend/src/utils/token.dart';
import 'package:flutter/cupertino.dart';

class LoginController {
  LoginProvidier loginProvidier;
  Alerts alert;
  Token token;
  Session session;

  LoginController() {
    loginProvidier = LoginProvidier();
    alert = Alerts();
    token = new Token();
    session = new Session();
  }

  Future<Map> login(BuildContext context, data) async {
    Map login;

    await loginProvidier.login(data).then((res) {
      login = res;
      if (res == null) {
        alert.errorAlert(context, 'error de autenticacion');
      } else {
        session.start(res,data);
        alert.successLoginAlert(context, data['email']);
        token.setToken(res['token']);
      }
    }).catchError((err) {
      print(err);
      alert.errorAlert(context, 'authentication error');
    });

    return login;
  }

  
}
