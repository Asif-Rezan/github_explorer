import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../services/api_services/api_services.dart';

final GetIt getIt = GetIt.instance;

Future<void> diConfig() async {
  // ore Services
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<ApiService>(() => ApiService());


}