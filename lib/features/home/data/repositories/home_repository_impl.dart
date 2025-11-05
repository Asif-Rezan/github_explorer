import 'package:dio/dio.dart';

import '../../../../core/constant/api_endpoints.dart';
import '../../../../core/services/api_services/api_services.dart';
import '../../domain/repositories/home_repository.dart';
import '../models/repository_info_response.dart';
import '../models/user_response.dart';

class HomeRepositoryImpl implements HomeRepository {
  final ApiService apiService;

  HomeRepositoryImpl(this.apiService);

  @override
  Future<UserResponse> getUserInfo(String username) async {
    try {
      Response response = await apiService.get(ApiEndPoints.getUserInfo(username));
      return UserResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<RepositoryInfoResponse>> getUserRepos(String username) async {
    try {
      Response response = await apiService.get(ApiEndPoints.getRepoInfo(username));
      List data = response.data;
      return data.map((e) => RepositoryInfoResponse.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
