import 'package:flutter/material.dart';
import 'package:traffic_condition_map/home_screen/model/traffic_image_model.dart';

class CameraImageSheet extends StatelessWidget {
  final Camera camera;

  const CameraImageSheet({super.key, required this.camera});

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
