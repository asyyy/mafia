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
      required this.color,
      required this.iconId});
  double orientation;
  double size;
  String label;
  double latitude;
  double longitude;
  Color color;
  int iconId;

  Map<String, dynamic> toJson() => {
        "orientation": orientation,
        "size": size,
        "latitude": latitude,
        "longitude": longitude,
        "label": label,
        "color": color,
        "iconId": iconId
      };

  /// Get marker of Vehicle
  Marker getMarker({listener}) {
    //TODO modifier avec les icones prévu
    IconData icon = Icons.directions_car;

    return Marker(
      rotate: true,
      width: size,
      height: size,
      point: getPosition(),
      builder: (ctx) => GestureDetector(
        onTap: () {
          print("Click on " + label);
          if (listener != null) {
            listener(this);
          }
        },
        child: Icon(icon, color: color, size: size),
      ),
    );
  }

  @override
  String toString() {
    return "orientation : " +
        orientation.toString() +
        "\nsize : " +
        size.toString() +
        "\nlabel : " +
        label +
        "\nLatitude : " +
        latitude.toString() +
        "\nlongitude : " +
        longitude.toString() +
        "\ncolor : " +
        color.toString() +
        "\niconId : " +
        iconId.toString();
  }

  LatLng getPosition() {
    return LatLng(latitude, longitude);
  }
}
