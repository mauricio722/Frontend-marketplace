import 'package:carousel_pro/carousel_pro.dart';
import 'package:easybuy_frontend/src/controllers/myshoppingController.dart';
import 'package:easybuy_frontend/src/providers/myshoppingproduct_provider.dart';
import 'package:easybuy_frontend/src/search/search_delegate.dart';
import 'package:flutter/material.dart';

class ShoppingProduct extends StatefulWidget {
  final int productId;
  final int idUser;
  ShoppingProduct({this.productId, this.idUser});
  @override
  _ShoppingState createState() =>
      _ShoppingState(productId: this.productId, idUser: this.idUser);
}

class _ShoppingState extends State<ShoppingProduct> {
  MyShoppingProductProvider shopping = MyShoppingProductProvider();
  int productId;
  List productdetails;
  int idUser;
  MyshoppingController myshoppingController;
  _ShoppingState({this.productId, this.idUser}) {
    print(productId);
    shopping.getproductdetail(productId).then((res) {
      setState(() {
        productdetails = res;
        print(productdetails);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.teal,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: Search(idUser),
                );
              },
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _swiperTarge(),
                _title(),
                _value(),
                _text(),
                _description(),
                 _createButton(),
                Container(
                  padding: EdgeInsets.only(left: 120, right: 120, bottom: 40),
                  child: Row(
                    children: <Widget>[],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  _swiperTarge() {
    return Center(
      child: new Container(
        padding: EdgeInsets.all(20.0),
        height: 200.0,
        child: Carousel(
          boxFit: BoxFit.cover,
          images: [
            NetworkImage('${productdetails[0]['Url1']}'),
            NetworkImage('${productdetails[0]['Url2']}'),
            NetworkImage('${productdetails[0]['Url3']}')
          ],
          animationCurve: Curves.fastOutSlowIn,
          animationDuration: Duration(milliseconds: 2000),
        ),
      ),
    );
  }

  _title() {
    return Container(
      padding: EdgeInsets.only(top: 30, bottom: 15),
      child: Center(
        child: Text(
          '${productdetails[0]['nameProduct']}',
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  _value() {
    return Container(
      padding: EdgeInsets.only(right: 130),
      child: Center(
        child: Text(
          'costo: ' + '${productdetails[0]['cost']}',
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  _text() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Center(
          child: Container(
        padding: EdgeInsets.only(left: 50, right: 50, bottom: 10),
        child: Text(
          '${productdetails[0]['characteristics']}',
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      )),
    );
  }

  _description() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Center(
          child: Container(
        padding: EdgeInsets.all(10.0),
        child: Text(
          '',
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      )),
    );
  }

  
  Widget _createButton() {
    return Container(
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
            child: ButtonTheme(
                padding: EdgeInsets.only(),
                height: 35.0,
                minWidth: 200.0,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1.0),
                    ),
                    child: Text('Seguir Comprando'),
                    color: Color.fromRGBO(20, 116, 227, 1),
                    textColor: Colors.white,
                    onPressed: () {
                      
                    }))));
}
}