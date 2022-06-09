import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:locate_me_now/screens/home/.env.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'directions_model.dart';

class DirectionsRespository {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?origin=LAT,LON&destination=LAT,LON&key=AIzaSyC9PC0oBWvhU9szHJg9LpaQeMgxJ_1AyKw';

  final Dio _dio;

  DirectionsRespository({Dio? dio}) : _dio = dio ?? Dio();

  Future<Directions?> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'origin': '${origin.latitude},${origin.longitude}',
        'destination': '${destination.latitude},${destination.longitude}',
        'key': googleAPIKey,
      },
    );

    // Check if response is successful
    if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    }
    return null;
  }
}
