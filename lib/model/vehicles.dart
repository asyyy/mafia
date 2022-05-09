import 'package:latlong2/latlong.dart';
import 'package:projet_groupe_c/model/iconModel.dart';

class VehicleModel {
  /// Implementation of a vehicle
  VehicleModel(
      {id,
      required this.type,
      required this.validationState,
      required this.departureDate,
      required this.arrivedDateEst,
      arrivedDateReal,
      required this.interventionId,
      required this.iconModel});
  late String id = "";
  int type;
  String validationState;
  String departureDate;
  String arrivedDateEst;
  late String arrivedDateReal = "";
  String interventionId;
  IconModel iconModel;

  /// Get position of Vehicle
  LatLng getPosition() {
    return iconModel.getPosition();
  }

  factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
      id: json["_id"],
      type: json["type"],
      validationState: json['validationState'],
      departureDate: json['departureDate'],
      arrivedDateEst: json['arrivedDateEst'],
      arrivedDateReal: json['arrivedDateReal'],
      interventionId: json['interventionId'],
      iconModel: json['iconModel']);

  /// Export InterventionModel as JSON
  Map<String, dynamic> toJson() => {
        "type": type,
        "validationState": validationState,
        "departureDate": departureDate,
        "arrivedDateEst": arrivedDateEst,
        "arrivedDateReal": arrivedDateReal,
        "interventionId": interventionId
      };

  @override
  String toString() {
    return "Name : " +
        iconModel.label +
        "\nType de vehicule : " +
        type.toString() +
        "\nValidation : " +
        validationState.toString() +
        "\nLongitude : " +
        iconModel.longitude.toString() +
        "\nLatitude : " +
        iconModel.latitude.toString();
  }
}
