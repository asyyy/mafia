import 'package:latlong2/latlong.dart';

/// Une classe qui permet de faire passerele entre le json du back et la class LatLng
class DotModel {
  DotModel({this.id,required this.latitude, required this.longitude}){
    this.latLng = LatLng(latitude,longitude);
  }
  String? id;
  double latitude;
  double longitude;
  LatLng? latLng;

  factory DotModel.fromJson(Map<dynamic,dynamic> json) => DotModel(
    id: json['_id'],
    latitude: json['x'] +.0, // Magic trick to cast an int to a double
    longitude: json['y']+.0,
  );
  LatLng toLatLng(){
    return LatLng(latitude,longitude);
  }
}