import 'dart:async';
import 'dart:collection';
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
      "assets/images/user_map_icon.png",
    );

    return userMarkerImage;
  }

  String _idGenerator() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch.toString();
  }

  void getUserReport() async {
    initRef();
    emit.call(FirebaseLoading());
    final userFireIcon = await _loadMarkers();
    List<UserFireResponse> userFireList = [];

    try {
      Stream<DatabaseEvent> stream = markersMatrixRef.onValue;

      stream.listen((DatabaseEvent event) {
        var value = Map<String, dynamic>.from(event.snapshot.value as Map);
        var markers = value["userMarkers"];

        if (markers != null) {
          userFireList.clear();
          for (var item in markers.values) {
            userFireList.add(UserFireResponse.fromJson(item));
          }
        }

        emit.call(FirebaseSuccess(
            userFireList: userFireList, userMarkerImage: userFireIcon));
      });
      emit.call(FirebaseSuccess(
          userFireList: userFireList, userMarkerImage: userFireIcon));
    } catch (error) {
      emit.call(FirebaseError(error: error as Error));
    }

    markersMatrixSubscription =
        markersMatrixRef.onValue.listen((DatabaseEvent event) {});
  }

  void postUserReport(double latitude, double longitude) async {
    final now = DateTime.now();
    final String randomId = _idGenerator();
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("markersMatrix/userMarkers/$randomId");

    String postDate = now.toUtc().toString();
    await ref.set({
      'id': randomId,
      'latitude': latitude,
      'longitude': longitude,
      'data': postDate
    });
  }
}
