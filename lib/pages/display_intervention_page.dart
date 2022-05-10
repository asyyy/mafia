import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';
import 'package:projet_groupe_c/model/iconModel.dart';
import 'package:projet_groupe_c/model/vehicles.dart';
import 'package:projet_groupe_c/pages/error_page.dart';
import 'package:projet_groupe_c/pages/loading_page.dart';
import 'dart:math';
import '../model/intervention.dart';
import '../model/symbol.dart';
import '../services/api_services_emulator.dart';

///
/// Widget that allows display intervention
///
class DisplayIntervention extends StatefulWidget {
  const DisplayIntervention({Key? key}) : super(key: key);

  @override
  _DisplayInterventionState createState() => _DisplayInterventionState();
}

class _DisplayInterventionState extends State<DisplayIntervention> {
  ApiServiceEmulator apiEmulator = ApiServiceEmulator();

  // Initialize map controller
  late final MapController mapController;

  late InterventionModel intervention;

  // Size of the left panel
  final int leftPaneProportion = 30;

  // Duration of the intervention in seconds
  int interventionDuration = 7200;

  // Map settings
  List<Polyline> map_polylines = [];

  // Temp map markers and lines (not send to bdd)
  List<Polyline> map_displayed_polylines = [];

  // ---- START LEFT PANEL SETTINGS SECTION ----- //
  final _settingsFormKey = GlobalKey<FormState>();
  // ---- END LEFT PANEL SETTINGS SECTION ----- //

  // ---- START DRAWER SECTION ----- //
  final _drawerFormKey = GlobalKey<FormState>();

  // Form attributes
  String _drawerLabelController = "";
  String _drawerTypeController = "Ligne";
  Color _drawerColorController = Colors.red;

  List<Map> availableColors = [
    {'name': 'Rouge', 'value': Colors.red},
    {'name': 'Vert', 'value': Colors.green},
    {'name': 'Bleu', 'value': Colors.blue},
    {'name': 'Noir', 'value': Colors.black},
  ];

  // Map capture (start capture many points)
  bool mapCapture = false;

  // History of taps
  List<LatLng> tapHistory = [];

  // ---- END DRAWER SECTION ----- //

  // ---- START NEW MARKER SECTION ----- //
  final _markerFormKey = GlobalKey<FormState>();

  String _markerLabelController = "";
  int _markerTypeController = 0;
  double _markerRotationController = 0.0;
  double _markerSizeController = 30.0;
  int _markerSinisterTypeController = 0;

  List<Map> availableVehicles = [
    {'name': 'Petit Camion', 'value': 0},
    {'name': 'Camion', 'value': 1},
  ];

  List<Map> availableSymbols = [
    {'name': 'Cercle de fleche', 'value': 0},
    {'name': 'Fleche courbée', 'value': 1},
  ];

  List<Map> availableSinisterType = [
    {'name': 'Feu', 'value': 0},
    {'name': 'Accident', 'value': 1},
    {'name': 'Gaz', 'value': 2},
  ];

  // ---- END NEW MARKER SECTION ----- //

  // ---- END SETTINGS SECTION ----- //
  bool hideSettings = true;
  late Object lastTappedElement;
  bool userEdit = false;

  // ---- END SETTINGS SECTION ----- //

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  void _handleTap(TapPosition tapPosition, LatLng latlng) {
    if (userEdit) {
      return;
    }
    print("Tap " + latlng.toString());
    tapHistory.add(latlng);
    if (mapCapture) {
      setState(() {
        map_displayed_polylines = List.from(map_polylines);
        map_displayed_polylines.add(Polyline(
          points: tapHistory,
          strokeWidth: 4.0,
          isDotted: _drawerTypeController == "Ligne" ? false : true,
          color: _drawerColorController,
        ));
      });
    } else {
      print("Add new marker");
      openNewMarkerPopup();
    }
  }

  markerListener(Object v) {
    lastTappedElement = v;
    setState(() {
      hideSettings = false;
    });

    if (v is VehicleModel) {
      print('Vehicle');
    } else if (v is SymbolModel) {
      print('Symbol');
    }
  }

  refreshData() {
    apiEmulator.getInterventionById().then((value) => {
          setState(() {
            intervention = value;
          })
        });
  }

  void startCapture() {
    print("Start capture");
    setState(() {
      mapCapture = true;
      tapHistory = [];
    });
  }

  void stopCapture() {
    print("Stop capture");
    setState(() {
      mapCapture = false;

      // Faire requete

      setState(() {
        // map_polylines = MA REQUETE
        map_polylines = List.from(map_displayed_polylines);
      });
    });
  }

