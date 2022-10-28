import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void AddProduct(data) async {
  User? user = FirebaseAuth.instance.currentUser;

  FirebaseDatabase database = FirebaseDatabase.instance;
  var pid = Uuid().v4();
  DatabaseReference ref1 = database.ref("/Product/$pid");
  await ref1.set(data);
  await database
      .ref("/Bidders/$pid")
      .set({data['Owner']: data['ProductPrice']});

  Bid(pid, data['ProductPrice'] + 1);
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

Future<DatabaseEvent> getProduct(key) async {
  FirebaseDatabase database = FirebaseDatabase.instance;
  final ref = FirebaseDatabase.instance.ref();
  final snapShots = await ref.child("/Product/" + key).once();

  return snapShots;
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
  final userBid =
      await FirebaseDatabase.instance.ref("/Bidders/${pID}/${user!.uid}");
  await userBid.set({'bid': price});

  final ref = FirebaseDatabase.instance.ref("/UsersBids/ ${user.uid}");
  await ref.set({pID: price});
}

void addComment(pid, comment) async {}
