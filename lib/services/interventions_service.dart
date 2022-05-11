import 'dart:convert';
import 'package:projet_groupe_c/model/intervention.dart';

import '../assets/api_constants.dart';
import 'package:http/http.dart' as http;
import '../globals.dart' as globals;
import '../model/intervention.dart';

class InterventionService {
  Future<List<InterventionModel>?> getAllInterventions() async {
    List<InterventionModel>? res;
    await http.get(Uri.parse(ApiUrl + "/" + COL_INTERVENTIONS),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': globals.token
        }).then((value) {
      if(value.statusCode == 200) {
        res = getInterventionsFromJSON(json.decode(value.body));
      }
    });
    return res;
  }
  Future<InterventionModel?> getInterventionById(String id) async {
    InterventionModel? res;
    await http.get(Uri.parse(ApiUrl + '/' + COL_INTERVENTIONS + '/' + id),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': globals.token
        }).then((value) => {
      if(value.statusCode == 200){
        res = InterventionModel.fromJson(json.decode(value.body)),
      }else {
        throw Future.error("Intervention not found")
      }});
    return res;
  }
  Future<InterventionModel?> putInterventionById(String? id, InterventionModel? intervention) async {
    InterventionModel? res;
    await http.put(Uri.parse(ApiUrl + '/' + COL_INTERVENTIONS + '/' + id!),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': globals.token
        },
        body: jsonEncode(intervention?.toJson())).then((value) => {
      if(value.statusCode == 200){
        res = InterventionModel.fromJson(json.decode(value.body))
      }else {
        throw Future.error("Intervention not found, id is " + id)
      }});
    return res;
  }
  Future<InterventionModel?> postIntervention(InterventionModel? intervention) async {
    InterventionModel? res;
    await http.post(Uri.parse(ApiUrl + '/' + COL_INTERVENTIONS),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': globals.token
        },
        body: jsonEncode(intervention?.toJson())).then((value) => {
      if(value.statusCode == 201){
        res = InterventionModel.fromJson(json.decode(value.body))
      }else {
        throw Future.error("Intervention not posted ;D")
      }});
    return res;
  }

  Future<http.Response> deleteInterventionById(String id) async {
    return await http.delete(Uri.parse(ApiUrl + "/" + COL_INTERVENTIONS + "/" + id),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': globals.token
        });
  }

  List<InterventionModel> getInterventionsFromJSON(json){
    List<InterventionModel> interventions = [];
    for(var d in json){
      interventions.add(InterventionModel.fromJson(d));
    }
    return interventions;
  }
}