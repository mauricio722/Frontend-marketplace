import 'package:easybuy_frontend/src/providers/SoldHistoryProviders.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SoldHistoryPage extends StatefulWidget {
  final int idUser;

  SoldHistoryPage({this.idUser});

  @override
  _SoldHistoryPageState createState() =>
      _SoldHistoryPageState(idUser: this.idUser);
}

class _SoldHistoryPageState extends State<SoldHistoryPage> {
  SoldHistoryProduct soldHistoryProduct = SoldHistoryProduct();
  List soldHistoryData;
  int idUser;
  final primary = Colors.teal;
  final secondary = Colors.yellowAccent[400];
  _SoldHistoryPageState({this.idUser}) {
    soldHistoryProduct.getSoldProducts(idUser).then((res) {
      setState(() {
        soldHistoryData = res;
      });
    });

    print(idUser);
  }

  Future getHistory() async {
    soldHistoryProduct = new SoldHistoryProduct();

    soldHistoryData = await soldHistoryProduct.getSoldProducts(idUser);
    print(soldHistoryData);

    return soldHistoryData;
  }

  @override
  void initState() {
    super.initState();
    getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mis ventas',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(20, 116, 227, 1),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(17.0),
          itemCount: soldHistoryData == null ? 0 : soldHistoryData.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: Card(
                elevation: 5,
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 125,
                      width: 110,
                      padding: EdgeInsets.only(
                          left: 0, top: 10, bottom: 70, right: 20),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  soldHistoryData[index]['url1']),
                              fit: BoxFit.cover)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            soldHistoryData[index]['nameProduct'],
                            style: TextStyle(
                                color: Color.fromRGBO(20, 116, 227, 1),
                                fontWeight: FontWeight.w700,
                                fontSize: 15),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "costo: "
                            r"$"
                            "${soldHistoryData[index]["cost"]}",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
