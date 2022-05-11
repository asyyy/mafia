import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

import 'dot.dart';

class PolygonModel {
  /// Implementation of a polygon
  PolygonModel(
      {
      required this.dots,
      required this.interventionId,
        this.id,
        this.color,
        this.dotted,
        this.thickness
      });
  String? id;
  List<LatLng> dots;
  Color? color;
  bool? dotted;
  String interventionId;
  double? thickness = 4.0;

  /// Get marker of Vehicle
  Polyline getPolyline() {
    return Polyline(
      points: dots,
      strokeWidth: thickness?? 4,
      isDotted: dotted?? false,
      color: color?? Colors.black
    );
  }
  List<Map<String, dynamic>> dotsToJson() {
    return List<Map<String,dynamic>>.from(dots.map((value) => {'x':value.latitude,'y':value.longitude}));
  }


  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};

    if(color != null) json.putIfAbsent('color', () => color);
    if(dotted != null) json.putIfAbsent('dotted', () => dotted);
    if(thickness != null) json.putIfAbsent('thickness', () => thickness);
    if(dots.isNotEmpty) json.putIfAbsent('lines', () => dotsToJson());
    json.putIfAbsent('interventionId', () => interventionId);

    return json;
  }

  factory PolygonModel.fromJson(Map<dynamic, dynamic> json) => PolygonModel(
      id: json["_id"],
      interventionId: json['interventionId'],
      color: json['json'],
      dotted: json['dotted'],
      thickness: json['thickness'],
      dots: List<LatLng>.from(json['lines'].map((value)=> DotModel.fromJson((value)).toLatLng())),
  );

  @override
  String toString() {
    return 'PolygonModel{id: $id, dots: $dots, color: $color, dotted: $dotted, interventionId: $interventionId, thickness: $thickness}';
  }
}
