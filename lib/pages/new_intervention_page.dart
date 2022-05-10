import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';
import 'package:latlong2/latlong.dart';
import 'package:projet_groupe_c/assets/constants.dart';
import 'package:projet_groupe_c/model/Mapper.dart';
import 'package:projet_groupe_c/model/disasterCode.dart';
import 'package:projet_groupe_c/model/iconModel.dart';
import 'package:projet_groupe_c/model/intervention.dart';
import 'package:projet_groupe_c/pages/error_page.dart';
import 'package:projet_groupe_c/pages/loading_page.dart';
import 'dart:developer';
import 'package:projet_groupe_c/services/geoloc_services.dart';
import 'package:projet_groupe_c/services/mapper_service.dart';

import '../model/vehicles.dart';
import '../services/api_services.dart' as service;
import '../services/interventions_service.dart';

///
/// Widget that allows create new intervention
///
class VehiclesUtils {
  late String acronym;
  late int nbOfUnit;

  VehiclesUtils({required this.acronym, required this.nbOfUnit}) {
    assert(nbOfUnit == 0);
    assert(nbOfUnit >= 0);
  }
}

class NewInterventionPage extends StatefulWidget {
  const NewInterventionPage({Key? key}) : super(key: key);

  @override
  _NewInterventionPageState createState() => _NewInterventionPageState();
}

class _NewInterventionPageState extends State<NewInterventionPage> {

  late MapController mapController;

  final int formProportion = 60;

  Mapper mapper = Mapper();

  DisasterCodeModel inc = DisasterCodeModel(
      code: "inc", color: const Color(0xFFFF0000));
  DisasterCodeModel sap = DisasterCodeModel(
      code: "sap", color: const Color(0xFF00FF00));

  final _formKey = GlobalKey<FormState>();
  late Marker marker;
  bool isMarked = false;

  List<DropdownMenuItem<int>> disasterCodeList = [];
  List<DisasterCodeModel> disasterModelList = [];//Disaster Code List

  List<VehiclesUtils> vehicles = [];
  Map<String, String> vehicleType = {};

  double latitude = 48.117266;
  double longitude = -1.6777926;

  TextEditingController addressControler = TextEditingController();
  FocusNode textLabelFieldFocusNode = FocusNode();
  FocusNode textAddressFieldFocusNode = FocusNode();
  bool canCleartextFieldError = false;

  //FormField + vehiclesnbOfUnit
  int _selectedDisasterCode = 0;
  String addressFormField = "";
  String labelFormField = "";
  LatLng positionFormField = LatLng(48.117266, -1.6777926);

  @override
  initState(){
    mapController = MapController();
    addListener();
    disasterModelList = [sap, inc];
    super.initState();
  }

  Future<List<VehiclesUtils>> _vehiculeTypeHandler() async {
    await MapperService.getVehiclesType().then(
            (value) => mapper.fillMapper(value, vehicleType));

    vehicleType.forEach((key,value) {
      vehicles.add(VehiclesUtils(acronym: key, nbOfUnit: 0));
    });

    return vehicles;
  }

  addListener() {
    textLabelFieldFocusNode.addListener(() {
      setState(() {
        canCleartextFieldError = textLabelFieldFocusNode.hasFocus;
      });
    });
    textAddressFieldFocusNode.addListener(() {
      setState(() {
        canCleartextFieldError = textAddressFieldFocusNode.hasFocus;
      });
    });
  }

