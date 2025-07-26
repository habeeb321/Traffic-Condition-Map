import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:traffic_condition_map/home_screen/model/traffic_image_model.dart';

class HomeService {
  static final Dio dio = Dio();

  static Future<TrafficImageModel?> getTrafficImage({
    required String dateTime,
  }) async {
    final headers = {
      'Accept': 'application/json',
    };

    try {
      Response response = await dio.get(
        'https://api.data.gov.sg/v1/transport/traffic-images?date_time=$dateTime',
        options: Options(headers: headers),
      );

      if (response.statusCode == 200 && response.data != null) {
        debugPrint('Success: ${response.data}');
        if (response.data is String) {
          Map<String, dynamic> data = jsonDecode(response.data);
          return TrafficImageModel.fromJson(data);
        } else if (response.data is Map) {
          Map<String, dynamic> data = response.data;
          return TrafficImageModel.fromJson(data);
        } else {
          debugPrint('Unexpected response format');
          return null;
        }
      } else {
        debugPrint('HTTP Error: Status code ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('getTrafficImage Error : $e');
    }
    return null;
  }
}
