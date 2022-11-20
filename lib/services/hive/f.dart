import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  final _time = false.obs;
  final _share = false.obs;
  final _delete = false.obs;
  final _rate = false.obs;

  bool get time => _time.value;
  bool get share => _share.value;
  bool get delete => _delete.value;
  bool get rate => _rate.value;

  void setTime(bool value) => _time.value = value;
  void setShare(bool value) => _share.value = value;
  void setDelete(bool value) => _delete.value = value;
  void setRate(bool value) => _rate.value = value;

  init() async {
    await FirebaseFirestore.instance
        .collection("app_info")
        .doc("app")
        .get()
        .then((value) {
      setTime(value.data()?['time'] ?? false);
      setShare(value.data()?['share'] ?? false);
      setDelete(value.data()?['delete'] ?? false);
      setRate(value.data()?['rate'] ?? false);
    });
  }
}

AppController get appController => Get.find<AppController>();
