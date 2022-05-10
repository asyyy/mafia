import 'package:projet_groupe_c/model/intervention.dart';
import 'package:projet_groupe_c/model/vehicles.dart';

import '../model/symbol.dart';

class ApiServiceEmulator {
  InterventionModel intervention = InterventionModel(
      id: "id",
      label: "Feu Capgemini Rennes",
      startDate: "10-04-2022",
      endDate: "10-04-2022",
      longitude: "-1.6777926",
      latitude: "48.117266",
      labelAddress: 'test',
      sinisterType: 'INC');

  Future<InterventionModel> getInterventionById() async {
    return Future.delayed(Duration(milliseconds: 500))
        .then((onValue) => intervention);
  }

  Future<bool> addVehicle(VehicleModel vm) async {
    intervention.vehicles.add(vm);
    return Future.delayed(Duration(milliseconds: 500)).then((onValue) => true);
  }

  Future<bool> addSymbol(SymbolModel vm) async {
    intervention.symbols.add(vm);
    return Future.delayed(Duration(milliseconds: 500)).then((onValue) => true);
  }
}
