import 'package:get/get.dart';

import '../../ui/pages/home/home.dart';

class AppRoutes {
  static String home = '/';

  static List<GetPage> pages = [
    GetPage(name: '/', page: () => const Home()),
  ];
}
