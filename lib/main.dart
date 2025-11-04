import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app/routes/app_routes.dart';
import 'app/themes/app_theme.dart';
import 'core/di/di_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  await diConfig();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Flutter App',
          debugShowCheckedModeBanner: false,

          // Theme setup
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.system,

          // GetX routes
          initialRoute: AppRoutes.initialRoute,
          getPages: AppRoutes.getPages,

          // Optional: smart management and transitions
          defaultTransition: Transition.fadeIn,
          smartManagement: SmartManagement.full,
        );
      },
    );
  }
}
