import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:projet_groupe_c/model/symbol.dart';
import 'package:projet_groupe_c/model/polygon.dart';
import 'package:projet_groupe_c/model/vehicle.dart';

class InterventionModel {


  /// Implementation of an intervention
  InterventionModel(
      {
      required this.label,
      required this.startDate,
      required this.longitude,
      required this.latitude,
      required this.sinisterTypeId,
      required this.labelAddress,
      this.endDate,
      this.id}){
  }
  String? id;
  String label;
  String startDate;
  String? endDate;
  int sinisterTypeId;
  String labelAddress;
  List<VehicleModel> vehicles = [];
  List<SymbolModel> symbols = [];
  List<PolygonModel> polygons = [];
  double longitude;
  double latitude;

  /// Create InterventionModel from JSON
  factory InterventionModel.fromJson(Map<String, dynamic> json) =>
      InterventionModel(
          id: json["_id"],
          label: json['label'],
          startDate: json['startDate'],
          endDate: json['endDate'],
          sinisterTypeId: json['sinisterTypeId'],
          labelAddress: json['labelAddress'],
          longitude: double.parse(json['longitude']),
          latitude: double.parse(json['latitude']));

  /// Export InterventionModel as JSON
  Map<String, dynamic> toJson(){
    Map<String, dynamic> json = {};
    if(id != null) json.putIfAbsent('_id', () => id);
    if(endDate != null) json.putIfAbsent('endDate', () => endDate);
    json.putIfAbsent('label', () => label);
    json.putIfAbsent('startDate', () => startDate);
    json.putIfAbsent('longitude', () => longitude.toString());
    json.putIfAbsent('latitude', () => latitude.toString());
    json.putIfAbsent('sinisterTypeId', () => sinisterTypeId);
    json.putIfAbsent('labelAddress', () => labelAddress);
    
    return json;
  }


  /// Get list of markers for each vehicles
  List<Marker> getVehiclesMarkers({listener}) {
    List<Marker> markers = [];
    for (VehicleModel v in vehicles) {
      markers.add(v.icon!.getMarker(listener: listener));
    }
    return markers;
  }

  /// Get list of markers for each marker
  List<Marker> getSymbolsMarkers({listener}) {
    List<Marker> tmpsymbols = [];
    for (SymbolModel m in symbols) {
      tmpsymbols.add(m.icon.getMarker(listener: listener));
    }
    return tmpsymbols;
  }

  /// Get list of markers for each marker
  List<Polyline> getPolygonPolyline() {
    List<Polyline> tmpPolygons = [];
    for (PolygonModel p in polygons) {
      tmpPolygons.add(p.getPolyline());
    }
    return tmpPolygons;
  }

  /// Get position of intervention
  LatLng getposition() {
    return LatLng(latitude, longitude);
  }

  List<Marker> getAllMarkers({listener}) {
    List<Marker> allMarkers = [];
    allMarkers.addAll(getVehiclesMarkers(listener: listener));
    allMarkers.addAll(getSymbolsMarkers(listener: listener));
    return allMarkers;
  }

  @override
  String toString() {
    return 'InterventionModel{id: $id, label: $label, startDate: $startDate, endDate: $endDate, sinisterTypeId: $sinisterTypeId, labelAddress: $labelAddress, vehicles: $vehicles, symbols: $symbols, polygons: $polygons, longitude: $longitude, latitude: $latitude}';
  }
}
