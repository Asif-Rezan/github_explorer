import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/app_colors.dart';
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

    final viewModel = Get.put(
      RepoDetailsViewModel(RepoDetailsRepositoryImpl(ApiService())),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.fetchRepoDetails(username, repoName);
    });

    return Obx(() {
      final repo = viewModel.repoDetails.value;

      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(
            repoName,
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
          ),
          elevation: 0,
          backgroundColor: AppColors.background,
          foregroundColor: AppColors.textPrimary,
        ),
        body: viewModel.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : repo == null
            ? const Center(child: Text("No repository details found"))
            : SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Repository Title
              Text(
                repo.fullName ?? "",
                style: TextStyle(
                    fontSize: 22.sp, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
              SizedBox(height: 10.h),

              // Description
              if (repo.description != null)
                Text(
                  repo.description!,
                  style: TextStyle(fontSize: 16.sp, color: AppColors.textSecondary),
                ),
              SizedBox(height: 20.h),

              // Owner Info
              if (repo.owner != null)
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30.r,
                      backgroundImage: NetworkImage(repo.owner?.avatarUrl ?? ""),
                    ),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          repo.owner?.login ?? "",
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "Owner",
                          style: TextStyle(fontSize: 14.sp, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ],
                ),
              SizedBox(height: 25.h),

              // Stats: Stars, Forks, Watchers
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildStat(Icons.star, AppColors.star, "${repo.stargazersCount ?? 0}"),
                  SizedBox(width: 20.w),
                  _buildStat(Icons.call_split, AppColors.fork, "${repo.forksCount ?? 0}"),
                  SizedBox(width: 20.w),
                  _buildStat(Icons.remove_red_eye, AppColors.watchers, "${repo.watchersCount ?? 0}"),
                ],
              ),
              SizedBox(height: 25.h),

              // Language & License
              if (repo.language != null || repo.license != null)
                Wrap(
                  spacing: 20.w,
                  runSpacing: 10.h,
                  children: [
                    if (repo.language != null)
                      _buildInfoChip(Icons.code, AppColors.codeLanguage, "Language: ${repo.language}"),
                    if (repo.license != null)
                      _buildInfoChip(Icons.book, AppColors.license, "License: ${repo.license?.name ?? "N/A"}"),
                  ],
                ),
              SizedBox(height: 25.h),

              // Created & Updated
              _buildInfoRow(Icons.calendar_today, "Created: ${repo.createdAt ?? 'N/A'}"),
              SizedBox(height: 8.h),
              _buildInfoRow(Icons.update, "Last updated: ${repo.updatedAt ?? 'N/A'}"),
              SizedBox(height: 25.h),

              // Topics
              if (repo.topics != null && repo.topics!.isNotEmpty)
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: repo.topics!
                      .map((topic) => Chip(
                    label: Text(topic, style: TextStyle(fontSize: 14.sp)),
                    backgroundColor: AppColors.chipBackground,
                  ))
                      .toList(),
                ),
              SizedBox(height: 25.h),

              // Open Issues
              _buildInfoRow(Icons.bug_report, "Open Issues: ${repo.openIssuesCount ?? 0}", color: AppColors.bug),
              SizedBox(height: 25.h),

              // Homepage & GitHub URL
              if (repo.homepage != null && repo.homepage!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Homepage:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: AppColors.textPrimary)),
                    SizedBox(height: 4.h),
                    Text(repo.homepage!, style: TextStyle(color: AppColors.link, fontSize: 14.sp)),
                    SizedBox(height: 15.h),
                  ],
                ),
              Text("GitHub URL:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: AppColors.textPrimary)),
              SizedBox(height: 4.h),
              Text(repo.htmlUrl ?? "", style: TextStyle(color: AppColors.link, fontSize: 14.sp)),
            ],
          ),
        ),
      );
    });
  }

  // Helper for stats
  Widget _buildStat(IconData icon, Color color, String value) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20.sp),
        SizedBox(width: 6.w),
        Text(value, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
      ],
    );
  }

  // Helper for row info
  Widget _buildInfoRow(IconData icon, String text, {Color? color}) {
    return Row(
      children: [
        Icon(icon, color: color ?? AppColors.iconDefault, size: 18.sp),
        SizedBox(width: 8.w),
        Flexible(
          child: Text(text, style: TextStyle(fontSize: 14.sp, color: AppColors.textPrimary)),
        ),
      ],
    );
  }

  // Helper for info chip
  Widget _buildInfoChip(IconData icon, Color color, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16.sp),
          SizedBox(width: 6.w),
          Text(text, style: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp)),
        ],
      ),
    );
  }
}
