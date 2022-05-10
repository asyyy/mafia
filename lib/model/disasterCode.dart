import 'package:flutter/material.dart';

Map<String, dynamic> disasterCode = {
  "sap": "SAP",
  "inc": "INC",
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

  static String getEnumValue(String code){
    return disasterCode[code];
  }

}