import 'dart:convert';
import 'package:projet_groupe_c/model/vehicle.dart';

import '../assets/api_constants.dart';
import 'package:http/http.dart' as http;
import '../globals.dart' as globals;

class VehicleService {
  Future<List<VehicleModel>?> getAllVehicles() async {
    List<VehicleModel>? res;
    await http.get(Uri.parse(ApiUrl + "/" + COL_VEHICLES),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': globals.token
        }).then((value) {
          if(value.statusCode == 200) {
            res = getVehiclesFromJSON(json.decode(value.body));
          }
    });
    return res;
  }
  Future<VehicleModel?> getVehicleById(String id) async {
    VehicleModel? res;
    await http.get(Uri.parse(ApiUrl + '/' + COL_VEHICLES + '/' + id),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': globals.token
        }).then((value) => {
          if(value.statusCode == 200){
            res = VehicleModel.fromJson(json.decode(value.body)),
          }else {
            throw Future.error("Vehicle not found")
          }});
    return res;
  }
  Future<VehicleModel?> putVehicleById(String? id, VehicleModel? vehicle) async {
    VehicleModel? res;
    await http.put(Uri.parse(ApiUrl + '/' + COL_VEHICLES + '/' + id!),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': globals.token
        },
        body: jsonEncode(vehicle?.toJson())).then((value) => {
      if(value.statusCode == 200){
        res = VehicleModel.fromJson(json.decode(value.body))
      }else {
        throw Future.error("Vehicle not found, id is " + id)
      }});
    return res;
  }
  Future<VehicleModel?> postVehicle(VehicleModel? vehicle) async {
    VehicleModel? res;
    await http.post(Uri.parse(ApiUrl + '/' + COL_VEHICLES),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': globals.token
        },
        body: jsonEncode(vehicle?.toJson())).then((value) => {
      if(value.statusCode == 201){
        res = VehicleModel.fromJson(json.decode(value.body))
      }else {
        throw Future.error("Vehicle not posted ;D")
      }});
    return res;
  }
  Future<List<VehicleModel>?> getVehicleByInterventionId(String id) async {
    List<VehicleModel>? res;
    await http.get(Uri.parse(ApiUrl + '/' + COL_INTERVENTIONS + '/' + id + '/' + COL_VEHICLES),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': globals.token
        }).then((value) => {
      if(value.statusCode == 200){
        res = getVehiclesFromJSON(json.decode(value.body))
      }else {
        throw Future.error("Intervention Or Vehicle not found")
      }});
    return res;
  }
  Future<http.Response> deleteVehicleById(String id) async {
    return await http.delete(Uri.parse(ApiUrl + "/" + COL_VEHICLES + "/" + id),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': globals.token
        });
  }

  List<VehicleModel> getVehiclesFromJSON(json){
    List<VehicleModel> vehicles = [];
    for(var d in json){
      vehicles.add(VehicleModel.fromJson(d));
    }
    return vehicles;
  }
}