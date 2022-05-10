import 'package:latlong2/latlong.dart';
import 'package:projet_groupe_c/model/iconModel.dart';

class VehicleModel {

  /// Implementation of a vehicle
  VehicleModel(
      {id,
      required this.validationState,
      required this.departureDate,
      required this.arrivedDateEst,
      arrivedDateReal,
      required this.interventionId,
      required this.iconModel,
        required this.vehicleType,
      required this.sinisterType,
      required this.name});
  late String id = "";
  String vehicleType;
  String sinisterType;
  String name;
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
      validationState: json['validationState'],
      departureDate: json['departureDate'],
      arrivedDateEst: json['arrivedDateEst'],
      arrivedDateReal: json['arrivedDateReal'],
      interventionId: json['interventionId'],
      iconModel: json['iconModel'],
      vehicleType: json['vehicleType'],
      name: json['name'],
      sinisterType: json['sinisterType']);

  /// Export VehicleModel as JSON
  Map<String, dynamic> toJson() => {
        "validationState": validationState,
        "departureDate": departureDate,
        "arrivedDateEst": arrivedDateEst,
        "arrivedDateReal": arrivedDateReal,
        "interventionId": interventionId,
        "vehicleType": vehicleType,
        "name": name,
        "sinisterType": sinisterType,
      };

  @override
  String toString() {
    return "Name : " +
        iconModel.label +
        "\nValidation : " +
        validationState +
        "\nLongitude : " +
        iconModel.longitude.toString() +
        "\nLatitude : " +
        iconModel.latitude.toString() +
        "\nvehicleType : " +
        vehicleType +
        "\ndepartureDate : " +
        departureDate +
        "\narrivedDateReal : " +
        arrivedDateReal +
        "\narrivedDateEst : " +
        arrivedDateEst +
        "\nsinisterType : " +
        sinisterType;
  }
}
