import 'dart:convert';
import '../assets/api_constants.dart';
import 'package:http/http.dart' as http;
import '../globals.dart' as globals;
import '../model/symbol.dart';

class SymbolService {
  Future<List<SymbolModel>?> getAllSymbols() async {
    List<SymbolModel>? res;
    await http.get(Uri.parse(ApiUrl + "/" + COL_SYMBOLS),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': globals.token
        }).then((value) {
      if(value.statusCode == 200) {
        res = getSymbolsFromJSON(json.decode(value.body));
      }
    });
    return res;
  }
  Future<SymbolModel?> getSymbolById(String id) async {
    SymbolModel? res;
    await http.get(Uri.parse(ApiUrl + '/' + COL_SYMBOLS + '/' + id),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': globals.token
        }).then((value) => {
      if(value.statusCode == 200){
        res = SymbolModel.fromJson(json.decode(value.body)),
      }else {
        throw Future.error("Symbol not found")
      }});
    return res;
  }
  Future<SymbolModel?> putSymbolById(String? id, SymbolModel? polygon) async {
    SymbolModel? res;
    await http.put(Uri.parse(ApiUrl + '/' + COL_SYMBOLS + '/' + id!),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': globals.token
        },
        body: jsonEncode(polygon?.toJson())).then((value) => {
      if(value.statusCode == 200){
        res = SymbolModel.fromJson(json.decode(value.body))
      }else {
        throw Future.error("Symbol not found, id is " + id)
      }});
    return res;
  }
  Future<SymbolModel?> postSymbol(SymbolModel? polygon) async {
    SymbolModel? res;
    await http.post(Uri.parse(ApiUrl + '/' + COL_SYMBOLS),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': globals.token
        },
        body: jsonEncode(polygon?.toJson())).then((value) => {
      if(value.statusCode == 201){
        res = SymbolModel.fromJson(json.decode(value.body))
      }else {
        throw Future.error("Symbol not posted ;D")
      }});
    return res;
  }
  Future<List<SymbolModel>?> getSymbolByInterventionId(String id) async {
    List<SymbolModel>? res;
    await http.get(Uri.parse(ApiUrl + '/' + COL_INTERVENTIONS + '/' + id + '/' + COL_SYMBOLS),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': globals.token
        }).then((value) => {
      if(value.statusCode == 200){
        res = getSymbolsFromJSON(json.decode(value.body))
      }else {
        throw Future.error("Intervention Or Symbol not found")
      }});
    return res;
  }
  Future<http.Response> deleteSymbolById(String id) async {
    return await http.delete(Uri.parse(ApiUrl + "/" + COL_SYMBOLS + "/" + id),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': globals.token
        });
  }

  List<SymbolModel> getSymbolsFromJSON(json){
    List<SymbolModel> symbols = [];
    for(var d in json){
      symbols.add(SymbolModel.fromJson(d));
    }
    return symbols;
  }
}