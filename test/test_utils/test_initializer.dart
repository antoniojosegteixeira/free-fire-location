import 'package:flutter_test/flutter_test.dart';
import 'package:free_fire_location/core/env/env.dart';

class TestInitializer {
  static Future<void> start() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Env.load();
  }
}