  submitForm() async {

    String latitude = positionFormField.latitude.toString();
    String longitude = positionFormField.longitude.toString();
    String dateNow = DateTime.now().toIso8601String();
    String dateArrivedEstimated = DateTime.now().add(const Duration(hours: 2)).toIso8601String();

    String sinisterTypeKey = DisasterCodeModel.getEnumValue(disasterModelList[_selectedDisasterCode].code.toString());

    InterventionModel newIntervention = InterventionModel(
        label: labelFormField,
        startDate: dateNow,
        longitude: longitude,
        latitude: latitude,
        sinisterType: sinisterTypeKey,
        labelAddress: addressFormField
    );


    var intervention = "";
    await service.ApiService.postIntervention(newIntervention).then((value) => intervention = value);
    Map<String, dynamic> mapIntervention = jsonDecode(intervention);

    newIntervention.id = mapIntervention["_id"];

    IconModel defaultIcon = IconModel(
        orientation: 1.0,
        size: 24.0,
        label: "label",
        latitude: positionFormField.latitude,
        longitude: positionFormField.longitude,
        color: disasterModelList[_selectedDisasterCode].color,
        iconId: 3
    );


    vehicles.forEach((element) async {
      while(element.nbOfUnit >= 1) {

        String vehicleTypeIndex = mapper.findVehicleTypeByKey(element.acronym);
        String validationState = mapper.findValidationVehiclesByKey("VALIDATED");
        String sinisterTypeIndex = mapper.findSinisterTypeByKey(sinisterTypeKey);

        VehicleModel vehicleModel = VehicleModel(
            departureDate: dateNow,
            name: element.acronym + " ",
            validationState: validationState,
            sinisterType: sinisterTypeIndex,
            arrivedDateEst: dateArrivedEstimated,
            interventionId: newIntervention.id,
            iconModel: defaultIcon,
            vehicleType: vehicleTypeIndex,
        );
        var vehicle = "";

        await service.ApiService.postVehicule(vehicleModel).then((value) => vehicle = value); //post Vehicle


        Map<String, dynamic> mapVehicleModel = jsonDecode(vehicle);

        ///TODO A MODIFIER UNE FOIS FIX!!!
        ///LE BAC NE RENVOIE PAS D'IconModel QUAND ON POST UN VEHICULE
        mapVehicleModel["iconModel"] = "nothing";

        newIntervention.vehicles.add(VehicleModel.fromJson(mapVehicleModel));//transform vehicle string to Map<String, Dynamic> and to VehicleModel

        element.nbOfUnit -=1; //if everithing goes well, we've added a vehicle to intervention so we delete one from this list.
      }
    });


    //Navigate to loginPage, waiting for intervention page.
    /*Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoadingPage()),
    );*/
  }

  void _loadDisasterCode() {
    disasterCodeList = [];
    disasterCodeList.add(const DropdownMenuItem(
      child: Text('SAP', style: TextStyle(color: Colors.green)),
      value: 0,
    ));
    disasterCodeList.add(const DropdownMenuItem(
      child: Text('INC', style: TextStyle(color: Colors.red)),
      value: 1,
    ));
  }

  _getPosition() {
    GeoLoc.getLocationFromAddress(addressFormField).then((response)    {
      if( response == null ) {
        addressFormField = "";
        isMarked = false;
      }
      if(response != null) {
        latitude = response.latitude;
        longitude = response.longitude;
      }
      positionFormField = LatLng(latitude, longitude);
         setState(() {
           if(response != null) {
             print(response);
             mapController.move(positionFormField, 15);
             marker = getMarker();
           }
       });
    });
  }

