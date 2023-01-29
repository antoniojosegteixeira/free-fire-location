import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:free_fire_location/features/dependency_injection.dart';
import 'package:free_fire_location/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection().setup();
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}
