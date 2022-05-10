import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:projet_groupe_c/model/intervention.dart';
import 'package:projet_groupe_c/model/user.dart';
import '../assets/api_constants.dart';
import 'package:http/http.dart' as http;
import '../globals.dart' as globals;

class MapperService {
  static Future getSinisterType() {
    return http.get(Uri.parse(ApiUrl + "/sinisterTypes"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': globals.token
        });
  }

  static Future getVehiclesType() {
    return http.get(Uri.parse(ApiUrl + "/vehicleTypes"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': globals.token
        });
  }

  static Future getValidationsVehicles() {
    return http.get(Uri.parse(ApiUrl + "/validationVehicles"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': globals.token
        });
  }
}
