import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';

class IconModel {
  /// Implementation of a polygon
  IconModel(
      {required this.orientation,
      required this.size,
      required this.label,
      required this.latitude,
      required this.longitude,
      this.id,
      this.color});
  int orientation;
  int size;
  String label;
  double latitude;
  double longitude;
  Color? color;
  String? id;

  factory IconModel.fromJson(Map<String, dynamic> json) => IconModel(
      id: json["_id"] ?? 'No id',
      orientation: json["orientation"],
      size: json["size"],
      label: json["label"],
      longitude: double.parse(json["longitude"]),
      latitude: double.parse(json["latitude"]));

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (id != null) json.putIfAbsent('_id', () => id);
    if (color != null) json.putIfAbsent('color', () => color);
    json.putIfAbsent('orientation', () => orientation);
    json.putIfAbsent('size', () => size);
    json.putIfAbsent('latitude', () => latitude);
    json.putIfAbsent('longitude', () => longitude);
    json.putIfAbsent('label', () => label);

    return json;
  }

  /// Get marker of Vehicle
  Marker getMarker({listener}) {
    //TODO modifier avec les icones prévu
    IconData icon = Icons.directions_car;

    return Marker(
      rotate: true,
      width: size.toDouble(),
      height: size.toDouble(),
      point: getPosition(),
      builder: (ctx) => GestureDetector(
        onTap: () {
          print("Click on " + label);
          if (listener != null) {
            listener(this);
          }
        },
        child: Icon(icon, color: color, size: size.toDouble()),
      ),
    );
  }

  LatLng getPosition() {
    return LatLng(latitude, longitude);
  }

  @override
  String toString() {
    return 'IconModel{orientation: $orientation, size: $size, label: $label, latitude: $latitude, longitude: $longitude, color: $color, id: $id}';
  }
}
