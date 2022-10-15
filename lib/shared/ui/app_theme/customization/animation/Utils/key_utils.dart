import '../res/data.dart';

List<String> getAnimationUtils_ControllerKeys() {
  List<String> keys = [];

  for (var element in anim_models) {
    keys.add(element.keys[0]);
  }
  return keys;
}
