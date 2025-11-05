import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constant/route_names.dart';
import '../../../../../core/services/api_services/api_services.dart';
import '../../../data/repositories/home_repository_impl.dart';
import '../../viewmodels/home_viewmodel.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments ?? {};
    final username = args['username'] ?? '';

    final viewModel = Get.put(HomeViewModel(HomeRepositoryImpl(ApiService())));

    // Fetch data & load theme once
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.fetchUserData(username);
      viewModel.loadTheme();
    });

    return Obx(() {
      final user = viewModel.user.value;
      final repos = viewModel.repos;
      final isGrid = viewModel.isGridView.value;
      final isDark = viewModel.isDarkMode.value;

      return Scaffold(
        appBar: AppBar(
          title: Text(username.isNotEmpty ? username : "User Info"),
          actions: [
            IconButton(
              icon: Icon(isGrid ? Icons.list : Icons.grid_view),
              onPressed: viewModel.toggleView,
            ),
            // IconButton(
            //   icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
            //   onPressed: viewModel.toggleTheme,
            // ),
          ],
        ),
        body: viewModel.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : user == null
            ? const Center(child: Text("No user data found"))
            : SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildUserHeader(user),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Repositories (${repos.length})",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              repos.isEmpty
                  ? const Text("No repositories found.")
                  : isGrid
                  ? GridView.builder(
                shrinkWrap: true,
                physics:
                const NeverScrollableScrollPhysics(),
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.2,
                ),
                itemCount: repos.length,
                itemBuilder: (context, index) {
                  final repo = repos[index];
                //  return _buildRepoCard(repo);
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteNames.repoDetailsScreen, arguments: {
                        'username': username,
                        'repoName': repo.name,
                      });
                    },
                    child: _buildRepoCard(repo),
                  );

                },
              )
                  : ListView.builder(
                shrinkWrap: true,
                physics:
                const NeverScrollableScrollPhysics(),
                itemCount: repos.length,
                itemBuilder: (context, index) {
                  final repo = repos[index];
                 // return _buildRepoTile(repo);
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteNames.repoDetailsScreen, arguments: {
                        'username': username,
                        'repoName': repo.name,
                      });
                    },
                    child: _buildRepoTile(repo),
                  );

                },
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildUserHeader(user) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(user.avatarUrl ?? ""),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name ?? "No Name",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(user.bio ?? "No bio available"),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.group, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 5),
                      Text("${user.followers ?? 0} followers"),
                      const SizedBox(width: 10),
                      Text("• ${user.following ?? 0} following"),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRepoTile(repo) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        title: Text(repo.name ?? ""),
        subtitle: Text(repo.description ?? "No description"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 18),
            const SizedBox(width: 4),
            Text("${repo.stargazersCount ?? 0}"),
          ],
        ),
      ),
    );
  }

  Widget _buildRepoCard(repo) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(repo.name ?? "",
                style:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Text(
              repo.description ?? "No description",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13),
            ),
            const Spacer(),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                const SizedBox(width: 4),
                Text("${repo.stargazersCount ?? 0}"),
                const Spacer(),
                Text(
                  repo.language ?? "N/A",
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
