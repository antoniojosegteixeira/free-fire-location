import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:free_fire_location/firebase_options.dart';
import 'package:free_fire_location/my_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
