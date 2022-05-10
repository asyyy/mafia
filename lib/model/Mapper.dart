import 'dart:convert';

import 'package:flutter/material.dart';

import '../services/mapper_service.dart';

class Mapper {
  Map<String, String> validationsVehicles = {};
  Map<String, String> vehiclesTypes = {};
  Map<String, String> sinisterTypes = {};

  fillMapper(dynamic value, Map<String, String> map) async {
    for (var object in json.decode(value.body)) {
      print("object " + object.toString());
      map.putIfAbsent(object['libelle'], () => object['libelle']);
    }
  }

  String findValidationVehiclesByKey(String id) {
    validationsVehicles.keys.firstWhere(
        (element) => element == id,
        orElse: () => 'Id not found');
    return 'Id not found';
  }

  String findVehicleTypeByKey(String id) {
    vehiclesTypes.keys.firstWhere((element) => element == id,
        orElse: () => 'Id not found');
    return 'Id not found';
  }

  String findSinisterTypeByKey(String id) {
    sinisterTypes.keys.firstWhere((element) => element == id,
        orElse: () => 'Id not found');
    return 'Id not found';
  }

  Mapper() {
    MapperService.getVehiclesType().then(
        (value) => {fillMapper(value, vehiclesTypes)});
    MapperService.getValidationsVehicles().then((value) =>
        {fillMapper(value, validationsVehicles)});
    MapperService.getSinisterType().then(
        (value) => {fillMapper(value, sinisterTypes)});
  }
}
