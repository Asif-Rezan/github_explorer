import 'package:get/get.dart';
import '../../core/constant/route_names.dart';
import '../../features/home/presentation/view/screen/home_screen.dart';
import '../../features/splash_screen/splash_screen.dart';

class AppRoutes {
  static const String initialRoute = RouteNames.splashScreen;

  static final List<GetPage> getPages = [
    GetPage(
      name: RouteNames.splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: RouteNames.home,
      page: () => const HomeScreen(),
    ),
  ];
}
