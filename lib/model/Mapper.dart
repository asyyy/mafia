import 'dart:convert';

import 'package:flutter/material.dart';

import '../services/mapper_service.dart';

class Mapper {
  Map<String, String> validationsVehicles = {};
  Map<String, String> vehiclesTypes = {};
  Map<String, String> sinisterTypes = {};

  fillMapper(dynamic value, Map<String, String> map) {
    for (var object in json.decode(value.body)) {
      map.putIfAbsent(object['libelle'], () => object['_id']);
    }
    sinisterTypes.forEach((key, value) {
      print("Key is " + key + ' | Value is ' + value);
    });
  }

  Mapper() {
    MapperService.getVehiclesType().then(
        (value) => {print("vehiclesTypes"), fillMapper(value, vehiclesTypes)});
    MapperService.getValidationsVehicles().then((value) =>
        {print("ValidationVehicles"), fillMapper(value, validationsVehicles)});
    MapperService.getSinisterType().then(
        (value) => {print("SinisterType"), fillMapper(value, sinisterTypes)});
  }
}
