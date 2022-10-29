import 'package:flutter/material.dart';
import '../ProfileNavigationDrawer.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetails extends StatelessWidget {
  String _title = 'G Class';
  final String _onwer = 'Rak';
  final double _price = 1000000;
  final String _currency = 'SAR';
  final String _description =
      'product description, Gclass used like new. trip: 10000, Color: black, Model: G63';
  final String _biddersLable = 'Highest Bidders';
  ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Padding(
          padding: const EdgeInsets.only(left: 77),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ZAWD',
                style: TextStyle(
                  fontFamily: 'Bellota',
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
              Icon(
                Icons.notifications_none_outlined,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
      drawerScrimColor: Colors.black38,
      drawer: const ProfileNavigationDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            child: Image.network(
              'https://thumbs.dreamstime.com/b/chisinau-moldova-mar%D1%81h-mercedes-benz-brabus-g-v-cv-g-amg-w-mercedes-benz-brabus-g-176915907.jpg',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
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
                            _onwer,
                            style: TextStyle(color: Colors.grey, fontSize: 25),
                          ),
                          RatingBar.builder(
                            itemSize: 20.0,
                            maxRating: 5,
                            ignoreGestures: true,
                            initialRating: 3.5,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
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
                          child: Text('timer'),
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
    );
  }
}
