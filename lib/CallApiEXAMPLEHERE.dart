import 'package:projet_groupe_c/services/interventions_service.dart';
import 'package:projet_groupe_c/services/polygon.service.dart';
import 'package:projet_groupe_c/services/symbol.service.dart';
import 'package:projet_groupe_c/services/vehicle.service.dart';

import 'model/intervention.dart';
import 'model/polygon.dart';
import 'model/symbol.dart';
import 'model/vehicle.dart';

class CallApiEXAMPLEHERE{

  /* Commmenter / décommenter pour tester ce que vous voulez GET / POST/ PUT / ECT...

    IMPORTANT : =>
    il faut appeler "await(CallApiEXAMPLEHERE().testingSymbolesServices());"
    dans une methode async.
    EXEMPLE :

    void _handleTap(TapPosition tapPosition) async {
      await(CallApiEXAMPLEHERE().testingSymbolesServices());
    }

    Il y a de quoi tester les appel vers vehicles/symbols/polygons
   */
  Future<void> testingPolygonesServices() async {
    PolygonService polygonService = PolygonService();
    List<PolygonModel>? list;
    PolygonModel? poly;
    PolygonModel? poly2;
    // COMMENTER DECOMMENTER POUR TESTER CE QUE VOUS VOULEZ
    // GET ALL
    /*list = await polygonService.getAllPolygons();
    print(list?.length.toString());
    print(list?[0].dots[0]);*/

    // GET BY ID
    /*poly = await polygonService.getPolygonById("627a7cdbdd0ba8d55675ec44");
    print(poly?.toString());*/
    // POST
    /*poly2 = PolygonModel(interventionId: '627a7cdadd0ba8d55675ec31', dots: [LatLng(1.0,2.8),LatLng(5.7777,123.0)]);
    print("hekko");
    print(poly2.toJson());
    await polygonService.postPolygon(poly2).then((value) => print(value.toString()));*/
    //DELETE BY ID
    /*polygonService.deletePolygonById("627aeb8eb5d0c6ecfa0d1908").then((value) => print(value.statusCode));*/
    // PUT BY ID
    /*poly = await polygonService.getPolygonById("627a7cdbdd0ba8d55675ec44");
    print("PUT BEFORE:");
    print(poly.toString());
    poly?.dots.add(LatLng(66.6,66.6));
    poly2 = await polygonService.putPolygonById(poly?.id, poly);
    print("PUT AFTER:");
    print(poly2.toString());*/
    // GET BY INTER ID
    /*list = await polygonService.getPolygonByInterventionId("627a7cdadd0ba8d55675ec31");
    print(list != null? list[0].toString() : "List is empty");*/
  }
  Future<void> testingInterventionsServices() async {
    InterventionService interventionService = InterventionService();
    List<InterventionModel>? list;
    InterventionModel? inter;
    InterventionModel? inter2;
    // COMMENTER DECOMMENTER POUR TESTER CE QUE VOUS VOULEZ
    // GET ALL

    /*list = await interventionService.getAllInterventions();
    print(list?.length.toString());
    print(list?[0].toString());*/

    // GET BY ID
    /*inter = await interventionService.getInterventionById("627a86ffff0ded81849dd59e");
    print(inter?.toString());*/
    // POST
    /*inter2 = InterventionModel(label: "POST FROM FRONT", startDate: DateTime.now().toIso8601String(), longitude: 123.0, latitude: 123.0, labelAddress: '14 rue de chez moi', sinisterTypeId: 1);
    print(inter2.toJson());
    await interventionService.postIntervention(inter2).then((value) => print(value.toString()));*/
    //DELETE BY ID
    /*interventionService.deleteInterventionById("627a7cdadd0ba8d55675ec31").then((value) => print(value.statusCode));*/
    // PUT BY ID
    /*inter = await interventionService.getInterventionById("627b052bb5d0c6ecfa0d199e");
    print("PUT BEFORE:");
    print(inter.toString());
    inter?.labelAddress = "PUT FROM FRONT";
    inter2 = await interventionService.putInterventionById(inter?.id, inter);
    print("PUT AFTER:");
    print(inter2.toString());*/
  }
  
  Future<void> testingVehiclesServices() async {

    VehicleService vehicleService = VehicleService();
    List<VehicleModel>? list;
    VehicleModel? v;
    VehicleModel? v2;
    // GET ALL
    /*list = await vehicleService.getAllVehicles();
    print(list?.length.toString());*/
    // GET BY ID
    /*v = await vehicleService.getVehicleById("627a7cdadd0ba8d55675ec34");
    print(v?.icon);*/
    // POST
    /*IconModel i = IconModel(orientation:  420, size: 69, label: "Un peu fatigué mais is ok", latitude: 12.0, longitude: 77);
    v = VehicleModel(arrivedDateReal: '2022-05-10T14:55:22.913Z', name: 'POST FROM FRONT', arrivedDateEst: '2022-05-10T14:55:22.913Z', departureDate: '2022-05-10T14:55:22.913Z', sinisterTypeId: 1, vehicleTypeId: 1, validationStateId: 1, interventionId: '627a86ffff0ded81849dd59e', icon : i);
    await vehicleService.postVehicle(v).then((value) => print(value.toString()));*/
    // DELETE BY ID
    /*vehicleService.deleteVehicleById("627af15cb5d0c6ecfa0d1931").then((value) => print(value.statusCode));*/
    // PUT BY ID
    /*v = await vehicleService.getVehicleById("627af586b5d0c6ecfa0d195f");
    print(v?.name);
    v?.name = "PUT TESTING FROM FRONT";
    v?.icon?.label = "PUT TESTING FROM FRONT II LE RETOUR DU FILS PERDU";
    v2 = await vehicleService.putVehicleById(v?.id, v);*/
    /*list = await vehicleService.getVehicleByInterventionId("627a86ffff0ded81849dd59e");
    print(list != null? list[0].toString() : "List is empty");*/

  }
  Future<void> testingSymbolesServices() async {
    SymbolService symbolService = SymbolService();
    List<SymbolModel>? list;
    SymbolModel? v;
    SymbolModel? v2;

    // COMMENTER DECOMMENTER POUR TESTER CE QUE VOUS VOULEZ

    // GET ALL
    /*list = await symbolService.getAllSymbols();
    print(list?.length.toString());
    print(list?[0].toString());*/
    // GET BY ID
    /*v = await symbolService.getSymbolById("627a7cdbdd0ba8d55675ec40");
    print(v?.toString());*/
    // POST
    /*IconModel i = IconModel(orientation:  420, size: 69, label: "Un peu fatigué mais is ok", latitude: 12.0, longitude: 77);
    v = SymbolModel(sinisterTypeId: 1, interventionId: "627a7cdadd0ba8d55675ec31", icon: i);
    await symbolService.postSymbol(v).then((value) => print(value.toString()));*/
    // DELETE BY ID
    /*symbolService.deleteSymbolById("627af8a2b5d0c6ecfa0d1976").then((value) => print(value.statusCode));*/
    // PUT BY ID
    /*v = await symbolService.getSymbolById("627a7cdbdd0ba8d55675ec40");
    print(v.toString());
    v?.icon.label = "PUT TESTING SYMBOL FROM FRONT";
    v2 = await symbolService.putSymbolById(v!.id, v);
    print(v2.toString());*/
    //GET BY INTER ID
    /*list = await symbolService.getSymbolByInterventionId("627a7cdadd0ba8d55675ec31");
    print(list != null? list[0].toString() : "List is empty");*/
  }
}