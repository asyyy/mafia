
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

enum iconEnum{
  UNKNOWN,
  ACT_CENTER,
  ACT_ZONE,
  AIR_MEANS,
  CH_DOTTED,
  CH_FULL,
  COM_3_DOT_POST,
  COM_3_FUL_POST,
  COM_4_DOT_POST,
  COM_4_FUL_POST,
  CRM_DOT,
  CRM_FULL,
  DAN_SRC_FULL,
  DAN_SRC_EMPTY,
  DAN_SRC_B,
  DAN_SRC_C,
  DAN_SRC_E,
  DAN_SRC_N,
  DAN_SRC_R,
  ELE_DOT,
  ELE_FULL,
  EMU_DOT,
  EMU_FULL,
  SEC_BLUE,
  SEC_BLUE_2,
  SEC_BLUE_3,
  SEC_BLUE_4,
  SEC_GREEN,
  SEC_GREEN_2,
  SEC_GREEN_3,
  SEC_GREEN_4,
  SEC_YELLO,
  SEC_YELLO_2,
  SEC_YELLO_3,
  SEC_YELLO_4,
  SEC_RED,
  SEC_RED_2,
  SEC_RED_3,
  SEC_RED_4,
  H_DOT,
  H_FULL,
  MEC_DOT,
  MEC_FULL,
  MED_DOT,
  MED_FULL,
  MOR_DOT,
  MOR_FULL,
  NOT_SP_MEAN,
  NOT_SP_MEAN_PLANNED,
  OIL_DOT,
  OIL_FULL,
  PAR_DOT,
  PAR_FULL,
  PHA_DOT,
  PHA_FULL,
  AIR_MEANS_PLANNED,
  PMA_DOT,
  PMA_FULL,
  PRV_DOT,
  PRV_FULL,
  PSY_DOT,
  PSY_FULL,
  RES_DOT,
  RES_FULL,
  SEC_BLACK,
  SEN_PT_FULL,
  SEN_PT_OUTLINED,
  SP_COL_MEANS,
  SP_GRP_MEANS,
  SP_MEANS,
  SP_MEANS_PLANNED,
  TARGET_ZONE,
  TP_DOT,
  TP_FULL,
  VET_DOT,
  VET_FULL,
  WAT_BOM_HELI,
  WAT_BOM_PLANE,
  VSAV_GRP,
  VSAV_COL,
  VSAV_SOLO,
  VSAV_PLANNED,
  FPT_COL,
  FPT_GRP,
  FPT_SOLO,
  FPT_PLANNED,
  VLCG_SOLO,
  VLCG_GRP,
  VLCG_COL,
  VLCG_PLANNED
}
class IconVehicule extends StatelessWidget{
  final String path;
   String? upNote;
   String? downNote;
   String? leftNote;
   String? rightNote;
   Color? color;

  IconVehicule(this.path,[this.upNote = "",this.downNote = "",this.rightNote = "", this.leftNote = "",this.color]);
  @override
  Widget build(BuildContext context) {
    return
    Column(
      children: [
        Row(
          children: [
            Text(upNote!)],
        ),
        Row(
            children:
            [
              RotatedBox(
                  quarterTurns: 1,
                  child: Text(leftNote!)
              ),
              SvgPicture.asset(path, color: color!,),
              RotatedBox(
                  quarterTurns: 1,
                  child: Text(rightNote!)
              ),
            ]
        ),
        Row(
          children: [Text(downNote!)],
        )
      ],
    );
  }

}
extension iconEnumExtension on iconEnum{

