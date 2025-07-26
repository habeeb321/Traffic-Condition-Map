import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:traffic_condition_map/home_screen/model/traffic_image_model.dart';
import 'package:traffic_condition_map/service/home_service.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class TrafficImageController extends GetxController {
  Rx<TrafficImageModel?> trafficImageModel = TrafficImageModel().obs;
  final loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTrafficImage();
  }

  Future<void> fetchTrafficImage() async {
    loading.value = true;
    try {
      String dateTime = getCurrentDateTimeSGT();
      TrafficImageModel? result = await HomeService.getTrafficImage(
        dateTime: dateTime,
      );
      if (result != null) {
        trafficImageModel.value = result;
      }
    } catch (e) {
      debugPrint("fetchTrafficImage Error: $e");
    }
    loading.value = false;
  }

  String getCurrentDateTimeSGT() {
    tz.initializeTimeZones();
    final sgt = tz.getLocation('Asia/Singapore');
    final now = tz.TZDateTime.now(sgt);
    final formatted = DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(now);
    return formatted;
  }
}