  void cancelCapture() {
    print("Cancel capture");
    setState(() {
      // map_polylines = MA REQUETE
      mapCapture = false;
      map_displayed_polylines = List.from(map_polylines);
    });
  }

  void computeVehicleMarker() {
    print("Add new vehicle marker");
    Map marker_values = {};
    marker_values["label"] = _markerLabelController;
    marker_values["type"] = _markerTypeController;
    marker_values["sinisterType"] = _markerSinisterTypeController;
    IconModel im = IconModel(
        orientation: 0,
        size: 30,
        label: marker_values['label'],
        latitude: tapHistory.last.latitude,
        longitude: tapHistory.last.longitude,
        color: Colors.red,
        iconId: 0);
    VehicleModel vm = VehicleModel(
        id: Random().nextInt(9999999).toString(),
        type: marker_values["type"],
        validationState: "6276c236c6a97a0c672aa10a",
        departureDate: "2022-02-24",
        arrivedDateEst: "2022-02-24",
        arrivedDateReal: "2022-02-24",
        interventionId: intervention.id,
        iconModel: im);

    // Simulate push on API
    apiEmulator.addVehicle(vm).then((value) => {
          setState(() {
            // Refresh data from API
            refreshData();
          })
        });
  }

  void computeSymbolMarker() {
    print("Add new symbol marker");
    Map marker_values = {};
    marker_values["label"] = _markerLabelController;
    marker_values["type"] = _markerTypeController;
    marker_values["sinisterType"] = _markerSinisterTypeController;
    marker_values["size"] = _markerSizeController;
    marker_values["rotation"] = _markerRotationController;
    IconModel im = IconModel(
        orientation: 0,
        size: 30,
        label: marker_values['label'],
        latitude: tapHistory.last.latitude,
        longitude: tapHistory.last.longitude,
        color: Color(0),
        iconId: 0);
    SymbolModel vm = SymbolModel(
        id: Random().nextInt(9999999).toString(),
        type: marker_values["type"],
        interventionId: intervention.id,
        icon: im);

    // Simulate push on API
    apiEmulator.addSymbol(vm).then((value) => {
          setState(() {
            // Refresh data from API
            refreshData();
          })
        });
  }

