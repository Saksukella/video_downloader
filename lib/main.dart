import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:video_downloader/services/routes/app_routes.dart';
import 'package:video_downloader/shared/services/preferences/s_prefs.dart';
import 'package:video_downloader/shared/ui/app_theme/app_animations/app_anim_controller.dart';

import 'services/hive/video_hive.dart';

import 'shared/services/info/package_info.dart';
import 'shared/ui/app_theme/theme/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SAppSharedPreferences.init();
  await Hive.initFlutter();
  await HiveVideo().init('videoz');
  await SAppInfo.init();
  _initAdService();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(Anims());

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (ctx, c) {
        Themes themes = Get.put(Themes());
        return Obx(() {
          return GetMaterialApp(
            title: 'Video Downloader',
            debugShowCheckedModeBanner: false,
            theme: themes.themeData,
            defaultTransition: Transition.cupertino,
            initialRoute: AppRoutes.home,
            getPages: AppRoutes.pages,
          );
        });
      },
    );
  }
}

void _initAdService() async {
  final status = MobileAds.instance.initialize();

  final RequestConfiguration requestConfiguration = RequestConfiguration(
    tagForUnderAgeOfConsent: TagForUnderAgeOfConsent.yes,
    tagForChildDirectedTreatment: TagForChildDirectedTreatment.yes,
    maxAdContentRating: MaxAdContentRating.g,
  );

  MobileAds.instance.updateRequestConfiguration(requestConfiguration);
}
