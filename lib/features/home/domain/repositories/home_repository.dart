import '../../data/models/repository_info_response.dart';
import '../../data/models/user_response.dart';

abstract class HomeRepository {
  Future<UserResponse> getUserInfo(String username);
  Future<List<RepositoryInfoResponse>> getUserRepos(String username);
}
