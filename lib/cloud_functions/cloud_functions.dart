import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_database/firebase_database.dart';

class CloudFunctions {
  FirebaseFunctions functions = FirebaseFunctions.instance;
  FirebaseDatabase db = FirebaseDatabase.instance;

  void checkIfMarkerIsFinished() async {
    final DatabaseReference ref =
        FirebaseDatabase.instance.ref("markersMatrix");

    final DataSnapshot response = await ref.get();

    final value = Map<String, dynamic>.from(response.value as Map);
    final markers = value["userMarkers"];
    final DateTime dateNow = DateTime.now().toUtc();

    for (var item in markers.values) {
      final DateTime date = DateTime.parse(item['data']);
      if (date.hour > dateNow.hour + 2) {
        await ref.child("userMarkers").child("${item.id}").remove();
      }
    }
  }
}
