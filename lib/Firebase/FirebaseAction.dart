import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void AddProduct(data) async {
  FirebaseDatabase database = FirebaseDatabase.instance;
  final pid = Uuid().v4();
  await database.ref("/Product/$pid").set(data);
  await database
      .ref("/Bidders/$pid")
      .set({data['Owner']: data['ProductPrice']});
}

void removeProduct(key) async {
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = database.ref("/Product/" + key);

  await ref.remove();
}

void updateProduct(key, data) async {
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = database.ref("/Product/" + key);
  await ref.set(data);
}

Future<Map<dynamic, dynamic>> getAllProduct() async {
  FirebaseDatabase database = FirebaseDatabase.instance;
  final ref = FirebaseDatabase.instance.ref();
  final snapShots = await ref.child("/Product").get();
  Map<dynamic, dynamic> values = snapShots.value as Map<dynamic, dynamic>;
  return values;
}

Future<Map<dynamic, dynamic>> getAllUserBids() async {
  FirebaseDatabase database = FirebaseDatabase.instance;
  final ref = FirebaseDatabase.instance.ref();
  User? user = FirebaseAuth.instance.currentUser;

  final snapShots = await ref.child("/UsersBids/ ${user!.uid}").once();
  Map<dynamic, dynamic> values =
      snapShots.snapshot.value as Map<dynamic, dynamic>;

  return values;
}

Future<Map<dynamic, dynamic>> getProduct(key) async {
  FirebaseDatabase database = FirebaseDatabase.instance;
  final ref = FirebaseDatabase.instance.ref();
  final snapShots = await ref.child("/Product/" + key).once();

  return snapShots.snapshot.value as Map<dynamic, dynamic>;
}

Future<List<String>> searchProduct(name) async {
  FirebaseDatabase database = FirebaseDatabase.instance;
  final ref = FirebaseDatabase.instance.ref();
  final snapShots = await ref.child("/Product").get();
  Map<dynamic, dynamic> snapshotValue =
      snapShots.value as Map<dynamic, dynamic>;
  List<String> searchValue = [];

  snapshotValue.forEach((key, value) {
    var pn = value['ProductName'].toString().toLowerCase();
    if (pn.contains(name)) {
      searchValue.add('$pn;xxx;$key');
    }
  });

  return searchValue;
}

void AddNewUser(data) async {
  FirebaseDatabase database = FirebaseDatabase.instance;
  User? user = FirebaseAuth.instance.currentUser;
  final ref = FirebaseDatabase.instance.ref("/Users/ ${user?.uid}");
  await ref.set(data);
}

void Bid(pID, price) async {
  FirebaseDatabase database = FirebaseDatabase.instance;
  User? user = FirebaseAuth.instance.currentUser;
  final userBid = FirebaseDatabase.instance.ref("/Bidders/${pID}/${user!.uid}");
  await userBid.set(price);

  final ref = FirebaseDatabase.instance.ref("/UsersBids/ ${user.uid}");
  await ref.set({pID: price});
}

void comments(pID, comments) async {
  FirebaseDatabase database = FirebaseDatabase.instance;
  User? user = FirebaseAuth.instance.currentUser;
  var pid = Uuid().v4();
  final userComments = FirebaseDatabase.instance.ref("/Comments/${pID}/${pid}");
  await userComments.set({'uid': user!.uid, 'comment': comments});
}
