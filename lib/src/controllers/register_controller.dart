import 'package:flutter/cupertino.dart';
import '../providers/resgister_providers.dart';
import '../services/alert_register.dart';

class SigninController {
  SiginProvidier signinProvidier;
  Alerts alert;
  SigninController() {
    signinProvidier = SiginProvidier();
    alert = Alerts();
  }
  Future<List> signin(BuildContext context, data) async  {
    List respResgister;

   await signinProvidier.signin(data).then((res) {
     try{
      respResgister = res;
      print('========================');
      print(respResgister);
      print('=================');
      alert.successRegisterAlert(context, 'Registro exitoso, ahora puedes iniciar sesión');
     }catch(error){
       return error;
     }
    
    
      
    });
    return respResgister;
  }
}
