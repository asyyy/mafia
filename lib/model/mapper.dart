import 'dart:convert';

import 'package:projet_groupe_c/assets/enumIcons.dart';

import '../services/mapper_service.dart';

class Mapper {
  Map<String, int> validationsVehicles = {};
  Map<String, int> vehiclesTypes = {};
  Map<String, int> sinisterTypes = {};
  Map<int,iconEnum> iconTypes = {};

  int? findByValue(String s){
    return validationsVehicles[s];
  }
  fillMapperIcons(Map<int,iconEnum> map){
    int i = 0;
    for(var value in iconEnum.values){
      map.putIfAbsent(i, () => value);
      i++;
    }
    iconTypes.forEach((key, value) {
      print("Key is " + key.toString() + "value is " + value.toString());
    });
  }
  fillMapper(dynamic value, Map<String, int> map) {
    for (var object in json.decode(value.body)) {
      map.putIfAbsent(object['libelle'], () => object['_id']);
    }
    sinisterTypes.forEach((key, value) {
      print("Key is " + key + ' | Value is ' + value.toString());
    });
  }

  findIconById(int id){
    print(iconEnum.CRM_FULL.index);
    iconEnum.values[26];
      return iconEnum.values[id];
  }
  findIdofIcon(iconEnum i){
    return i.index;
  }

  String findValidationVehiclesByKey(String id) {
    return validationsVehicles.keys.firstWhere(
        (element) => validationsVehicles[element] == id,
        orElse: () => 'Id not found');
  }

  String findVehicleTypeByKey(String id) {
    return vehiclesTypes.keys.firstWhere((element) => vehiclesTypes[element] == id,
        orElse: () => 'Id not found');
  }

  String findSinisterTypeByKey(String id) {
    return sinisterTypes.keys.firstWhere((element) => sinisterTypes[element] == id,
        orElse: () => 'Id not found');
  }

  Mapper() {
    MapperService.getVehiclesType().then(
        (value) => {print("vehiclesTypes"), fillMapper(value, vehiclesTypes)});
    MapperService.getValidationsVehicles().then((value) =>
        {print("ValidationVehicles"), fillMapper(value, validationsVehicles)});
    MapperService.getSinisterType().then(
        (value) => {print("SinisterType"), fillMapper(value, sinisterTypes)});
    print("IconTypes");fillMapperIcons(iconTypes);

  }
}
