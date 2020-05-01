import 'dart:io';
import 'package:easybuy_frontend/src/providers/animatedBotomBar.dart';
import 'package:easybuy_frontend/src/providers/offerProvider.dart';
import 'package:easybuy_frontend/src/providers/updateProductProvider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easybuy_frontend/src/utils/Utils.dart' as utils;
import 'package:progress_dialog/progress_dialog.dart';

class UpdateProduct extends StatefulWidget {
  final Map product;
  final int idUser;
  UpdateProduct({this.product, this.idUser});

  @override
  _UpdateProduct createState() =>
      _UpdateProduct(product: this.product, idUser: this.idUser);
}

class _UpdateProduct extends State<UpdateProduct> {
  int idUser;

  final formkey = GlobalKey<FormState>();
  UpdateProductProvider updateproduct = UpdateProductProvider();
  Iterable<dynamic> iteratorCategories = [];
  ProgressDialog progressDialog;

  String opcionseleccionada = 'categorias ';

  OfferProvider offer;
  List categorias;
  int idcategory;
  int idstate;
  String opts;
  String url1;
  String url2;
  String url3;
  File foto1;
  File foto2;
  File foto3;
  int idimage;
  int idproduct;

  TextEditingController nameproduct;
  TextEditingController characteristics;
  TextEditingController cost;
  TextEditingController categorys;
  OfferProvider category;