  openDrawPopup() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text('Dessiner un vecteur'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _drawerFormKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _drawerLabelController,
                      onChanged: (value) {
                        _drawerLabelController = value;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Label',
                        icon: Icon(Icons.abc_rounded),
                      ),
                    ),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.border_color),
                      ),
                      value: _drawerTypeController,
                      items: ["Ligne", "Pointillé"]
                          .map((label) => DropdownMenuItem(
                                child: Text(label),
                                value: label,
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          _drawerTypeController = value;
                        }
                      },
                    ),
                    DropdownButtonFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.brush_rounded),
                      ),
                      value: _drawerColorController,
                      items: availableColors.map((map) {
                        return DropdownMenuItem(
                          child: Text(map['name']),
                          value: map['value'],
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          _drawerColorController = value as Color;
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                  child: Text("Retour"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    // your code
                  }),
              ElevatedButton(
                  child: Text("Dessiner"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    startCapture();
                  })
            ],
          );
        });
  }

  openNewMarkerPopup() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              scrollable: true,
              title: Text('Ajouter'),
              content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.directions_bus_filled),
                              tooltip: 'Ajouter un vehicule',
                              onPressed: () {
                                print("Add vehicle");
                                Navigator.of(context).pop();
                                openNewVehiclePopup();
                              },
                            ),
                            Text('Vehicule')
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.edit_location),
                              tooltip: 'Ajouter un symbole',
                              onPressed: () {
                                print("Add symbol");
                                Navigator.of(context).pop();
                                openNewSymbolPopup();
                              },
                            ),
                            Text('Symbole')
                          ],
                        )
                      ])),
              actions: [
                ElevatedButton(
                    child: Text("Retour"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ]);
        });
  }

  openNewVehiclePopup() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text('Ajouter un vehicule'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _markerFormKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _markerLabelController,
                      onChanged: (value) {
                        _markerLabelController = value;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Label',
                        icon: Icon(Icons.abc_rounded),
                      ),
                    ),
                    DropdownButtonFormField(
                      decoration: const InputDecoration(
                        labelText: 'Vehicle Type',
                        icon: Icon(Icons.border_color),
                      ),
                      value: _markerTypeController,
                      items: availableVehicles.map((map) {
                        return DropdownMenuItem(
                          child: Text(map['name']),
                          value: map['value'],
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          if (value != null) {
                            _markerTypeController = value as int;
                          }
                        });
                      },
                    ),
                    DropdownButtonFormField(
                      decoration: const InputDecoration(
                        labelText: 'Sinister Type',
                        icon: Icon(Icons.brush_rounded),
                      ),
                      value: _markerSinisterTypeController,
                      items: availableSinisterType.map((map) {
                        return DropdownMenuItem(
                          child: Text(map['name']),
                          value: map['value'],
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          if (value != null) {
                            _markerSinisterTypeController = value as int;
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                  child: Text("Retour"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              ElevatedButton(
                  child: Text("Valider"),
                  onPressed: () {
                    computeVehicleMarker();
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  openNewSymbolPopup() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text('Ajouter un symbole'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _markerFormKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _markerLabelController,
                      onChanged: (value) {
                        _markerLabelController = value;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Label',
                        icon: Icon(Icons.abc_rounded),
                      ),
                    ),
                    DropdownButtonFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.border_color),
                        labelText: 'Symbol Type',
                      ),
                      value: _markerTypeController,
                      items: availableSymbols.map((map) {
                        return DropdownMenuItem(
                          child: Text(map['name']),
                          value: map['value'],
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          if (value != null) {
                            _markerTypeController = value as int;
                          }
                        });
                      },
                    ),
                    DropdownButtonFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.brush_rounded),
                        labelText: 'Sinister Type',
                      ),
                      value: _markerSinisterTypeController,
                      items: availableSinisterType.map((map) {
                        return DropdownMenuItem(
                          child: Text(map['name']),
                          value: map['value'],
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          if (value != null) {
                            _markerSinisterTypeController = value as int;
                          }
                        });
                      },
                    ),
                    TextFormField(
                      initialValue: _markerSizeController.toString(),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        try {
                          _markerSizeController = double.parse(value);
                        } catch (_) {
                          print("Conversion error"); //String is not an Integer
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Taille',
                        icon: Icon(Icons.expand_more),
                      ),
                    ),
                    TextFormField(
                      initialValue: _markerRotationController.toString(),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        _markerRotationController = double.parse(value);
                      },
                      decoration: const InputDecoration(
                        labelText: 'Angle',
                        icon: Icon(Icons.zoom_in_rounded),
                      ),
                    )
                  ],
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                  child: Text("Retour"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              ElevatedButton(
                  child: Text("Valider"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    computeSymbolMarker();
                  }),
            ],
          );
        });
  }

  getCurrentForm() {
    if (hideSettings) {
      return const Padding(
        padding: EdgeInsets.all(15), //apply padding to all four sides
        child: Text(
          "Selectionner un marqueur",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );
    } else {
      return Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AppBar(
              toolbarHeight: 40,
              elevation: 0,
              title: Text((lastTappedElement is VehicleModel)
                  ? (lastTappedElement as VehicleModel).iconModel.label
                  : (lastTappedElement is SymbolModel)
                      ? (lastTappedElement as SymbolModel).icon.label
                      : "No label"),
              backgroundColor: Colors.black,
              centerTitle: false,
              actions: <Widget>[
                /// Save edition
                userEdit
                    ? IconButton(
                        icon: Icon(Icons.download_done),
                        onPressed: () => {print("delete")},
                      )
                    : SizedBox.shrink(),

                /// Cancel edition
                userEdit
                    ? IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => {
                          print("delete"),
                          setState(() {
                            userEdit = false;
                          })
                        },
                      )
                    : SizedBox.shrink(),

                /// Delete element
                userEdit
                    ? SizedBox.shrink()
                    : IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => {
                          print("Delete element"),
                        },
                      ),

                /// Hide settings
                userEdit
                    ? SizedBox.shrink()
                    : IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () => {
                          print("Hide settings"),
                          setState(() {
                            hideSettings = true;
                          })
                        },
                      )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 16),
              child: TextFormField(
                onChanged: (String s) => {
                  print(""),
                  setState(() {
                    userEdit = true;
                  })
                },
                initialValue: (lastTappedElement is VehicleModel)
                    ? (lastTappedElement as VehicleModel).iconModel.label
                    : (lastTappedElement is SymbolModel)
                        ? (lastTappedElement as SymbolModel).icon.label
                        : "",
                validator: (val) => 'Full name is invalid',
                decoration: InputDecoration(
                  labelText: 'Label',
                  hintText: 'Label',
                  icon: Icon(Icons.abc),
                  isDense: true,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
              child: TextFormField(
                initialValue: "email",
                validator: (val) => 'Email is invalid',
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  hintText: 'Enter your email',
                  icon: Icon(Icons.email),
                  isDense: true,
                ),
              ),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<InterventionModel>(
        future: apiEmulator.getInterventionById(),
        builder:
            (BuildContext context, AsyncSnapshot<InterventionModel> snapshot) {
          if (snapshot.hasData) {
            intervention = snapshot.data ??
                InterventionModel(
                    id: "",
                    label: "",
                    startDate: "",
                    endDate: "", labelAddress: '', sinisterType: 1, latitude: '', longitude: '',);
            return Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                  flex: leftPaneProportion,
                  child: Container(
                      color: Colors.white,
                      child: Scaffold(
                          resizeToAvoidBottomInset: true,
                          body: ListView(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            children: <Widget>[
                              GestureDetector(
                                  onTap: () {
                                    print("Click : Header");
                                  },
                                  child: Card(
                                    elevation: 0,
                                    color: Colors.transparent,
                                    child: ListTile(
                                        title: Text(intervention.label),
                                        subtitle: const Text(
                                            "7 Rue Claude Chappe, 35510 Cesson-Sévigné"),
                                        trailing: TweenAnimationBuilder<
                                                Duration>(
                                            duration: Duration(
                                                seconds: 86400 -
                                                    interventionDuration),
                                            tween: Tween(
                                                begin: Duration(
                                                    seconds:
                                                        interventionDuration),
                                                end: const Duration(
                                                    seconds: 86400)),
                                            builder: (BuildContext context,
                                                Duration value, Widget? child) {
                                              final hours = value.inHours;
                                              final minutes =
                                                  value.inMinutes % 60;
                                              return Text(
                                                  (hours < 10
                                                          ? "0" +
                                                              hours.toString()
                                                          : hours.toString()) +
                                                      ':' +
                                                      (minutes < 10
                                                          ? "0" +
                                                              minutes.toString()
                                                          : minutes.toString()),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold));
                                            })),
                                  )),
                              const Divider(color: Colors.black),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  IconButton(
                                    icon:
                                        const Icon(Icons.table_chart_outlined),
                                    tooltip: 'Tableau des moyens',
                                    onPressed: () {
                                      print("Click : Tableau des moyens");
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.airplanemode_on),
                                    tooltip: 'Vue drone',
                                    onPressed: () {
                                      print("Click : Tableau des moyens");
                                    },
                                  ),
                                  IconButton(
                                    icon:
                                        const Icon(Icons.format_list_bulleted),
                                    tooltip: 'Liste des interventions',
                                    onPressed: () {
                                      print("Click : Liste des interventions");
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(mapCapture == true
                                        ? Icons.download_done
                                        : Icons.border_color_outlined),
                                    color: mapCapture == true
                                        ? Colors.green
                                        : Colors.black,
                                    tooltip: 'Dessiner',
                                    onPressed: () {
                                      print("Click : Dessiner");
                                      if (mapCapture) {
                                        stopCapture();
                                      } else {
                                        openDrawPopup();
                                      }
                                    },
                                  ),
                                  Visibility(
                                    child: IconButton(
                                      icon: Icon(Icons.delete_outlined),
                                      color: Colors.red,
                                      tooltip: 'Supprimer',
                                      onPressed: () {
                                        print("Click : Remove");
                                        if (mapCapture) {
                                          cancelCapture();
                                        }
                                      },
                                    ),
                                    visible: mapCapture,
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height: 1,
                                  child: DecoratedBox(
                                      decoration:
                                          BoxDecoration(color: Colors.black))),
                              getCurrentForm()
                            ],
                          ))),
                ),
                Flexible(
                  flex: 100 - leftPaneProportion,
                  child: FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                        plugins: [],
                        center: intervention.getposition(),
                        zoom: 15,
                        maxZoom: 18,
                        onTap: _handleTap),
                    layers: [
                      MarkerLayerOptions(
                          markers: intervention.getAllMarkers(listener: markerListener)),
                      PolylineLayerOptions(
                        polylines: map_displayed_polylines,
                      ),
                    ],
                    children: <Widget>[
                      TileLayerWidget(
                        options: TileLayerOptions(
                          urlTemplate:
                              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                          subdomains: ['a', 'b', 'c'],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return ErrorPage();
          } else {
            return LoadingPage();
          }
        });
  }
}
