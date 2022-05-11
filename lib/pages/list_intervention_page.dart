//import 'dart:html';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:projet_groupe_c/assets/constants.dart';
import 'package:projet_groupe_c/pages/loading_page.dart';
import 'package:projet_groupe_c/pages/login_page.dart';
import 'package:projet_groupe_c/pages/new_intervention_page.dart';
import '../model/mapper.dart';
import '../services/geoloc_services.dart';
import '../services/interventions_service.dart';
import '../model/intervention.dart';

///
/// Widget that allows display intervention
///
class ListIntervention extends StatefulWidget {
  const ListIntervention({Key? key}) : super(key: key);
  @override
  _ListInterventionState createState() => _ListInterventionState();
}


class _ListInterventionState extends State<ListIntervention> {
  LatLng _currentPosition = LatLng(48.111335, -1.679606) ;
  late AppBar appBar;
  late final MapController mapController ;
  List<InterventionModel> interventions = [];
  late int _selected = -1;
  List<Marker> mapMarkers = [];
  Mapper mapper = Mapper();
  InterventionService interventionService = InterventionService();

   _getPosition() {
     GeoLoc.getCurrentPosition().then((response) {
       print("Response " + response.toString());
       setState(() {
         if(response != null)
         {
           _currentPosition.latitude = response.latitude;
           _currentPosition.longitude = response.longitude;
           mapMarkers.add(
               Marker(
                 width: 75.0,
                 height: 75.0,
                 point: LatLng(_currentPosition.latitude,_currentPosition.longitude),
                 builder: (ctx) => const Icon(
                   Icons.location_on,
                   color: Colors.blue,
                   size: 35.0,
                 ),
               ));
         }
       });

     });


   }

  _getInterventions(){
    setState(() async {
      interventions = (await interventionService.getAllInterventions())!;
    });
  }


  @override
  void initState()  {
    _getPosition();
    super.initState();
     _getInterventions();
    appBar = AppBar(
      title: const Text("Interventions"),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.grey),
        onPressed: () => {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const LoginPage()))
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0,),
          child: IconButton(
            icon: const Icon(
              Icons.add_circle_outlined,
              color: Colors.white,
              size: 45,
            ),
            onPressed: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const NewInterventionPage()))
            },
          ),
        ),
      ],
    );
    mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
    appBar :appBar,
   body:Row(
   children: [
     leftColumnBuild(context),
   Column(
       children: [

   Row(
    children: [
      Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height*0.85-appBar.preferredSize.height,
          child:
              FlutterMap(
                        mapController: mapController,
                        options: MapOptions
                        (
                          interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                          center: _currentPosition,
                          zoom: 10,
                          rotation: 0.0,
               ),
               layers: [
                 MarkerLayerOptions(markers: mapMarkers)
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
             )
      ),
    ],
    ),
   Row(
    children: [
      Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height*0.1,
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom : 0.0, right: 30.0, left: 30.0),
          child: ElevatedButton(
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                       LoadingPage(id : interventions[_selected].id!)
                )
                  )
              // il faut passer en param l'id de l'intervention selectionnée
            },
            child: const Text(
              "Rejoindre l'intervention",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    ],
    )
    ])
    ],)
   );

  }

   Widget leftColumnBuild(BuildContext context){
     return SingleChildScrollView(
         scrollDirection: Axis.vertical,
         child:
         Column(
           children: [
             Container(
               width: MediaQuery.of(context).size.width * 0.5,
               height: MediaQuery.of(context).size.height -
                   appBar.preferredSize.height,
               child: ListView.builder(
                 shrinkWrap: true,
                 itemCount: interventions.length,
                 itemBuilder: (context, position) {
                   return Card(
                     child: Padding(
                         padding: const EdgeInsets.all(20.0),
                         child: ListTile(
                           selected: position == _selected,
                           leading: const Icon(Icons.local_fire_department),
                           title: Row(
                             children: [
                               Padding(
                                 padding: const EdgeInsets.all(0.0),
                                 child: Column(
                                   children: [
                                     Text(interventions[position].label),
                                   ],
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.all(12.0),
                                 child: Column(
                                   children: [
                                     Text(mapper.sinisterTypes.keys.firstWhere((element) => mapper.sinisterTypes[element] == interventions[position].sinisterTypeId, orElse: () => "No id found")),
                                   ],
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.all(12.0),
                                 child: Column(
                                   children:[
                                     (interventions[position].endDate != null) ? const Text("En cours") : const Text("Terminé"),
                                   ]
                                 ),
                               ),
                             ],
                           ),
                           subtitle: Row(
                               children: [
                                 Text(interventions[position].startDate),
                                 const Spacer(),
                                 (interventions[position].labelAddress != null) ? Text(interventions[position].labelAddress.toString()) : const Text(""),
                               ]
                           ),
                           onTap: (){
                             setState(() {
                               _selected = position;
                               print(mapMarkers.length);
                               if(mapMarkers.length > 1){mapMarkers.removeAt(1);}
                               mapMarkers.add(
                                 Marker(
                                   width: 150.0,
                                   height: 150.0,
                                   point: interventions[_selected].getposition(),
                                   builder: (ctx) => const Icon(
                                     Icons.location_on,
                                     color: Colors.red,
                                     size: 35.0,
                                   ),
                                 ),);
                               mapController.move(interventions[_selected].getposition(), MAP_INTERVENTION_ZOOM);
                             });
                           },
                         )
                     ),
                   );
                 },
               ),
             ),
           ],
         )
     );
   }
}
