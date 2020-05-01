import 'package:easybuy_frontend/src/providers/RememberPasswordProvider.dart';

class RememberPasswordController{
  RememberPasswordProvider remember;

  RememberPasswordController(){
    remember = RememberPasswordProvider();
  
  }
  Future<Map> recoverPassword(email,data) async {
    return await remember.recoverPassword(email, data);
  }
   
}
