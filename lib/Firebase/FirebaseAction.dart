import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

void AddProduct(pid, data) async {
  FirebaseDatabase database = FirebaseDatabase.instance;
  await database.ref("/Product/$pid").set(data);
  await database
      .ref("/Bidders/$pid")
      .set({data['Owner']: data['ProductPrice']});
}

void removeProduct(key) {
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = database.ref("/Product/" + key);
  ref.remove();
}

void updateProduct(key, data) async {
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = database.ref("/Product/" + key);
  await ref.set(data);
}

Future<Map<dynamic, dynamic>> getAllProduct() async {
  final ref = FirebaseDatabase.instance.ref();
  final snapShots = await ref.child("/Product").get();
  if (snapShots.value == null) return {};

  Map<dynamic, dynamic> snapValues = snapShots.value as Map<dynamic, dynamic>;
  Map<dynamic, dynamic> values = {};

  snapValues.forEach((key, value) {
    if (value['Status'] == true) {
      values[key] = value;
    }
  });
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
    var price = value['ProductPrice'].toString().toLowerCase();
    if (pn.contains(name)) {
      searchValue.add('$pn;xxx;$key;xxx;$price');
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

void EndAuction(pID) {
  FirebaseDatabase database = FirebaseDatabase.instance;
  database.ref("/Product/" + pID + "/Status").set(false);
}

void ChangeProductsDetails(pID, data) {
  FirebaseDatabase database = FirebaseDatabase.instance;
  User? user = FirebaseAuth.instance.currentUser;
  final uid = user?.uid;
  if (uid == null ||
      uid.toLowerCase() != data['Owner'].toString().toLowerCase()) {
    return;
  }

  database.ref("/Product/" + pID).set(data);
}

Future<Map<dynamic, dynamic>> getBids(pid) async {
  FirebaseDatabase database = FirebaseDatabase.instance;
  final ref = FirebaseDatabase.instance.ref();
  final snapShots = await ref.child("/Bidders/" + pid).orderByValue().once();

  Map<dynamic, dynamic> snapValues =
      snapShots.snapshot.value as Map<dynamic, dynamic>;
  final orderedBids = Map.fromEntries(snapValues.entries.toList()
    ..sort((e1, e2) => e2.value.compareTo(e1.value)));

  return orderedBids;
}

Future<Map<dynamic, dynamic>> getUser(uuid) async {
  FirebaseDatabase database = FirebaseDatabase.instance;
  final ref = await FirebaseDatabase.instance.ref("/Users/ ${uuid}").once();
  if (ref.snapshot.value == null) return {};

  Map<dynamic, dynamic> snapValues =
      ref.snapshot.value as Map<dynamic, dynamic>;

  return snapValues;
}

void uploadImageProduct(pid, File image) async {
  final storageRef = FirebaseStorage.instance.ref();
  final imageRef = storageRef.child(pid);
  await imageRef.putFile(image);
}

Future<String> getImageProduct(pid) async {
  final storageRef = FirebaseStorage.instance.ref();
  final imageRef = storageRef.child(pid);
  try {
    final URL = await imageRef.getDownloadURL();
    return URL;
  } on Exception {
    return "";
  }
}
