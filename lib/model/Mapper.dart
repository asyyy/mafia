import 'dart:convert';

import 'package:flutter/material.dart';

import '../services/mapper_service.dart';

class Mapper {
  Map<String, String> validationsVehicles = {};
  Map<String, String> vehiclesTypes = {};
  Map<String, String> sinisterTypes = {};

  // init() {
  //   print("init");
  //   List<dynamic> list = List.empty();

  //   MapperService.getSinisterType().then((value) => {
  //         for (var object in json.decode(value.body))
  //           {
  //             print(object['_id']),
  //             sinisterTypes.putIfAbsent(object['_id'], () => object['libelle'])
  //           }
  //       });
  //   print("SinisterMap size is " + sinisterTypes.length.toString());
  //   sinisterTypes.forEach((key, value) {
  //     print('key is ' + key);
  //   });
  // }
  fillMapper(dynamic value) {
    for (var object in json.decode(value.body)) {
      sinisterTypes.putIfAbsent(object['libelle'], () => object['_id']);
    }
    sinisterTypes.forEach((key, value) {
      print("Key is " + key + ' | Value is ' + value);
    });
  }

  Mapper() {
    MapperService.getVehiclesType()
        .then((value) => {print("vehiclesTypes"), fillMapper(value)});
    MapperService.getValidationsVehicles()
        .then((value) => {print("ValidationVehicles"), fillMapper(value)});
    MapperService.getSinisterType()
        .then((value) => {print("SinisterType"), fillMapper(value)});
    // MapperService.getValidationsVehicles().then((value) => print(value.body));
    // MapperService.getVehiclesType().then((value) => print(value.body));
  }
}
