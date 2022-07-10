import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:free_fire_location/map/data/response_models/user_fire_response.dart';
import 'package:free_fire_location/map/view/cubit/firebase/firebase_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FirebaseCubit extends Cubit<FirebaseState> {
  late final DatabaseReference markersMatrixRef;
  late StreamSubscription<DatabaseEvent> markersMatrixSubscription;
  List<Map<String, dynamic>> markersMatrix = [];

  FirebaseCubit() : super(FirebaseLoading());

  void initRef() {
    markersMatrixRef = FirebaseDatabase.instance.ref('markersMatrix');
  }

  Future<BitmapDescriptor> _loadMarkers() async {
    final userMarkerImage = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(20, 20)),
      'asset/images/user_map_icon.png',
    );

    return userMarkerImage;
  }

  String _idGenerator() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch.toString();
  }

  void getUserReport() async {
    emit.call(FirebaseLoading());
    final userFireIcon = await _loadMarkers();

    try {
      final markersMatrixSnapshot = await markersMatrixRef.get();
      markersMatrix = markersMatrixSnapshot.value as List<Map<String, dynamic>>;

      List<UserFireResponse> userFireList = List<UserFireResponse>.from(
        markersMatrix.map(
          (markerInfo) => UserFireResponse.fromJson(markerInfo),
        ),
      );

      emit.call(FirebaseSuccess(
          userFireList: userFireList, userMarkerImage: userFireIcon));
    } catch (e) {
      emit.call(FirebaseError());
    }

    markersMatrixSubscription =
        markersMatrixRef.onValue.listen((DatabaseEvent event) {
      print(event.snapshot.value);
    });

    print(markersMatrix);
  }

  void postUserReport(double latitude, double longitude) async {
    final now = DateTime.now();
    final String randomId = _idGenerator();
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("markersMatrix/$randomId");

    await ref.set({
      'id': randomId,
      'latitude': latitude,
      'longitude': longitude,
      'data': DateTime.utc(now.year, now.month, now.day, now.hour, now.minute)
          .toString()
    });
  }
}
