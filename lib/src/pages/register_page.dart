import 'package:easybuy_frontend/src/controllers/register_controller.dart';
import 'package:easybuy_frontend/src/providers/push_notifications_provider.dart';
import 'package:easybuy_frontend/src/providers/registertokenProvider.dart';
import 'package:easybuy_frontend/src/utils/validators_register.dart';
import 'package:flutter/material.dart';

void main() => runApp(RegisterPage());

class RegisterPage extends StatefulWidget {
  final String title;
  RegisterPage({this.title});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> keyForm = new GlobalKey();
  TextEditingController emailCtrl = new TextEditingController();
  TextEditingController passwordCtrl = new TextEditingController();
  TextEditingController nameCtrl = new TextEditingController();
  TextEditingController lastNameCtrl = new TextEditingController();
  TextEditingController documentNumberCtrl = new TextEditingController();
  TextEditingController mobileCtrl = new TextEditingController();
  TextEditingController addressCtrl = new TextEditingController();
  PushNotificationProvider notification = new PushNotificationProvider();
  RegistertokenProvider registerToken = new RegistertokenProvider();
  SigninController signinController;

  _RegisterPageState() {
    this.emailCtrl = TextEditingController();
    this.passwordCtrl = TextEditingController();
    this.lastNameCtrl = TextEditingController();
    this.documentNumberCtrl = TextEditingController();
    this.mobileCtrl = TextEditingController();
    this.addressCtrl = TextEditingController();
    this.signinController = SigninController();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        body: SingleChildScrollView(
          child: new Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/hh.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            margin: new EdgeInsets.all(10.0),
            child: new Form(
              key: keyForm,
              child: singUpCard(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget singUpCard(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 60.0),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Card(
            color: Colors.blueGrey[50],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Registro",
                      style: TextStyle(
                        color: Color.fromRGBO(20, 116, 227, 1),
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  TextFormField(
                    controller: emailCtrl,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      labelText: 'Correo',
                      icon: Icon(Icons.mail_outline, color: Color.fromRGBO(20, 116, 227, 1),size: 20),
                    ),
                    keyboardType: TextInputType.text,
                    validator: validateEmail,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: passwordCtrl,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                       icon: Icon(Icons.vpn_key, color: Color.fromRGBO(20, 116, 227, 1),size: 20),
                    ),
                    keyboardType: TextInputType.text,
                    validator: validatePassword,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: nameCtrl,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                       icon: Icon(Icons.person_outline, color: Color.fromRGBO(20, 116, 227, 1),size: 20),
                    ),
                    keyboardType: TextInputType.text,
                    validator: validateName,
                   
                  ),
                  
                  SizedBox(
                    
                    height: 20,
                  ),
                  TextFormField(
                    controller: lastNameCtrl,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      labelText: 'Apellidos',
                       icon: Icon(Icons.person_add, color: Color.fromRGBO(20, 116, 227, 1),size: 20),
                    ),
                    keyboardType: TextInputType.text,
                    validator: validateLastName,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: documentNumberCtrl,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      labelText: 'Documento',
                       icon: Icon(Icons.art_track, color: Color.fromRGBO(20, 116, 227, 1),size: 20),
                    ),
                    keyboardType: TextInputType.number,
                    validator: validateDocumentNumber,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: mobileCtrl,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      labelText: 'Celular',
                       icon: Icon(Icons.phone_android, color: Color.fromRGBO(20, 116, 227, 1),size: 20),
                    ),
                    keyboardType: TextInputType.number,
                    validator: validateMobile,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: addressCtrl,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      labelText: 'Dirección',
                       icon: Icon(Icons.home, color: Color.fromRGBO(20, 116, 227, 1),size: 20,),
                    ),
                    keyboardType: TextInputType.text,
                    validator: validateAddress,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                      onTap: () async {
                        final deviceToken =
                            await notification.initNotifications();
                        print(deviceToken);

                        if (keyForm.currentState.validate()) {
                          signinController.signin(context, {
                            'email': this.emailCtrl.text,
                            'password': this.passwordCtrl.text,
                            'name': this.nameCtrl.text,
                            'lastName': this.lastNameCtrl.text,
                            'numDocument': this.documentNumberCtrl.text,
                            'cellPhone': this.mobileCtrl.text,
                            'address': this.addressCtrl.text,
                          }).then((resp) {
                            registerToken.registertoken({
                              'deviceToken': deviceToken,
                              'idusuario': resp[0]['id']
                            });
                          });
                        } else {}
                      },
                      child: Container(
                        height: 50,
                        width: 120,
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(20, 116, 227, 1),
                                Color.fromRGBO(20, 116, 227, 1),
                                Color.fromRGBO(20, 116, 227, 1),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                        ),
                        child: Text("Registrarme",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w500)),
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                      ))
                ],
              ),
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
        ),
      ],
    );
  }
}
