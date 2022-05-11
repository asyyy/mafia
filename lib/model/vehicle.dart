import 'package:latlong2/latlong.dart';
import 'package:projet_groupe_c/model/iconModel.dart';

class VehicleModel {
  /// Implementation of a vehicle
  VehicleModel({
    required this.departureDate,
    required this.arrivedDateEst,
    required this.interventionId,
    required this.vehicleTypeId,
    required this.sinisterTypeId,
    required this.validationStateId,
    required this.name,
    this.icon,
    this.arrivedDateReal,
    this.id,

  });

  String? id;
  String name;
  int validationStateId;
  int sinisterTypeId;
  int vehicleTypeId;
  String departureDate;
  String arrivedDateEst;
  String? arrivedDateReal;
  String? interventionId;
  IconModel? icon;

  /// Get position of Vehicle
  LatLng? getPosition() {
    return icon?.getPosition();
  }

  factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
      id: json['_id'],
      name: json['name'],
      validationStateId: json['validationStateId'],
      sinisterTypeId: json['sinisterTypeId'],
      vehicleTypeId: json['vehicleTypeId'],
      departureDate: json['departureDate'],
      arrivedDateEst: json['arrivedDateEst'],
      arrivedDateReal: json['arrivedDateReal'],
      interventionId: json['interventionId'],
      icon: json['icon'] == null ? null : IconModel.fromJson(json['icon']));

  /// Export VehicleModel as JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if(id != null) json.putIfAbsent('_id', () => id);
    if(arrivedDateReal != null) json.putIfAbsent('arrivedDateReal', () => arrivedDateReal);
    if(icon != null) json.putIfAbsent('icon', () => icon?.toJson());
    json.putIfAbsent('name', () => name);
    json.putIfAbsent('sinisterTypeId', () => sinisterTypeId);
    json.putIfAbsent('validationStateId', () => validationStateId);
    json.putIfAbsent('vehicleTypeId', () => vehicleTypeId);
    json.putIfAbsent('interventionId', () => interventionId);
    json.putIfAbsent('departureDate', () => departureDate);
    json.putIfAbsent('arrivedDateEst', () => arrivedDateEst);

    return json;
  }

  @override
  String toString() {
    return 'VehicleModel{id: $id, name: $name, validationStateId: $validationStateId, sinisterTypeId: $sinisterTypeId, vehicleTypeId: $vehicleTypeId, departureDate: $departureDate, arrivedDateEst: $arrivedDateEst, arrivedDateReal: $arrivedDateReal, interventionId: $interventionId, icon: $icon}';
  }
}
