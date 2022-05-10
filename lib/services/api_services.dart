import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:projet_groupe_c/model/intervention.dart';
import 'package:projet_groupe_c/model/user.dart';
import 'package:projet_groupe_c/model/vehicles.dart';
import '../assets/api_constants.dart';
import 'package:http/http.dart' as http;
import '../globals.dart' as globals;

/// Service for API
/// Based on Back End Project
class ApiService {
  static Future getData() async {
    return http.get(Uri.parse(ApiUrl + "/" + ApiCollection),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': globals.token
        });
  }

  static Future getInterventionById(String id) {
    return http.get(
      Uri.parse(ApiUrl + "/" + ApiCollection + "/" + id),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': globals.token
      },
    );
  }

  static Future<String> postIntervention(InterventionModel intervention) async {
    String tmpResult = "";
    await http
        .post(
      Uri.parse(ApiUrl + "/" + ApiCollection),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': globals.token
      },
      body: jsonEncode(intervention.toJson()),
    )
        .then((value) {
      if (value.statusCode >= 200 && value.statusCode <300) {
        tmpResult = value.body;
      } else {
        tmpResult = "";
      }
    }).catchError((docSnapshot) {
      tmpResult = "Erreur lors de la création de l'intervention";
    });
    return tmpResult;
  }

  static Future<bool> updateIntervention(InterventionModel intervention) async {
    bool tmpResult = false;
    await http
        .put(
      Uri.parse(ApiUrl + "/" + ApiCollection + "/" + intervention.id),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': globals.token
      },
      body: jsonEncode(intervention.toJson()),
    )
        .then((value) {
      tmpResult = true;
    }).catchError((docSnapshot) {
      tmpResult = false;
    });
    return tmpResult;
  }

  static Future<bool> deleteIntervention(InterventionModel intervention) async {
    bool tmpResult = false;

    await http.delete(
        Uri.parse(ApiUrl + "/" + ApiCollection + "/" + intervention.id),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': globals.token
        }).then((value) {
      tmpResult = true;
    }).catchError((docSnapshot) {
      tmpResult = false;
    });
    return tmpResult;
  }

// Fonction de login, a brancher au front
// Return '' si la connexion est bonne, et update le token global
// Return le message d'erreur si le login est incorrect
  static Future<String> login(String username, String password) async {
    String tmpResult = '';

    await http
        .post(
      Uri.parse(ApiUrl + "/" + Log + "/in"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': globals.token
      },
      body: jsonEncode({'login': username, 'password': password}),
    )
        .then((value) {
      if (value.statusCode == 200) {
        globals.token = value.body;
        tmpResult = '';
      } else {
        tmpResult = value.body;
      }
    }).catchError((docSnapshot) {
      tmpResult = 'Erreur de connexion';
    });
    return tmpResult;
  }

//Fonction de logout a brancher au front
//Return '' sur un succes, et reset le token global
// Return le message d'erreur sur un echec
  static Future<String> logout() async {
    String tmpResult = '';

    await http
        .post(
      Uri.parse(ApiUrl + "/" + Log + "/out"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': globals.token
      },
      body: jsonEncode({}),
    )
        .then((value) {
      if (value.statusCode == 200) {
        globals.token = '';
        tmpResult = '';
      } else {
        tmpResult = value.body;
      }
    }).catchError((docSnapshot) {
      tmpResult = 'Erreur de connexion';
    });
    return tmpResult;
  }

//Fonction de creation user a brancher au front
//Return true sur un succes
// Return false sur un echec
  static Future<String> createUser(UserModel user) async {
    String tmpResult = '';

    await http
        .post(
      Uri.parse(ApiUrl + "/" + User),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': globals.token
      },
      body: jsonEncode(user.toJson()),
    )
        .then((value) {
      if (value.statusCode == 200) {
        tmpResult = '';
      } else {
        tmpResult = value.body;
      }
    }).catchError((docSnapshot) {
      tmpResult = 'Erreur de connexion';
    });
    return tmpResult;
  }

  static Future<String> postVehicule(VehicleModel vehicule) async {
    String tmpResult = "";
    await http
        .post(
      Uri.parse(ApiUrl + "/" + Vehicules),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': globals.token
      },
      body: jsonEncode(vehicule.toJson()),
    )
        .then((value) {
      print("vehicle " + value.statusCode.toString() + " " + value.body);
      if (value.statusCode >= 200 && value.statusCode <300) {
        tmpResult = value.body;
      } else {
        tmpResult = "";
      }
    }).catchError((docSnapshot) {
      tmpResult = "Erreur lors de la création de l'intervention";
    });
    return tmpResult;
  }
}
