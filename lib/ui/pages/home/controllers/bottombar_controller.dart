import 'package:get/get.dart';

class BottomBarController extends GetxController {
  final _currentIndex = 0.obs;
  int _previousIndex = 1;

  int get currentIndex => _currentIndex.value;

  int get previousIndex => _previousIndex;

  set currentIndex(int index) {
    _previousIndex = _currentIndex.value;
    _currentIndex.value = index;
  }
}