  _getColorMarker() {
    if(addressFormField == "") {
      return const Color.fromARGB(0, 0, 0, 0);
    }
    switch(_selectedDisasterCode) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.red;
      default:
        return const Color.fromARGB(0, 0, 0, 0);
    }
  }

  void _handleTap(TapPosition tapPosition, LatLng latlng) {
    if(!isMarked) {
      return;
    }
    positionFormField = latlng;
      marker = getMarker();
      setState(() {

      });
  }

  getMarker() {
    isMarked = true;
    return Marker(point: positionFormField, builder: (BuildContext context) =>
        Icon(
          Icons.location_on,
          color: _getColorMarker(),
          size: 35.0,
        )
    );

  }

  _isSubmitButtonDisabled() {
    bool vehiclesExist = vehicles.any((element) =>
      element.nbOfUnit > 0 ? true : false
    );
    return !(isMarked && labelFormField.isNotEmpty && vehiclesExist);
  }

  Widget getFormWidget() {
    return  FutureBuilder<List<VehiclesUtils>>(
        future: _vehiculeTypeHandler(),
        builder:
      (BuildContext context, AsyncSnapshot<List<VehiclesUtils>> snapshot) {
        if(snapshot.hasError) {
          log("error : " + snapshot.error.toString());
          return const ErrorPage();
        } else if(snapshot.hasData) {
          return Container(
              color: Colors.white,
              child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: Container(
                      child: Card(
                          color: Colors.white,
                          child: Column(
                              children: <Widget>[
                                const Padding(
                                    padding: const EdgeInsets.all(16)
                                ),
                                Text("Nouvelle Intervention"),
                                const Padding(
                                    padding: const EdgeInsets.all(8)
                                ),
                                Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    const Flexible(
                                        flex: 10,
                                        child: Padding(
                                          padding: EdgeInsets.all(16),
                                        )
                                    ),
                                    Flexible(
                                        flex: 40,
                                        child: TextFormField(
                                            focusNode: textLabelFieldFocusNode,
                                            decoration: const InputDecoration(
                                              hintText: 'Label de l\'intervention',
                                            ),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                labelFormField = "";
                                                return TEXT_REQUIRED;
                                              } else {
                                                labelFormField = value;
                                              }
                                              return null;
                                            })

                                    ),
                                    const Flexible(
                                        flex: 10,
                                        child: Padding(
                                          padding: EdgeInsets.all(16),
                                        )
                                    ),
                                    Flexible(
                                        flex: 40,
                                        child: DropdownButtonFormField(
                                            hint: const Text('Code Sinistre'),
                                            items: disasterCodeList,
                                            value: 0,
                                            onChanged: (value) {
                                              setState(() {
                                                _selectedDisasterCode = value as int;
                                              });
                                            }
                                        )
                                    )
                                  ],
                                ),
                                Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      const Flexible(
                                          flex: 10,
                                          child: Padding(
                                            padding: EdgeInsets.all(16),
                                          )
                                      ),
                                      Flexible(
                                          flex: 100,
                                          child: Container(
                                              width: double.infinity,
                                              height: 250,
                                              child: Scrollbar(
                                                  isAlwaysShown: true,
                                                  child: ListView.separated(
                                                    itemCount: vehicleType.length,
                                                    itemBuilder: (BuildContext context, int index) {
                                                      var vehicle = vehicles[index];
                                                      return Flex(
                                                          direction: Axis.horizontal,
                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                          children: [
                                                            Flexible(
                                                              flex: 60,
                                                              fit: FlexFit.tight,
                                                              child: Text(vehicle.acronym,
                                                                  style: const TextStyle(fontSize: 32)),
                                                            ),
                                                            Flexible(
                                                              flex: 15,
                                                              fit: FlexFit.tight,
                                                              child: IconButton(
                                                                  icon: const Icon(Icons.add, size: 48),
                                                                  tooltip: 'Augmente le nombre de ' + vehicle.acronym,
                                                                  onPressed: () {
                                                                    setState(() {
                                                                      vehicle.nbOfUnit += 1;
                                                                    });
                                                                  }
                                                              ),
                                                            ),
                                                            Flexible(
                                                                flex: 10,
                                                                child: Text(
                                                                    '${vehicle.nbOfUnit}',
                                                                    style: const TextStyle(fontSize: 32)
                                                                )
                                                            ),
                                                            Flexible(
                                                              flex: 15,
                                                              child: IconButton(
                                                                icon: const Icon(Icons.remove, size: 48),
                                                                tooltip: 'Diminue le nombre de ' + vehicle.acronym,
                                                                onPressed: () {
                                                                  setState(() {
                                                                    if(vehicle.nbOfUnit >0) {
                                                                      vehicle.nbOfUnit -= 1;
                                                                    }
                                                                  });
                                                                },
                                                              ),
                                                            )
                                                          ]
                                                      );
                                                    },
                                                    separatorBuilder: (BuildContext context, int index) =>
                                                        Flex(
                                                            direction: Axis.horizontal,
                                                            children: const [
                                                              Flexible(
                                                                flex: 100,
                                                                child: Divider(),
                                                              ),
                                                              Flexible(
                                                                  flex: 10,
                                                                  child: Padding(
                                                                      padding: EdgeInsets.only(top: 32)
                                                                  )
                                                              )]
                                                        ),
                                                  )
                                              )
                                          )
                                      ),
                                      const Flexible(
                                          flex: 10,
                                          child: Padding(
                                            padding: EdgeInsets.all(16),
                                          )
                                      ),
                                    ]
                                ),
                                const Padding(
                                    padding: const EdgeInsets.all(0)
                                ),
                                Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      const Flexible(
                                          flex: 10,
                                          child: Padding(
                                            padding: EdgeInsets.all(16),
                                          )
                                      ),
                                      Flexible(
                                          flex: 40,
                                          child: TextFormField(
                                              focusNode: textAddressFieldFocusNode,
                                              controller: addressControler,
                                              onFieldSubmitted: (term) {
                                                _getPosition();
                                                textAddressFieldFocusNode.unfocus();
                                              },
                                              decoration: const InputDecoration(
                                                hintText: 'Adresse :    Numéro de rue,    rue,    ville',
                                              ),
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  addressFormField = "";
                                                  return TEXT_REQUIRED;
                                                } else {
                                                  addressFormField = value;
                                                }
                                                return null;
                                              })
                                      ),
                                    ]
                                ),
                                const Padding(
                                    padding: EdgeInsets.all(16),
                                ),
                                Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Flexible(
                                        flex: 15,
                                        fit: FlexFit.tight,
                                        child: Container()
                                    ),
                                    Flexible(
                                        flex: 40,
                                        fit: FlexFit.tight,
                                        child: !isMarked ?
                                          Text("Sélectionnez une addresse pour placer un marqueur.") :
                                            Text("Précisez l'emplacement de l'intervention si nécessaire.")
                                    ),
                                    Flexible(
                                        flex: 10,
                                        fit: FlexFit.tight,
                                        child: Container()
                                    )
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8),
                                ),
                                Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Flexible(
                                        flex: 30,
                                        fit: FlexFit.tight,
                                        child: Container()
                                    ),
                                    Flexible(
                                        flex: 40,
                                        fit: FlexFit.tight,
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor: _isSubmitButtonDisabled() ? Colors.grey : Colors.deepOrange,
                                            primary: Colors.white,
                                          ),
                                          onPressed: () {
                                            if (!_isSubmitButtonDisabled()) {
                                              submitForm();
                                            }
                                          },
                                          child: const Text('Créer'),
                                        )
                                    ),
                                    Flexible(
                                        flex: 30,
                                        fit: FlexFit.tight,
                                        child: Container()
                                    )
                                  ],
                                )
                              ]
                          )
                      )
                  )
              )
          ); }
        else {
          return const LoadingPage();
        }
        });
  }

  Widget getMapWidget() {
    return  FlutterMap(
      options: MapOptions(
        onTap: _handleTap,
        onMapCreated: (c) {
          mapController = c;
        },
        controller: mapController,
        center: LatLng(48.117266, -1.6777926),
        zoom: MAP_DEFAULT_ZOOM,
        interactiveFlags: !isMarked ? InteractiveFlag.none : InteractiveFlag.pinchZoom | InteractiveFlag.drag,
      ),
      layers: [
        MarkerLayerOptions(
            markers: isMarked ? [marker] : []
        )
      ],
      children: <Widget>[
        TileLayerWidget(
          options: TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _loadDisasterCode();
    return
      Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                    flex: formProportion,
                    fit: FlexFit.tight,
                    child: GestureDetector(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if( textAddressFieldFocusNode.hasFocus ) {
                          _getPosition();
                        }
                      },
                      child: getFormWidget()
                    ),
                ),
                Flexible(
                    flex: 100 - formProportion,
                    fit: FlexFit.tight,
                    child: getMapWidget()
                )
              ]
      );
  }

}
