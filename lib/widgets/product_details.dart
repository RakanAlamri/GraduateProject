import 'package:final_project/HomePage.dart';
import 'package:final_project/models/transaction.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../ProfileNavigationDrawer.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../Navbars.dart';
import '../Firebase/FirebaseAction.dart';

class ProductDetails extends StatelessWidget {
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

  final Transaction t;
  ProductDetails({super.key, required this.t});

  Future<Map<dynamic, dynamic>> getProductInformation() async {
    String picURL = await getImageProduct(t.id);
    final userinfo = await getUser(t.owner);
    userinfo['pic'] = picURL;
    return userinfo;
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  @override
  Widget build(BuildContext context) {
    _title = t.ProductName;
    _price = t.ProductPrice.toDouble();
    _description = t.ProductDescription;
    var dateNow = DateTime.now();
    var expiredDate = DateTime.fromMillisecondsSinceEpoch(t.ExpiredDate);
    expiredDate =
        DateTime(expiredDate.year, expiredDate.month, expiredDate.day);
    _timer = daysBetween(dateNow, expiredDate).toString() + " Days left";

    return FutureBuilder(
      future: getProductInformation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          _owner = snapshot.data!['Username'];
          _rate = snapshot.data!['Rate'];
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

  Widget createWidget(context) {
    return Scaffold(
      appBar: getAppBar(context),
      drawerScrimColor: Colors.black38,
      drawer: const ProfileNavigationDrawer(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(8.0),
                child: getImage(context),
              ),
              Container(
                height: 300,
                margin: EdgeInsets.all(8.0),
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
                            style: TextStyle(
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
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 25),
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
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
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
                        child: Flexible(
                          child: Text(
                            _description,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          _biddersLable,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                          // height: 200,
                          )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
