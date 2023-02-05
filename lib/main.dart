import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_fire_location/bootstrap.dart';
import 'package:free_fire_location/core/env/env.dart';
import 'package:free_fire_location/features/dependency_injection.dart';
import 'package:free_fire_location/my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.load();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // ignore: deprecated_member_use
  BlocOverrides.runZoned(
    () {
      DependencyInjection().setup();
      runApp(const MyApp());
    },
    blocObserver: Bootstrap(),
  );
}
