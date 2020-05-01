import 'package:easybuy_frontend/src/pages/ChangePasswordPage.dart';
import 'package:easybuy_frontend/src/pages/Home.dart';
import 'package:easybuy_frontend/src/pages/InicioApp.dart';
import 'package:easybuy_frontend/src/pages/FavoriteProducts_pages.dart';
import 'package:easybuy_frontend/src/pages/Payments.dart';
import 'package:easybuy_frontend/src/pages/SoldHistory_page.dart';
import 'package:easybuy_frontend/src/pages/inactives__page.dart';
import 'package:easybuy_frontend/src/pages/login_page.dart';
import 'package:easybuy_frontend/src/pages/offer_page.dart';
import 'package:easybuy_frontend/src/pages/paymentReceived.dart';
import 'package:easybuy_frontend/src/pages/products_page.dart';
import 'package:easybuy_frontend/src/pages/productsactives_pages.dart';
import 'package:easybuy_frontend/src/pages/register_page.dart';
import 'package:easybuy_frontend/src/pages/splash_page.dart';
import 'package:easybuy_frontend/src/pages/swiper_targe.dart';
import 'package:easybuy_frontend/src/providers/animatedBotomBar.dart';
import 'package:flutter/material.dart';
import 'package:easybuy_frontend/src/pages/categorys_page.dart';

Map<String, WidgetBuilder> getroutes() {
  Function duringSplash = () {
    print('Something background process');
    int a = 123 + 23;
    print(a);

    if (a > 100)
      return 1;
    else
      return 2;
  };

  return <String, WidgetBuilder>{
    '/': (BuildContext context) => InicioApp(),
    'LoginPage': (BuildContext context) => LoginPage(),
    'Home': (BuildContext context) => Home(),
    'register': (BuildContext context) => RegisterPage(),
    'categories': (BuildContext context) => CategoriesPage(),
    'swiper': (BuildContext context) => SwiperTarge(),
    'products': (BuildContext context) => Productspage(),
    'offer': (BuildContext context) => OfferPage(),
    'inactives': (BuildContext context) => Productsinactives(),
    'actives': (BuildContext contex) => Productsactives(),
    'changepass': (BuildContext contex) => ChangePasswordPage(),
    'soldHistory': (BuildContext contex) => SoldHistoryPage(),
    'MyFavorite': (BuildContext contex) => FavoriteProductsPage(),
    'Payments': (BuildContext contex) => Payments(),
    'PaymentReceived': (BuildContext contex) => PaymentReceived(),
    'Splash': (BuildContext contex) => CustomSplash(
          imagePath: 'assets/456.gif',
          backGroundColor: Color.fromRGBO(20, 116, 227, 1),
          animationEffect: 'zoom-in',
          logoSize: 200,
          customFunction: duringSplash,
          duration: 4900,
          type: CustomSplashType.StaticDuration,
        ),
    'botombar': (BuildContext context) => FancyBottomBarPage(),
  };
}
