import 'package:easybuy_frontend/src/controllers/profileController.dart';
import 'package:easybuy_frontend/src/providers/PaymentsProviders.dart';
import 'package:easybuy_frontend/src/providers/paymentReceivedProvider.dart';
import 'package:easybuy_frontend/src/utils/Session.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class PaymentReceived extends StatefulWidget {
  PaymentReceived({Key key}) : super(key: key);

  @override
  _PaymentReceivedState createState() => _PaymentReceivedState();
}

class _PaymentReceivedState extends State<PaymentReceived> {
  Session session;
  List soldHistoryData = [];
  Map user;
  ProfilePageController profileController;
  String name, lastName = '';
  PaymentsReceivedProvider paymentsReceivedProvider;
  PaymentsProviders paymentsProviders;
  ProgressDialog progressDialog;

  _PaymentReceivedState() {
    session = new Session();
    profileController = new ProfilePageController();
    paymentsReceivedProvider = new PaymentsReceivedProvider();
    paymentsProviders = new PaymentsProviders();
  }

  void _data() async {
    user = await session.getInformation();
    paymentsReceivedProvider
        .getPaymentsReceived(int.parse(user["id"]))
        .then((res) {
      print("object");
      print(res);
      setState(() {
        soldHistoryData = res;
      });
    });

    profileController.getUserInformation(user['email']).then((res) {
      setState(() {
        name = res['name'];
        lastName = res["lastName"];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _data();
  }

  Color darkBlue = Color(0xff071d40);
  Color lightBlue = Color(0xff1b4dff);
  @override
  Widget build(BuildContext context) {
    int sum = 0;

    for (var i = 0; i < soldHistoryData.length; i++) {
      sum = sum + soldHistoryData[i]["value"];
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "Pagos Recibidos",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromRGBO(20, 116, 227, 1),
        ),
        body: Container(
            child: Column(children: <Widget>[
          Text(
            "Hola,",
            style: Theme.of(context)
                .textTheme
                .display1
                .apply(color: Colors.grey[500]),
          ),
          Text(
            name == null ? 'User' : name,
            style: Theme.of(context)
                .textTheme
                .display1
                .apply(color: darkBlue, fontWeightDelta: 2),
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
            padding: EdgeInsets.all(25.0),
            decoration: BoxDecoration(
              color: darkBlue,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Saldo Total",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 11.0,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: r"$" "$sum",
                        style: Theme.of(context)
                            .textTheme
                            .display1
                            .apply(color: Colors.white, fontWeightDelta: 2),
                      ),
                      TextSpan(text: " USD")
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            height: 400,
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(10.0),
              itemCount: soldHistoryData == null ? 0 : soldHistoryData.length,
              itemBuilder: (BuildContext context, int index) =>
                  _content(context, soldHistoryData[index]),
            ),
          )
        ])));
  }

  Widget _content(BuildContext context, payments) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Divider(
            height: 30,
          ),
          Row(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${payments["nameProduct"]}',
                        style: Theme.of(context)
                            .textTheme
                            .title
                            .apply(color: darkBlue, fontWeightDelta: 2),
                      ),
                      Text(
                        "${payments['created_at'].toString().split('T')[0]} \n"
                        "${payments['created_at'].toString().split('Z')[0].split('T')[1].split('.')[0]}",
                        style: TextStyle(color: Colors.black.withOpacity(.71)),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: Column(
                  children: <Widget>[
                    Text(
                      r'$' '${payments["value"]}',
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .apply(color: Color(0xff17dcb0), fontWeightDelta: 2),
                      textAlign: TextAlign.center,
                    ),
                    RaisedButton(
                      color: lightBlue,
                      child: Text(
                        "Retirar Dinero",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(top: 0.0),
                                        child: Container(
                                          width: 70,
                                          height: 70,
                                          child: Icon(
                                            Icons.error_outline,
                                            size: 70.0,
                                            color: Colors.orange[300],
                                          ),
                                        )),
                                    Text(
                                      "retirar",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      "¿Está seguro que desea hacer este retiro?",
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                actions: <Widget>[
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        FlatButton(
                                          onPressed: Navigator.of(context).pop,
                                          child: Text("Cancelar"),
                                          splashColor: Colors.blueGrey,
                                        ),
                                        FlatButton(
                                            color: Colors.teal,
                                            textColor: Colors.white,
                                            child: Text("Aceptar"),
                                            splashColor: Colors.teal,
                                            onPressed: () async {
                                              progress();
                                              progressDialog.show();

                                              bool success =
                                                  await paymentsProviders
                                                      .payout({
                                                'idPaymentsReceived':
                                                    payments["id"],
                                                'email':
                                                    'sb-g7jww1386080@personal.example.com',
                                                'value': payments["value"],
                                                'senderItemId':
                                                    payments["idProduct"]
                                                        .toString(),
                                                'idProduct':
                                                    payments["idProduct"]
                                                        .toString()
                                              });
                                              print(success);
                                              if (success) {
                                                Navigator
                                                    .pushNamedAndRemoveUntil(
                                                        context,
                                                        'PaymentReceived',
                                                        (Route<dynamic> route) {
                                                  print(route);
                                                  return route.isFirst;
                                                });
                                              }
                                            }),
                                      ]),
                                ],
                              );
                            });
                      },
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void progress() {
    progressDialog = new ProgressDialog(context);
    progressDialog.style(
      message: 'Procesando ',
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
