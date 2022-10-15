import 'package:flex_color_scheme/flex_color_scheme.dart';

class SchemeModel {
  final String name;
  final FlexScheme scheme;

  SchemeModel({required this.name, required this.scheme});
}

List<SchemeModel> schemeList() {
  // return flexSchemes with the scheme name
  return [
    SchemeModel(
      name: "Amber",
      scheme: FlexScheme.amber,
    ),
    SchemeModel(
      name: "Aqua Blue",
      scheme: FlexScheme.aquaBlue,
    ),
    SchemeModel(
      name: "Bahama Blue",
      scheme: FlexScheme.bahamaBlue,
    ),
    SchemeModel(
      name: "Barossa",
      scheme: FlexScheme.barossa,
    ),
    SchemeModel(
      name: "Big Stone",
      scheme: FlexScheme.bigStone,
    ),
    SchemeModel(
      name: "Blue",
      scheme: FlexScheme.blue,
    ),
    SchemeModel(
      name: "Blue Whale",
      scheme: FlexScheme.blueWhale,
    ),
    SchemeModel(
      name: "Blumine Blue",
      scheme: FlexScheme.blumineBlue,
    ),
    SchemeModel(
      name: "Damask",
      scheme: FlexScheme.damask,
    ),
    SchemeModel(
      name: "Deep Blue",
      scheme: FlexScheme.deepBlue,
    ),
    SchemeModel(
      name: "Deep Purple",
      scheme: FlexScheme.deepPurple,
    ),
    SchemeModel(
      name: "Dell Genoa",
      scheme: FlexScheme.dellGenoa,
    ),
    SchemeModel(
      name: "Ebony Clay",
      scheme: FlexScheme.ebonyClay,
    ),
    SchemeModel(
      name: "Espresso",
      scheme: FlexScheme.espresso,
    ),
    SchemeModel(
      name: "Flutter Dash",
      scheme: FlexScheme.flutterDash,
    ),
    SchemeModel(
      name: "Green",
      scheme: FlexScheme.green,
    ),
    SchemeModel(
      name: "Grey Law",
      scheme: FlexScheme.greyLaw,
    ),
    SchemeModel(
      name: "Gold",
      scheme: FlexScheme.gold,
    ),
    SchemeModel(
      name: "Hippie Blue",
      scheme: FlexScheme.hippieBlue,
    ),
    SchemeModel(
      name: "Indigo",
      scheme: FlexScheme.indigo,
    ),
    SchemeModel(
      name: "Jungle",
      scheme: FlexScheme.jungle,
    ),
    SchemeModel(
      name: "Mallard Green",
      scheme: FlexScheme.mallardGreen,
    ),
    SchemeModel(
      name: "Mandy Red",
      scheme: FlexScheme.mandyRed,
    ),
    SchemeModel(
      name: "Mango",
      scheme: FlexScheme.mango,
    ),
    SchemeModel(
      name: "Material",
      scheme: FlexScheme.material,
    ),
    SchemeModel(
      name: "Material Baseline",
      scheme: FlexScheme.materialBaseline,
    ),
    SchemeModel(
      name: "Material HC",
      scheme: FlexScheme.materialHc,
    ),
    SchemeModel(
      name: "Money",
      scheme: FlexScheme.money,
    ),
    SchemeModel(
      name: "Outer Space",
      scheme: FlexScheme.outerSpace,
    ),
    SchemeModel(
      name: "Purple Brown",
      scheme: FlexScheme.purpleBrown,
    ),
    SchemeModel(
      name: "Red",
      scheme: FlexScheme.red,
    ),
    SchemeModel(
      name: "Red Wine",
      scheme: FlexScheme.redWine,
    ),
    SchemeModel(
      name: "Rosewood",
      scheme: FlexScheme.rosewood,
    ),
    SchemeModel(
      name: "Sakura",
      scheme: FlexScheme.sakura,
    ),
    SchemeModel(
      name: "San Juan Blue",
      scheme: FlexScheme.sanJuanBlue,
    ),
    SchemeModel(
      name: "Shark",
      scheme: FlexScheme.shark,
    ),
    SchemeModel(
      name: "Verdun Hemlock",
      scheme: FlexScheme.verdunHemlock,
    ),
    SchemeModel(
      name: "Vesuvius Burn",
      scheme: FlexScheme.vesuviusBurn,
    ),
    SchemeModel(
      name: "Wasabi",
      scheme: FlexScheme.wasabi,
    ),
  ];
}