  String get path{
    String path ="assets/icons/";
    switch(this){
      case iconEnum.ACT_CENTER:
        path = path +  "ActionCenter.svg";
        break;
      case iconEnum.ACT_ZONE:
        path = path + "ActionZone.svg";
        break;
      case iconEnum.AIR_MEANS:
        path = path + "AirMeans.svg";
        break;
      case iconEnum.CH_DOTTED:
        path = path + "CHDotted.svg";
        break;
      case iconEnum.CH_FULL:
        path = path + "CHFull.svg";
        break;
      case iconEnum.COM_3_DOT_POST:
        path = path + "CommandPost3Dotted.svg";
        break;
      case iconEnum.COM_3_FUL_POST:
        path = path + "CommandPost3Full.svg";
        break;
      case iconEnum.COM_4_DOT_POST:
        path = path + "CommandPost3Dotted.svg";
        break;
      case iconEnum.COM_4_FUL_POST:
        path = path + "CommandPost3Full.svg";
        break;
      case iconEnum.CRM_DOT:
        path = path + "CRMDotted.svg";
        break;
      case iconEnum.CRM_FULL:
        path = path + "CRMFull.svg";
        break;
      case iconEnum.DAN_SRC_EMPTY:
        path = path + "DangerSourceEmpty.svg";
        break;
      case iconEnum.DAN_SRC_FULL:
        path = path + "DangerSourceFull.svg";
        break;
      case iconEnum.DAN_SRC_B:
        path = path + "DangerSourceN.svg";
        break;
      case iconEnum.DAN_SRC_C:
        path = path + "DangerSourceC.svg";
        break;
      case iconEnum.DAN_SRC_E:
        path = path + "DangerSourceE.svg";
        break;
      case iconEnum.DAN_SRC_N:
        path = path + "DangerSourceN.svg";
        break;
      case iconEnum.DAN_SRC_R:
        path = path + "DangerSourceR.svg";
        break;
      case iconEnum.ELE_DOT:
        path = path + "ELECDotted.svg";
        break;
      case iconEnum.ELE_FULL:
        path = path + "ELECFull.svg";
        break;
      case iconEnum.EMU_DOT:
        path = path + "EMULDotted.svg";
        break;
      case iconEnum.EMU_FULL:
        path = path + "EMULFull.svg";
        break;
      case iconEnum.SEC_BLUE:
        path = path + "FuncSectorBlue.svg";
        break;
      case iconEnum.SEC_BLUE_2:
        path = path + "FuncSectorBlue2.svg";
        break;
      case iconEnum.SEC_BLUE_3:
        path = path + "FuncSectorBlue3.svg";
        break;
      case iconEnum.SEC_BLUE_4:
        path = path + "FuncSectorBlue4.svg";
        break;
      case iconEnum.SEC_GREEN:
        path = path + "FuncSectorGreen.svg";
        break;
      case iconEnum.SEC_GREEN_2:
        path = path + "FuncSectorGreen2.svg";
        break;
      case iconEnum.SEC_GREEN_3:
        path = path + "FuncSectorGreen3.svg";
        break;
      case iconEnum.SEC_GREEN_4:
        path = path + "FuncSectorGreen4.svg";
        break;
      case iconEnum.SEC_YELLO:
        path = path + "FuncSectorYellow.svg";
        break;
      case iconEnum.SEC_YELLO_2:
        path = path + "FuncSectorYellow2.svg";
        break;
      case iconEnum.SEC_YELLO_3:
        path = path + "FuncSectorYellow3.svg";
        break;
      case iconEnum.SEC_YELLO_4:
        path = path + "FuncSectorYellow4.svg";
        break;
      case iconEnum.SEC_RED:
        path = path + "FuncSectorRed.svg";
        break;
      case iconEnum.SEC_RED_2:
        path = path + "FuncSectorRed2.svg";
        break;
      case iconEnum.SEC_RED_3:
        path = path + "FuncSectorRed3.svg";
        break;
      case iconEnum.SEC_RED_4:
        path = path + "FuncSectorRed4.svg";
        break;
      case iconEnum.H_DOT:
        path = path + "HDotted.svg";
        break;
      case iconEnum.H_FULL:
        path = path + "HFull.svg";
        break;
      case iconEnum.MEC_DOT:
        path = path + "MECDotted.svg";
        break;
      case iconEnum.MEC_FULL:
        path = path + "MECFull.svg";
        break;
      case iconEnum.MED_DOT:
        path = path + "MEDDotted.svg";
        break;
      case iconEnum.MED_FULL:
        path = path + "MEDFull.svg";
        break;
      case iconEnum.MOR_DOT:
        path = path + "MORDotted.svg";
        break;
      case iconEnum.MOR_FULL:
        path = path + "MORFull.svg";
        break;
      case iconEnum.NOT_SP_MEAN:
        path = path + "NotSPMean.svg.svg";
        break;
      case iconEnum.NOT_SP_MEAN_PLANNED:
        path = path + "NotSPMeanPlanned.svg";
        break;
      case iconEnum.OIL_DOT:
        path = path + "OILDotted.svg";
        break;
      case iconEnum.OIL_FULL:
        path = path + "OILFull.svg";
        break;
      case iconEnum.PAR_DOT:
        path = path + "PARDotted.svg";
        break;
      case iconEnum.PAR_FULL:
        path = path + "PARFULL.svg";
        break;
      case iconEnum.PHA_DOT:
        path = path + "PHADotted.svg";
        break;
      case iconEnum.PHA_FULL:
        path = path + "PHAFull.svg";
        break;
      case iconEnum.AIR_MEANS_PLANNED:
        path = path + "PlannedAirMeans.svg";
        break;
      case iconEnum.PMA_DOT:
        path = path + "PMADotted.svg";
        break;
      case iconEnum.PMA_FULL:
        path = path + "PMAFull.svg";
        break;
      case iconEnum.PRV_DOT:
        path = path + "PRVDotted.svg";
        break;
      case iconEnum.PRV_FULL:
        path = path + "PRVFull.svg";
        break;
      case iconEnum.PSY_DOT:
        path = path + "PSYDotted.svg";
        break;
      case iconEnum.PSY_FULL:
        path = path + "PSYFull.svg";
        break;
      case iconEnum.RES_DOT:
        path = path + "RESTDotted.svg";
        break;
      case iconEnum.RES_FULL:
        path = path + "RESTFull.svg";
        break;
      case iconEnum.SEC_BLACK:
        path = path + "SectFoncBlack.svg";
        break;
      case iconEnum.SP_COL_MEANS:
        path = path + "SPColumnMeans.svg";
        break;
      case iconEnum.SP_GRP_MEANS:
        path = path + "SPGroupMeans.svg";
        break;
      case iconEnum.SP_MEANS:
        path = path + "SPSoloMeans.svg";
        break;
      case iconEnum.SP_MEANS_PLANNED:
        path = path + "SPMeansPlanned.svg";
        break;
      case iconEnum.TARGET_ZONE:
        path = path + "TargetZone.svg";
        break;
      case iconEnum.TP_DOT:
        path = path + "TransitPointDotted.svg";
        break;
      case iconEnum.TP_FULL:
        path = path + "TransitPointFull.svg";
        break;
      case iconEnum.VET_DOT:
        path = path + "VETDotted.svg";
        break;
      case iconEnum.VET_FULL:
        path = path + "VETFull.svg";
        break;
      case iconEnum.WAT_BOM_HELI:
        path = path + "WaterBomberHeli.svg";
        break;
      case iconEnum.WAT_BOM_PLANE:
        path = path + "WaterBomberPlane.svg";
        break;
      case iconEnum.SEN_PT_FULL:
        path = path + "SensitivePoint.svg";
        break;
      case iconEnum.SEN_PT_OUTLINED:
        path = path + "SensitivePointOutlined.svg";
        break;
      case iconEnum.VSAV_GRP:
        path = path + "VSAVGroup.svg";
        break;
      case iconEnum.VSAV_COL:
        path = path + "VSAVCol.svg";
        break;
      case iconEnum.VSAV_SOLO:
        path = path + "VSAVSolo.svg";
        break;
      case iconEnum.VSAV_PLANNED:
        path = path + "VSAVPlanned.svg";
        break;
      case iconEnum.FPT_COL:
        path = path + "FPTCol.svg";
        break;
      case iconEnum.FPT_GRP:
        path = path + "FPTGroup.svg";
        break;
      case iconEnum.FPT_SOLO:
        path = path + "FPTSolo.svg";
        break;
      case iconEnum.FPT_PLANNED:
        path = path + "FPTPlanned.svg";
        break;
      case iconEnum.VLCG_SOLO:
        path = path + "VLCGSolo.svg";
        break;
      case iconEnum.VLCG_GRP:
        path = path + "VLCGGroup.svg";
        break;
      case iconEnum.VLCG_COL:
        path = path + "VLCGCol.svg";
        break;
      case iconEnum.VLCG_PLANNED:
        path = path + "VLCGPlanned.svg";
        break;
      case iconEnum.UNKNOWN:
        // TODO: Handle this case.
        break;
    }
    return path;
  }

}