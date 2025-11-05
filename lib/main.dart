import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/config/app_config.dart';
import 'app/routes/app_routes.dart';
import 'app/themes/app_theme.dart';
import 'core/controllers/theme_controller.dart';
import 'core/di/di_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await diConfig();

  // Initialize theme controller
  final themeController = Get.put(ThemeController());

  runApp(MyApp(themeController: themeController));
}

class MyApp extends StatelessWidget {
  final ThemeController themeController;
  const MyApp({super.key, required this.themeController});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) {
        return Obx(() {
          return GetMaterialApp(
            title: AppConfig.appName,
            debugShowCheckedModeBanner: false,

            // Theme setup
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeController.isDarkMode.value
                ? ThemeMode.dark
                : ThemeMode.light,

            // Routes
            initialRoute: AppRoutes.initialRoute,
            getPages: AppRoutes.getPages,

            defaultTransition: Transition.fadeIn,
            smartManagement: SmartManagement.full,
          );
        });
      },
    );
  }
}
