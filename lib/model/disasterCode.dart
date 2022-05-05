import 'package:flutter/material.dart';

Map<String, dynamic> disasterCode = {
  "inc": "INC",
  "sap": "SAP",
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

}