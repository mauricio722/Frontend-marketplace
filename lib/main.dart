import 'package:easybuy_frontend/src/providers/push_notifications_provider.dart';
import 'package:easybuy_frontend/src/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> navigatorkey = new GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    final pushProvider = new  PushNotificationProvider();
    pushProvider.initNotifications();
  }

  @override
  
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color.fromRGBO(20, 116, 227, 1),
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Marketplace',
      theme: ThemeData(
        primaryColor: Colors.white,
        fontFamily: 'Gotu',
      ),
      initialRoute: 'Splash',
      routes: getroutes(),
    );
  }
}
