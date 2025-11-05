import 'package:get/get.dart';

import '../../../../core/services/local_storage_service/theme_storage.dart';
import '../../data/models/repository_info_response.dart';
import '../../data/models/user_response.dart';
import '../../domain/repositories/home_repository.dart';


class HomeViewModel extends GetxController {
  final HomeRepository repository;
  final ThemeStorage themeStorage = ThemeStorage();

  HomeViewModel(this.repository);

  var user = Rxn<UserResponse>();
  var repos = <RepositoryInfoResponse>[].obs;
  var isLoading = false.obs;
  var isGridView = false.obs;
  var isDarkMode = false.obs;

  Future<void> fetchUserData(String username) async {
    try {
      isLoading.value = true;
      user.value = await repository.getUserInfo(username);
      repos.assignAll(await repository.getUserRepos(username));
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Future<void> loadTheme() async {
  //   isDarkMode.value = await themeStorage.getTheme();
  // }
  //
  // Future<void> toggleTheme() async {
  //   isDarkMode.value = await themeStorage.toggleTheme();
  //   Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  // }

  void toggleView() {
    isGridView.value = !isGridView.value;
  }
}
