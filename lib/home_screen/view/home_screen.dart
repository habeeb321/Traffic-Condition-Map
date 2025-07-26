import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:traffic_condition_map/home_screen/controller/traffic_image_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.put(TrafficImageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      title: const Text(
        'Traffic Condition Map',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.blue,
    );
  }

  Widget _buildBody() {
    return const Center(
      child: Text('Home Screen'),
    );
  }
}
