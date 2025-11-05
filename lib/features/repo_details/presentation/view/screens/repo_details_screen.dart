import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/services/api_services/api_services.dart';
import '../../../data/repositories/repo_details_repository_impl.dart';
import '../../viewmodels/repo_details_viewmodel.dart';

class RepoDetailsScreen extends StatelessWidget {
  const RepoDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments ?? {};
    final username = args['username'] ?? '';
    final repoName = args['repoName'] ?? '';

    final viewModel = Get.put(RepoDetailsViewModel(RepoDetailsRepositoryImpl(ApiService())));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.fetchRepoDetails(username, repoName);
    });

    return Obx(() {
      final repo = viewModel.repoDetails.value;

      return Scaffold(
        appBar: AppBar(
          title: Text(repoName),
        ),
        body: viewModel.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : repo == null
            ? const Center(child: Text("No repository details found"))
            : SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Repository Title
              Text(
                repo.fullName ?? "",
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // Description
              if (repo.description != null)
                Text(
                  repo.description!,
                  style: const TextStyle(fontSize: 16),
                ),
              const SizedBox(height: 16),

              // Owner Info
              if (repo.owner != null)
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage:
                      NetworkImage(repo.owner?.avatarUrl ?? ""),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(repo.owner?.login ?? "",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600)),
                        Text("Owner"),
                      ],
                    ),
                  ],
                ),
              const SizedBox(height: 20),

              // Stars, Forks, Watchers
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text("${repo.stargazersCount ?? 0} stars"),
                  const SizedBox(width: 20),
                  const Icon(Icons.call_split, color: Colors.blue),
                  const SizedBox(width: 4),
                  Text("${repo.forksCount ?? 0} forks"),
                  const SizedBox(width: 20),
                  const Icon(Icons.remove_red_eye, color: Colors.green),
                  const SizedBox(width: 4),
                  Text("${repo.watchersCount ?? 0} watchers"),
                ],
              ),
              const SizedBox(height: 20),

              // Language
              if (repo.language != null)
                Row(
                  children: [
                    const Icon(Icons.code, color: Colors.purple),
                    const SizedBox(width: 8),
                    Text("Language: ${repo.language}"),
                  ],
                ),
              const SizedBox(height: 16),

              // License
              if (repo.license != null)
                Row(
                  children: [
                    const Icon(Icons.book, color: Colors.brown),
                    const SizedBox(width: 8),
                    Text("License: ${repo.license?.name ?? "N/A"}"),
                  ],
                ),
              const SizedBox(height: 16),

              // Created & Updated
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 18),
                  const SizedBox(width: 8),
                  Text("Created: ${repo.createdAt ?? 'N/A'}"),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.update, size: 18),
                  const SizedBox(width: 8),
                  Text("Last updated: ${repo.updatedAt ?? 'N/A'}"),
                ],
              ),
              const SizedBox(height: 20),

              // Topics
              if (repo.topics != null && repo.topics!.isNotEmpty)
                Wrap(
                  spacing: 8,
                  children: repo.topics!
                      .map((topic) => Chip(
                    label: Text(topic),
                    backgroundColor:
                    Theme.of(context).colorScheme.surface,
                  ))
                      .toList(),
                ),

              const SizedBox(height: 20),

              // Open issues
              Row(
                children: [
                  const Icon(Icons.bug_report, color: Colors.red),
                  const SizedBox(width: 8),
                  Text("Open Issues: ${repo.openIssuesCount ?? 0}"),
                ],
              ),
              const SizedBox(height: 20),

              // Homepage or GitHub URL
              if (repo.homepage != null && repo.homepage!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Homepage:",
                        style:
                        TextStyle(fontWeight: FontWeight.bold)),
                    Text(repo.homepage!,
                        style: const TextStyle(color: Colors.blue)),
                    const SizedBox(height: 10),
                  ],
                ),
              const Text("GitHub URL:",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(repo.htmlUrl ?? "",
                  style: const TextStyle(color: Colors.blue)),
            ],
          ),
        ),
      );
    });
  }
}
