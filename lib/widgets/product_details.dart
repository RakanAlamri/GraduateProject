import 'package:final_project/HomePage.dart';
import 'package:final_project/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../Navbars.dart';
import '../Firebase/FirebaseAction.dart';
import 'Edit_product.dart';
import '../Navbars.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductDetails extends StatefulWidget {
  Transaction t;
  ProductDetails({super.key, required this.t});

  @override
  State<StatefulWidget> createState() {
    return _ProductDetails();
  }
}

class _ProductDetails extends State<ProductDetails> {
  String _title = 'G Class';
  String _owner = 'Rak';
  double _price = 1000000;
  String _currency = 'SAR';
  String _description =
      'product description, Gclass used like new. trip: 10000, Color: black, Model: G63';
  final String _biddersLable = 'Highest Bidders';
  String _timer = "";
  double _rate = 3.5;
  String _ImageURL = '';
  Map<dynamic, dynamic> _highestBid = {};
  String clientId =
      'AX_ojLqki3L611f-Azcw1kqbvO2AxA0LOw3-oE6orUIQ2mQAbvs7b_RnKx76-qUvKI1KN5DL6i1erkz3';
  String secret =
      'EA8_E5whS7qNbt5mamhMhXF1mWXa3hJzgf2RSIV734QM3VmeSt0k34yBmWlcVIquuDomYrmg9mWzB19u';

  String returnURL = 'return.example.com';
  String cancelURL = 'cancel.example.com';
  int expiredDateDaysLeft = 0;

