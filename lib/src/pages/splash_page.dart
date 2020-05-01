library custom_splash;

import 'package:easybuy_frontend/src/utils/Session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Function _customFunction;
String _imagePath;
int _duration;
CustomSplashType _runfor;
Color _backGroundColor;
String _animationEffect;
double _logoSize;

enum CustomSplashType { StaticDuration, BackgroundProcess }

Map<dynamic, Widget> _outputAndHome = {};

class CustomSplash extends StatefulWidget {
  CustomSplash(
      {@required String imagePath,
      Function customFunction,
      int duration,
      CustomSplashType type,
      Color backGroundColor = Colors.white,
      String animationEffect = 'fade-in',
      double logoSize = 250.0,
      Map<dynamic, Widget> outputAndHome}) {
    assert(duration != null);
    assert(imagePath != null);

    _duration = duration;
    _customFunction = customFunction;
    _imagePath = imagePath;
    _runfor = type;
    _outputAndHome = outputAndHome;
    _backGroundColor = backGroundColor;
    _animationEffect = animationEffect;
    _logoSize = 250.0;
  }

  @override
  _CustomSplashState createState() => _CustomSplashState();
}

class _CustomSplashState extends State<CustomSplash>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;
  Session session;

  _CustomSplashState(){
    session = new Session();
  }



  @override
  void initState() {
    super.initState();
    if (_duration < 1000) _duration = 2000;
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));
    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInCirc));
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.reset();
  }

  Widget _buildAnimation() {
    switch (_animationEffect) {
      case 'fade-in':
        {
          return FadeTransition(
              opacity: _animation,
              child: Center(
                  child: SizedBox(
                      height: _logoSize, child: Image.asset(_imagePath))));
        }
      case 'zoom-in':
        {
          return ScaleTransition(
              scale: _animation,
              child: Center(
                  child: SizedBox(
                      height: _logoSize, child: Image.asset(_imagePath))));
        }
      case 'zoom-out':
        {
          return ScaleTransition(
              scale: Tween(begin: 1.5, end: 0.6).animate(CurvedAnimation(
                  parent: _animationController, curve: Curves.easeInCirc)),
              child: Center(
                  child: SizedBox(
                      height: _logoSize, child: Image.asset(_imagePath))));
        }
      case 'top-down':
        {
          return SizeTransition(
              sizeFactor: _animation,
              child: Center(
                  child: SizedBox(
                      height: _logoSize, child: Image.asset(_imagePath))));
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    _runfor == CustomSplashType.BackgroundProcess
        ? Future.delayed(Duration.zero).then((value) {
            var res = _customFunction();
            //print("$res+${_outputAndHome[res]}");
            Future.delayed(Duration(milliseconds: _duration)).then((value) {
              Navigator.of(context).pushReplacement(CupertinoPageRoute(
                  builder: (BuildContext context) => _outputAndHome[res]));
            });
          })
        : Future.delayed(Duration(milliseconds: _duration)).then((value) {
            session.renovate().then((res) {
              print(res);
              if (res) {
                Navigator.pushReplacementNamed(context, 'botombar');
              } else {
                Navigator.pushReplacementNamed(context, '/');
              }
            });
          });

    return Scaffold(backgroundColor: _backGroundColor, body: _buildAnimation());
  }
}
