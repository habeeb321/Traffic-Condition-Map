// To parse this JSON data, do
//
//     final trafficImageModel = trafficImageModelFromJson(jsonString);

import 'dart:convert';

TrafficImageModel trafficImageModelFromJson(String str) =>
    TrafficImageModel.fromJson(json.decode(str));

String trafficImageModelToJson(TrafficImageModel data) =>
    json.encode(data.toJson());

class TrafficImageModel {
  List<Item>? items;
  ApiInfo? apiInfo;

  TrafficImageModel({
    this.items,
    this.apiInfo,
  });

  factory TrafficImageModel.fromJson(Map<String, dynamic> json) =>
      TrafficImageModel(
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        apiInfo: json["api_info"] == null
            ? null
            : ApiInfo.fromJson(json["api_info"]),
      );

  Map<String, dynamic> toJson() => {
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "api_info": apiInfo?.toJson(),
      };
}

class ApiInfo {
  String? status;

  ApiInfo({
    this.status,
  });

  factory ApiInfo.fromJson(Map<String, dynamic> json) => ApiInfo(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}

class Item {
  DateTime? timestamp;
  List<Camera>? cameras;

  Item({
    this.timestamp,
    this.cameras,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        timestamp: json["timestamp"] == null
            ? null
            : DateTime.parse(json["timestamp"]),
        cameras: json["cameras"] == null
            ? []
            : List<Camera>.from(
                json["cameras"]!.map((x) => Camera.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp?.toIso8601String(),
        "cameras": cameras == null
            ? []
            : List<dynamic>.from(cameras!.map((x) => x.toJson())),
      };
}

class Camera {
  DateTime? timestamp;
  String? image;
  Location? location;
  String? cameraId;
  ImageMetadata? imageMetadata;

  Camera({
    this.timestamp,
    this.image,
    this.location,
    this.cameraId,
    this.imageMetadata,
  });

  factory Camera.fromJson(Map<String, dynamic> json) => Camera(
        timestamp: json["timestamp"] == null
            ? null
            : DateTime.parse(json["timestamp"]),
        image: json["image"],
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        cameraId: json["camera_id"],
        imageMetadata: json["image_metadata"] == null
            ? null
            : ImageMetadata.fromJson(json["image_metadata"]),
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp?.toIso8601String(),
        "image": image,
        "location": location?.toJson(),
        "camera_id": cameraId,
        "image_metadata": imageMetadata?.toJson(),
      };
}

class ImageMetadata {
  int? height;
  int? width;
  String? md5;

  ImageMetadata({
    this.height,
    this.width,
    this.md5,
  });

  factory ImageMetadata.fromJson(Map<String, dynamic> json) => ImageMetadata(
        height: json["height"],
        width: json["width"],
        md5: json["md5"],
      );

  Map<String, dynamic> toJson() => {
        "height": height,
        "width": width,
        "md5": md5,
      };
}

class Location {
  double? latitude;
  double? longitude;

  Location({
    this.latitude,
    this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}
