import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void AddProduct(data) async {
  FirebaseDatabase database = FirebaseDatabase.instance;
  var uuid = Uuid().v4();
  DatabaseReference ref = database.ref("/Product/" + uuid);
  await ref.set(data);
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
  final snapShots = await ref.child("/Product" + key).once();

  return snapShots;
}
