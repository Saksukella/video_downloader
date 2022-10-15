import '../../../../native/surface/snackbars/snackbar.dart';

void showThemeChangeSnackbar(
  String prefix,
  Function() onUndoClicked,
) {
  showSnackbarWithAction(
      "Color", "${prefix} color is saved", "UNDO", onUndoClicked,
      duration: 4);
}
