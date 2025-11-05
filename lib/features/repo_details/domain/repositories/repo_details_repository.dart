import '../../data/models/repo_details_response.dart';

abstract class RepoDetailsRepository {
  Future<RepoDetailsResponse> getRepoDetails(String username, String repoName);
}
