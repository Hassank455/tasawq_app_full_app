import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tik_laen_taswaq2/models/direction.dart';

class DirectionsRepository {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';

  final Dio _dio;

  DirectionsRepository({Dio? dio}) : _dio = dio ?? Dio();

  Future<Directions?> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'origin': '${origin.latitude},${origin.longitude}',
        'destination': '${destination.latitude},${destination.longitude}',
        'key': 'AIzaSyDtYRQEOzu3JT1gSi_ddWK8lJEP9ApX-2o',
      },
    );

    // Check if response is successful
    if (response.statusCode == 200) {
      if ((response.data['routes'] as List).isEmpty) return null;

      return Directions.fromMap(response.data);
    }
    return null;
  }
}