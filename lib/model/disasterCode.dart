import 'package:flutter/material.dart';

Map<String, dynamic> disasterCode = {
  "sap": 0,
  "inc": 1,
};

class DisasterCodeModel {
  DisasterCodeModel({required this.code, required this.color});
  String code;
  Color color;

  /// Create InterventionModel from JSON
  factory DisasterCodeModel.fromJson(Map<String, dynamic> json) => DisasterCodeModel(
      code: json["code"],
      color: json["color"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "color": color,
  };

  static int getEnumValue(String code){
    return disasterCode[code];
  }

}