  void _editProducts(String id, final data) {
    widget.t = Transaction(data['URL'],
        id: id,
        ProductName: data['ProductName'],
        ProductPrice: data['ProductPrice'].toDouble(),
        ProductDescription: data['ProductDescription'],
        date: data['ts'],
        owner: data['Owner'],
        ExpiredDate: data['ExpiredDate']);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => ProductDetails(
              t: widget.t)), // this mainpage is your page to refresh.
      (Route<dynamic> route) => false,
    );
  }

  void _startEditProduct(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return EditProudct(_editProducts, widget.t);
        });
  }

  Future<Map<dynamic, dynamic>> getProductInformation() async {
    Transaction t = widget.t;

    String picURL = await getImageProduct(t.id);
    final userinfo = await getUser(t.owner);
    userinfo['pic'] = picURL;
    final highestbid = await getBids(t.id);

    if (highestbid.key == '') {
      _highestBid = {};
      return userinfo;
    }
    final highestbidUser = await getUser(highestbid.key);
    highestbidUser['price'] = highestbid.value;
    _highestBid = highestbidUser;
    _highestBid['id'] = highestbid.key;

    return userinfo;
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  @override
  Widget build(BuildContext context) {
    Transaction t = widget.t;
    _title = t.ProductName;
    _price = double.parse(t.ProductPrice.toString());
    _description = t.ProductDescription;
    var dateNow = DateTime.now();
    var expiredDate = DateTime.fromMillisecondsSinceEpoch(t.ExpiredDate);
    expiredDate =
        DateTime(expiredDate.year, expiredDate.month, expiredDate.day);

    expiredDateDaysLeft = daysBetween(dateNow, expiredDate);

    _timer = (expiredDateDaysLeft < 0)
        ? "(Ended)"
        : expiredDateDaysLeft.toString() + " Days left";

    return FutureBuilder(
      future: getProductInformation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          _owner = snapshot.data!['Username'];
          _rate = double.parse(snapshot.data!['Rate'].toString());
          if (snapshot.data!['pic'].toString().isNotEmpty)
            _ImageURL = snapshot.data!['pic'];

          return createWidget(context);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Image getImage(context) {
    if (_ImageURL.isNotEmpty) {
      return Image.network(
        _ImageURL,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      );
    } else {
      return const Image(image: AssetImage('assets/images/defaultimage.png'));
    }
  }

  bool validateButton() {
    Transaction t = widget.t;

    if (_highestBid.isEmpty == null) {
      return true;
    }
    return _highestBid['id'] != getCurrentUserID() &&
        getCurrentUserID() != t.owner;
  }

  Widget getBidsButton(final context) {
    Transaction t = widget.t;
    if (getCurrentUserID() != t.owner && expiredDateDaysLeft >= 0) {
      return ElevatedButton.icon(
        onPressed: () {
          if (validateButton()) {
            Bid(widget.t.id);

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetails(
                      t: widget.t)), // this mainpage is your page to refresh.
              (Route<dynamic> route) => false,
            );
          }
        },
        icon: const Icon(Icons.gavel_rounded),
        label: const Text('Bid'),
        style: ElevatedButton.styleFrom(
          backgroundColor:
              (validateButton()) ? Colors.lightBlueAccent : Colors.grey,
          elevation: 7.0,
          fixedSize: const Size(110.0, 30.0),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget getModifyButton(final context) {
    Transaction t = widget.t;
    if (getCurrentUserID() == t.owner && expiredDateDaysLeft >= 0) {
      return ElevatedButton.icon(
        onPressed: () {
          _startEditProduct(context);
        },
        icon: const Icon(Icons.edit),
        label: const Text('Modify'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.lightBlueAccent,
          elevation: 7.0,
          fixedSize: const Size(110.0, 30.0),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget getDeleteButton(final context) {
    Transaction t = widget.t;

    if (getCurrentUserID() == t.owner && expiredDateDaysLeft >= 0) {
      return ElevatedButton.icon(
        onPressed: () {
          removeProduct(t.id);

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Home()), // this mainpage is your page to refresh.
            (Route<dynamic> route) => false,
          );
        },
        icon: const Icon(Icons.delete_forever),
        label: const Text('Delete'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          elevation: 7.0,
          fixedSize: const Size(110.0, 30.0),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget getPayButton(final context) {
    if (getCurrentUserID() == _highestBid['id'] &&
        getCurrentUserID() != widget.t.owner) {
      return ElevatedButton.icon(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (BuildContext context) => UsePaypal(
                    sandboxMode: true,
                    clientId: clientId,
                    secretKey: secret,
                    returnURL: returnURL,
                    cancelURL: cancelURL,
                    transactions: [
                      {
                        "amount": {
                          "total": "0.1",
                          "currency": "USD",
                          "details": {
                            "subtotal": "0.1",
                            "shipping": '0',
                            "shipping_discount": 0
                          }
                        },
                        "description": "The payment transaction description.",
                        // "payment_options": {
                        //   "allowed_payment_method":
                        //       "INSTANT_FUNDING_SOURCE"
                        // },
                        "item_list": {
                          "items": [
                            {
                              "name": "A demo product",
                              "quantity": 1,
                              "price": "0.1",
                              "currency": "USD"
                            }
                          ],
                        }
                      }
                    ],
                    note: "Contact us for any questions on your order.",
                    onSuccess: (Map params) async {
                      print("onSuccess: $params");
                      Fluttertoast.showToast(
                          msg: "Success",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    },
                    onError: (error) {
                      print("onError: $error");
                      Fluttertoast.showToast(
                          msg: "Error",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    },
                    onCancel: (params) {
                      print('cancelled: $params');
                      Fluttertoast.showToast(
                          msg: "Canceld",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.orange,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    })),
          );
        },
        icon: const Icon(Icons.payment),
        label: const Text('Pay'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 1, 102, 242),
          elevation: 7.0,
          fixedSize: const Size(110.0, 30.0),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget createWidget(context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: getAppBar(context),
      body: SingleChildScrollView(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: getImage(context),
                ),
                Container(
                  height: 300,
                  margin: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              _title,
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              // padding: EdgeInsets.all(2),
                              child: Row(children: <Widget>[
                                Text(
                                  _owner,
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 25),
                                ),
                                RatingBar.builder(
                                  itemSize: 20.0,
                                  maxRating: 5,
                                  ignoreGestures: true,
                                  initialRating: _rate,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.blue,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                              ]),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.amber[700],
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(4))),
                                child: Text(
                                  _price.toStringAsFixed(1) + ' ' + _currency,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: Text(_timer),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            _description,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            (_highestBid.isEmpty ||
                                    _highestBid['id'] == widget.t.owner)
                                ? "No bids"
                                : "Highest bidder : ${_highestBid['Username']} ( ${_highestBid['price']} SAR )",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                            // height: 200,
                            ),
                        Center(
                          heightFactor: 2.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              //fixedSize: const Size(170.0, 30.0),

                              getBidsButton(context),
                              getModifyButton(context),
                              getDeleteButton(context),
                              getPayButton(context),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
