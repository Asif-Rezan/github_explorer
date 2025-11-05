import 'package:dio/dio.dart';

import '../../../../core/constant/api_endpoints.dart';
import '../../../../core/services/api_services/api_services.dart';
import '../../domain/repositories/repo_details_repository.dart';
import '../models/repo_details_response.dart';


class RepoDetailsRepositoryImpl implements RepoDetailsRepository {
  final ApiService apiService;

  RepoDetailsRepositoryImpl(this.apiService);

  @override
  Future<RepoDetailsResponse> getRepoDetails(String username, String repoName) async {
    try {
      Response response = await apiService.get(ApiEndPoints.getRepoDetails(username, repoName));
      return RepoDetailsResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
