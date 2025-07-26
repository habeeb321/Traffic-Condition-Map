import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:traffic_condition_map/home_screen/model/traffic_image_model.dart';
import '../controller/traffic_image_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final controller = Get.put(TrafficImageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: Obx(() {
        if (controller.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final trafficData = controller.trafficImageModel.value;
        if (trafficData == null ||
            trafficData.items == null ||
            trafficData.items!.isEmpty ||
            trafficData.items![0].cameras == null ||
            trafficData.items![0].cameras!.isEmpty) {
          return const Center(child: Text('No traffic camera data found.'));
        }

        final List<Marker> markers =
            trafficData.items![0].cameras!.map((camera) {
          final id = camera.cameraId ?? '';
          final lat = camera.location?.latitude ?? 0.0;
          final lng = camera.location?.longitude ?? 0.0;
          return Marker(
            markerId: MarkerId(id),
            position: LatLng(lat, lng),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => _CameraImageSheet(camera: camera),
                showDragHandle: true,
              );
            },
            infoWindow: InfoWindow(title: 'Camera $id'),
          );
        }).toList();

        
        final CameraPosition initialCameraPosition = CameraPosition(
          target: LatLng(
            trafficData.items![0].cameras![0].location?.latitude ?? 1.3,
            trafficData.items![0].cameras![0].location?.longitude ?? 103.8,
          ),
          zoom: 12,
        );

        return GoogleMap(
          initialCameraPosition: initialCameraPosition,
          markers: Set<Marker>.of(markers),
          myLocationButtonEnabled: false,
          mapType: MapType.normal,
        );
      }),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      title: const Text('Traffic Condition Map',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
      centerTitle: true,
      backgroundColor: Colors.blue,
    );
  }
}

class _CameraImageSheet extends StatelessWidget {
  final Camera camera;

  const _CameraImageSheet({required this.camera});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Camera ID: ${camera.cameraId ?? ""}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            if (camera.image != null)
              Image.network(camera.image!, fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return const Center(child: CircularProgressIndicator());
              }),
            const SizedBox(height: 12),
            Text(
                'Timestamp: ${camera.timestamp?.toLocal().toString() ?? "N/A"}'),
            Text(
                'Location: ${camera.location?.latitude}, ${camera.location?.longitude}'),
          ],
        ),
      ),
    );
  }
}
