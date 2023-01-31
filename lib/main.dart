import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:free_fire_location/bootstrap.dart';
import 'package:free_fire_location/features/dependency_injection.dart';
import 'package:free_fire_location/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  // ignore: deprecated_member_use
  BlocOverrides.runZoned(
    () {
      DependencyInjection().setup();
      runApp(const MyApp());
    },
    blocObserver: Bootstrap(),
  );
}
