import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';
import 'package:latlong2/latlong.dart';
import 'package:projet_groupe_c/assets/constants.dart';
import 'package:projet_groupe_c/model/disasterCode.dart';
import 'dart:developer';

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

  late final MapController mapController;
  late final LatLng geoPointIntervention;

  late final int formProportion = 60;

  DisasterCodeModel inc = DisasterCodeModel(
      code: disasterCode["inc"], color: const Color(0xFFFF0000));
  DisasterCodeModel sap = DisasterCodeModel(
      code: disasterCode["sap"], color: const Color(0xFF00FF00));

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  void _handleTap(TapPosition tapPosition, LatLng latlng) {
    this.geoPointIntervention = latlng;
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
        direction: Axis.horizontal,
        children: [
          Flexible(
            flex: formProportion,
            fit: FlexFit.tight,
            child: FormWidget(),
          ),
          Flexible(
            flex: 100 - formProportion,
            child: MapWidget(),
          )
        ]
    );
  }
}

class FormWidget extends StatefulWidget {
  const FormWidget({Key? key}) : super(key: key);

  @override
  FormWidgetState createState() => FormWidgetState();
}

class FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, String> textFieldsValue = {};

  List<DropdownMenuItem<int>> disasterCodeList = []; //Disaster Code List

  List<VehiclesUtils> vehicles = [
    VehiclesUtils(acronym: 'VL', nbOfUnit: 0),
    VehiclesUtils(acronym: 'DA', nbOfUnit: 0),
    VehiclesUtils(acronym: 'FTP', nbOfUnit: 0),
    VehiclesUtils(acronym: 'FMOGP', nbOfUnit: 0),
    VehiclesUtils(acronym: 'EPA', nbOfUnit: 0),
    VehiclesUtils(acronym: 'VLCG', nbOfUnit: 0),
  ];

  void _loadDisasterCode() {
    disasterCodeList = [];
    disasterCodeList.add(const DropdownMenuItem(
      child: Text('SAP'),
      value: 0,
    ));
    disasterCodeList.add(const DropdownMenuItem(
      child: Text('INC'),
      value: 1,
    ));
  }

  //FormField
  int _selectedDisasterCode = 0;

  @override
  Widget build(BuildContext context) {
    _loadDisasterCode();

    return Container(
        color: Colors.white,
        child: Form(
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
                                    decoration: const InputDecoration(
                                      hintText: 'Label de l\'intervention',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return TEXT_REQUIRED;
                                      } else {
                                        textFieldsValue["label"] = value;
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
                                    child: ListView.separated(
                                      itemCount: vehicles.length,
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
                                      decoration: const InputDecoration(
                                        hintText: 'Adresse :    Numéro de rue,    rue,    ville',
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return TEXT_REQUIRED;
                                        } else {
                                          textFieldsValue["adresse"] = value;
                                        }
                                        return null;
                                      })

                              ),
                            ]
                          ),
                          const Padding(
                              padding: const EdgeInsets.all(32)
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
                                      backgroundColor: Colors.deepOrange,
                                      primary: Colors.white,
                                    ),
                                    onPressed: () {},
                                    child: Text('TextButton'),
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
    );
  }
}

class MapWidget extends StatelessWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(48.117266, -1.6777926),
        zoom: 10,
      ),
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
}

class Pane1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {return Container(color: Colors.green[200],child: Center(child: Text('Pane 1'),),);}}

class Pane2 extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return Container(
        margin: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
            child: Stack(children: <Widget>[
              Form(
                  key: _formKey,
                  child: Column()
              )
            ])
        )
    );
  }
}