import 'package:get/get.dart';

import '../../data/models/repo_details_response.dart';
import '../../domain/repositories/repo_details_repository.dart';

class RepoDetailsViewModel extends GetxController {
  final RepoDetailsRepository repository;

  RepoDetailsViewModel(this.repository);

  var repoDetails = Rxn<RepoDetailsResponse>();
  var isLoading = false.obs;

  Future<void> fetchRepoDetails(String username, String repoName) async {
    try {
      isLoading.value = true;
      repoDetails.value = await repository.getRepoDetails(username, repoName);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
