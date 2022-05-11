import 'dart:convert';
import 'package:projet_groupe_c/model/polygon.dart';

import '../assets/api_constants.dart';
import 'package:http/http.dart' as http;
import '../globals.dart' as globals;
import '../model/polygon.dart';

class PolygonService {
  Future<List<PolygonModel>?> getAllPolygons() async {
    List<PolygonModel>? res;
    await http.get(Uri.parse(ApiUrl + "/" + COL_POLYGONS),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': globals.token
        }).then((value) {
      if(value.statusCode == 200) {
        res = getPolygonsFromJSON(json.decode(value.body));
      }
    });
    return res;
  }
  Future<PolygonModel?> getPolygonById(String id) async {
    PolygonModel? res;
    await http.get(Uri.parse(ApiUrl + '/' + COL_POLYGONS + '/' + id),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': globals.token
        }).then((value) => {
      if(value.statusCode == 200){
        res = PolygonModel.fromJson(json.decode(value.body)),
      }else {
        throw Future.error("Polygon not found")
      }});
    return res;
  }
  Future<PolygonModel?> putPolygonById(String? id, PolygonModel? polygon) async {
    PolygonModel? res;
    await http.put(Uri.parse(ApiUrl + '/' + COL_POLYGONS + '/' + id!),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': globals.token
        },
        body: jsonEncode(polygon?.toJson())).then((value) => {
      if(value.statusCode == 200){
        res = PolygonModel.fromJson(json.decode(value.body))
      }else {
        throw Future.error("Polygon not found, id is " + id)
      }});
    return res;
  }
  Future<PolygonModel?> postPolygon(PolygonModel? polygon) async {
    PolygonModel? res;
    await http.post(Uri.parse(ApiUrl + '/' + COL_POLYGONS),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': globals.token
        },
        body: jsonEncode(polygon?.toJson())).then((value) => {
      if(value.statusCode == 201){
        res = PolygonModel.fromJson(json.decode(value.body))
      }else {
        throw Future.error("Polygon not posted ;D")
      }});
    return res;
  }
  Future<List<PolygonModel>?> getPolygonByInterventionId(String id) async {
    List<PolygonModel>? res;
    await http.get(Uri.parse(ApiUrl + '/' + COL_INTERVENTIONS + '/' + id + '/' + COL_POLYGONS),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': globals.token
        }).then((value) => {
      if(value.statusCode == 200){
        res = getPolygonsFromJSON(json.decode(value.body))
      }else {
        throw Future.error("Intervention Or Polygon not found")
      }});
    return res;
  }
  Future<http.Response> deletePolygonById(String id) async {
    return await http.delete(Uri.parse(ApiUrl + "/" + COL_POLYGONS + "/" + id),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': globals.token
        });
  }

  List<PolygonModel> getPolygonsFromJSON(json){
    List<PolygonModel> polygons = [];
    for(var d in json){
      polygons.add(PolygonModel.fromJson(d));
    }
    return polygons;
  }
}