  _UpdateProduct({product, this.idUser}) {
    this.nameproduct = TextEditingController();
    this.categorys = TextEditingController();
    this.cost = TextEditingController();
    this.characteristics = TextEditingController();
    this.category = OfferProvider();

    nameproduct.text = product['nameProduct'];
    cost.text = product['cost'].toString();
    characteristics.text = product['characteristics'];
    url1 = product['Url1'];
    url2 = product['url2'];
    url3 = product['url3'];
    idimage = product['image'];
    idproduct = product['idProduct'];
    print(product['Url1']);

    categorias = [];

    category.getcategorys().then((res) {
      setState(() {
        iteratorCategories = res;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(20, 116, 227, 1),
          iconTheme: new IconThemeData(color: Colors.white),
          title: Text(
            'Editar mi producto',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Card(
                elevation: 10.0,
                color: Colors.white,
                child: Column(
                  key: formkey,
                  children: <Widget>[
                    _nameProduct(),
                    _cost(),
                    _characteristics(),
                    _categorys(),
                    _images(),
                    _createbutton(),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _nameProduct() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Form(
        child: new Theme(
          data: new ThemeData(
            primaryColor: Color.fromRGBO(20, 116, 227, 1),
            primaryColorDark: Color.fromRGBO(20, 116, 227, 1),
          ),
          child: new TextFormField(
            controller: nameproduct,
            decoration: new InputDecoration(
                border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: new BorderSide(color: Colors.blue)),
                labelText: 'Nombre del Producto',
                prefixIcon: const Icon(
                  Icons.edit,
                  color: Color.fromRGBO(20, 116, 227, 1),
                ),
                prefixText: ' ',
                suffixStyle: const TextStyle(color: Colors.green)),
          ),
        ),
      ),
    );
  }

  Widget _characteristics() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Form(
        child: new Theme(
          data: new ThemeData(
            primaryColor: Colors.teal,
            primaryColorDark: Colors.teal,
          ),
          child: new TextFormField(
            controller: characteristics,
            autofocus: false,
            maxLines: 7,
            textCapitalization: TextCapitalization.sentences,
            decoration: new InputDecoration(
                border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: new BorderSide(color: Colors.blue)),
                labelText: 'caracteristicas',
                prefixIcon: const Icon(Icons.local_mall,
                    color: Color.fromRGBO(20, 116, 227, 1)),
                prefixText: ' ',
                suffixStyle: const TextStyle(color: Colors.green)),
          ),
        ),
      ),
    );
  }

  Widget _cost() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Form(
        child: new Theme(
          data: new ThemeData(
            primaryColor: Color.fromRGBO(20, 116, 227, 1),
            primaryColorDark: Color.fromRGBO(20, 116, 227, 1),
          ),
          child: new TextFormField(
            keyboardType: TextInputType.numberWithOptions(decimal: false),
            controller: cost,
            decoration: new InputDecoration(
                border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: new BorderSide(color: Colors.blue)),
                labelText: 'Precio',
                prefixIcon: const Icon(Icons.monetization_on,
                    color: Color.fromRGBO(20, 116, 227, 1)),
                suffixStyle: const TextStyle(color: Colors.green)),
            validator: (value) {
              if (utils.isNumeric(value)) {
                return null;
              } else {
                return 'solo numeros';
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _categorys() {
    return Container(
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 6.0, vertical: 20.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Center(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            isExpanded: false,
                            hint: Text(opcionseleccionada),
                            items: iteratorCategories.map((category) {
                              return DropdownMenuItem(
                                value: category['idcategory'],
                                child: Text(category['nomcategory']),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                for (var item in iteratorCategories) {
                                  if (item['idcategory'] == value) {
                                    opcionseleccionada = item['nomcategory'];
                                    idcategory = item["idcategory"];
                                  }
                                }
                              });
                            }),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }

  Widget _images() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //  mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              _selectphoto();
            },
            child: Container(
              height: 120,
              width: 100,
              child: Image(
                image: AssetImage(foto1?.path ?? 'assets/no-image2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _selectphoto2();
            },
            child: Container(
              height: 120,
              width: 100,
              child: Image(
                image: AssetImage(foto2?.path ?? 'assets/no-image2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _selectphoto3();
            },
            child: Container(
              height: 120,
              width: 100,
              child: Image(
                image: AssetImage(foto3?.path ?? 'assets/no-image2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }

  _selectphoto() async {
    _procesarImagen(ImageSource.gallery);

    setState(() {});
  }

  _selectphoto2() async {
    _procesarImagen2(ImageSource.gallery);

    setState(() {});
  }

  _selectphoto3() async {
    _procesarImagen3(ImageSource.gallery);

    setState(() {});
  }

  _procesarImagen(ImageSource origen) async {
    foto1 = await ImagePicker.pickImage(source: origen);

    setState(() {});
  }

  _procesarImagen2(ImageSource origen) async {
    foto2 = await ImagePicker.pickImage(source: origen);

    setState(() {});
  }

  _procesarImagen3(ImageSource origen) async {
    foto3 = await ImagePicker.pickImage(source: origen);

    setState(() {});
  }

  _createbutton() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: ButtonTheme(
            minWidth: 200.0,
            height: 34.0,
            child: RaisedButton.icon(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              color: Color.fromRGBO(20, 116, 227, 1),
              textColor: Colors.white,
              label: Text('Actualizar'),
              icon: Icon(Icons.save_alt),
              onPressed: _submit,
            )),
      ),
    );
  }

  void _submit() async {
    progress();
    progressDialog.show();
    url1 = await category.uploadImagen(foto1);
    url2 = await category.uploadImagen(foto2);
    url3 = await category.uploadImagen(foto3);
    var costo = int.parse(this.cost.text);

    print(url1);
    print(url2);
    print(url3);

    updateproduct.updateimages(
        {'url1': url1, 'url2': url2, 'url3': url3}, idimage).then((res) {
      for (var inf in res) {
        updateproduct.updateproducts({
          'nameProduct': this.nameproduct.text,
          'image': inf["idimage"],
          'characteristics': this.characteristics.text,
          'cost': costo,
          'idstate': 1,
          'idcategory': idcategory
        }, idproduct);
      }
      Future.delayed(Duration(seconds: 3)).then((value) {
        _alert(context);
      });
    });
  }

  Widget _alert(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Edición exitosa',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    final route = MaterialPageRoute(builder: (context) {
                      return FancyBottomBarPage();
                    });
                    Navigator.push(context, route);
                  },
                  child: Text('Ir al inicio')),
            ],
          );
        });
  }

  void progress() {
    progressDialog = new ProgressDialog(context);
    progressDialog.style(
      message: 'Editando',
      borderRadius: 15.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.teal),
      ),
      elevation: 20.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w300),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 17.0, fontWeight: FontWeight.w300),
    );
  }
}
