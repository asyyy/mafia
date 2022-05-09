import '../model/intervention.dart';

/// Get list of InterventionModel from JSON
List<InterventionModel> getInterventionsFromJSON(json){
  List<InterventionModel> interventions = [];
  for(var d in json){
    interventions.add(InterventionModel.fromJson(d));
  }
  return interventions;
}
<<<<<<< HEAD
=======

/// Get vehicles Markers from list of InterventionModel
/*List<Marker> getMarkersFromInterventions(List<InterventionModel> interventions) {
  List<Marker> markers = [];
  for(InterventionModel intervention in interventions){
    markers.addAll(intervention.getVehiclesMarkers());
  }
  return markers;
}*/
>>>>>>> 6b7dfe4 (last push, will redirect to loading page waiting)
