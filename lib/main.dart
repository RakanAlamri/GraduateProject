import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import './Firebase/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(
    title: 'Zawd',
    home: Login(),
  ));
}
