import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../ProfileNavigationDrawer.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

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
      body: Container(
        // width: double.infinity,
        // margin: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.network(
              'https://thumbs.dreamstime.com/b/chisinau-moldova-mar%D1%81h-mercedes-benz-brabus-g-v-cv-g-amg-w-mercedes-benz-brabus-g-176915907.jpg',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[],
            )
          ],
        ),
      ),
    );
  }
}
