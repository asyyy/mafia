import 'package:projet_groupe_c/model/iconModel.dart';
import 'package:latlong2/latlong.dart';

class SymbolModel {
  /// Implementation of a polygon
  SymbolModel(
      {
      required this.sinisterTypeId,
      required this.interventionId,
      required this.icon,
      this.id});

  String? id;
  int sinisterTypeId;
  String? interventionId;
  IconModel icon;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json= {} ;
    if(id != null) json.putIfAbsent('_id', () => id);
    json.putIfAbsent('sinisterTypeId', () => sinisterTypeId);
    json.putIfAbsent('interventionId', () => interventionId);
    json.putIfAbsent('icon', () => icon.toJson());
    return json;
  }
  factory SymbolModel.fromJson(Map<dynamic, dynamic> json) => SymbolModel(
      id: json["_id"],
      sinisterTypeId: json['sinisterTypeId'],
      interventionId: json['interventionId'],
      icon: IconModel.fromJson(json['icon']));

  /// Get position of Symbol
  LatLng? getPosition() {
    return icon.getPosition();
  }
  @override
  String toString() {
    return 'SymbolModel{id: $id, sinisterTypeId: $sinisterTypeId, interventionId: $interventionId, icon: $icon}';
  }
}
