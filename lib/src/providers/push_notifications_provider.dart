import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';


class PushNotificationProvider {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _mensajesStreamController = StreamController<String>.broadcast(); 
  Stream<String> get mensajes =>  _mensajesStreamController.stream;

   Future <String>initNotifications() async {
    _firebaseMessaging.requestNotificationPermissions();
    String tokens  = await _firebaseMessaging.getToken().then(( token ) {
      print('===== FCM Token ===');
      print( token );
      return token;
    });


    _firebaseMessaging.configure(
      onMessage: ( info ) async {
        print('===== On Message =====');
        print(info);

        String argumento = 'no-data';
        if(Platform.isAndroid){
          argumento =  info['data']['comida'] ?? 'no-data';
          _mensajesStreamController.sink.add(argumento);
        }
      },
      onLaunch: ( info ) async {
        print('===== On Launch =====');
        print(info);

      },
      onResume: ( info ) async {
        print('===== On Resume =====');
        final noti = info['data']['comida'];
        _mensajesStreamController.sink.add(noti);
      },
    );
    return tokens;
  }

  dispose(){
    _mensajesStreamController?.close();
  }
}