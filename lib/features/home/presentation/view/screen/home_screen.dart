import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/route_names.dart';
import '../../../../../core/controllers/theme_controller.dart';
import '../../../../../core/services/api_services/api_services.dart';
import '../../../data/repositories/home_repository_impl.dart';
import '../../viewmodels/home_viewmodel.dart';
import '../widgets/repo_card.dart';
import '../widgets/repo_tile.dart';
import '../widgets/user_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments ?? {};
    final username = args['username'] ?? '';

    final viewModel =
    Get.put(HomeViewModel(HomeRepositoryImpl(ApiService())));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.fetchUserData(username);
    });

    final themeController = Get.find<ThemeController>();

    return Obx(() {
      final user = viewModel.user.value;
      final repos = viewModel.repos;
      final isGrid = viewModel.isGridView.value;

      return Scaffold(
        appBar: AppBar(
          title: Text(
            username.isNotEmpty ? username : "User Info",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
          ),
          actions: [
            IconButton(
              icon: Icon(isGrid ? Icons.list : Icons.grid_view, size: 24.sp),
              onPressed: viewModel.toggleView,
            ),
            IconButton(
              icon: Icon(
                themeController.isDarkMode.value
                    ? Icons.dark_mode
                    : Icons.light_mode,
                size: 24.sp,
              ),
              onPressed: () {
                themeController.toggleTheme();
              },
            ),
          ],
        ),
        body: viewModel.isLoading.value
            ? Center(child: CircularProgressIndicator(strokeWidth: 3.w))
            : user == null
            ? Center(
          child: Text(
            "No user data found",
            style: TextStyle(fontSize: 16.sp),
          ),
        )
            : SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              UserHeader(user: user),
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Repositories (${repos.length})",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              repos.isEmpty
                  ? Text(
                "No repositories found.",
                style: TextStyle(fontSize: 16.sp),
              )
                  : isGrid
                  ? GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.h,
                  crossAxisSpacing: 10.w,
                  childAspectRatio: 1.2,
                ),
                itemCount: repos.length,
                itemBuilder: (context, index) {
                  final repo = repos[index];
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(
                          RouteNames.repoDetailsScreen,
                          arguments: {
                            'username': username,
                            'repoName': repo.name,
                          });
                    },
                    child: RepoCard(repo: repo),
                  );
                },
              )
                  : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: repos.length,
                itemBuilder: (context, index) {
                  final repo = repos[index];
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(
                          RouteNames.repoDetailsScreen,
                          arguments: {
                            'username': username,
                            'repoName': repo.name,
                          });
                    },
                    child: RepoTile(repo: repo),
                  );
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
