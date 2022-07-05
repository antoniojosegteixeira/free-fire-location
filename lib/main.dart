import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:free_fire_location/firebase_options.dart';
import 'package:free_fire_location/my_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    /// Runs in the background
    /// Called periodically
    print("CALLED");
    int numberOfNearbyFires = 1;

    return Future.value(true);
  });
}

Future<void> backgroundFunctions() async {
  Future.wait([
    Workmanager().initialize(callbackDispatcher, isInDebugMode: true),
    Workmanager().registerPeriodicTask(
      "periodic-task-identifier",
      "map-update",
      // When no frequency is provided the default 15 minutes is set.
      // Minimum frequency is 15 min. Android will automatically change your frequency to 15 min if you have configured a lower frequency.
      frequency: const Duration(minutes: 15),
    )
  ]);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await backgroundFunctions();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
