import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:free_fire_location/features/map/data/models/user_fire_model.dart';
import 'package:free_fire_location/features/map/domain/entities/user_fire_entity.dart';

abstract class FirebaseDatasource {
  Future<List<UserFireEntity>> getUserFires();
  Future<bool> postUserFire({
    required double latitude,
    required double longitude,
    required DateTime date,
  });
}

class FirebaseDatasourceImpl implements FirebaseDatasource {
  FirebaseDatasourceImpl({required this.database});

  final FirebaseFirestore database;

  @override
  Future<List<UserFireEntity>> getUserFires() async {
    try {
      List<UserFireEntity> listOfFires = [];
      final response = await database.collection("userfires").get();
      for (final doc in response.docs) {
        final UserFireEntity fireEntity = UserFireModel.fromJson(doc.data());
        listOfFires.add(fireEntity);
      }

      return listOfFires;
    } catch (e) {
      throw Error();
    }
  }

  @override
  Future<bool> postUserFire({
    required double latitude,
    required double longitude,
    required DateTime date,
  }) async {
    try {
      final userFire = <String, dynamic>{
        "latitude": latitude,
        "longitude": longitude,
        "date": date.toIso8601String(),
      };

      await database.collection("users").add(userFire);
      return true;
    } catch (e) {
      throw Error();
    }
  }
}
