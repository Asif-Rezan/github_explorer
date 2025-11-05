import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RepoCard extends StatelessWidget {
  final repo;
  const RepoCard({Key? key, required this.repo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              repo.name ?? "",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8.h),
            Flexible(
              child: Text(
                repo.description ?? "No description",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 13.sp),
              ),
            ),
            Spacer(),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 16.sp),
                SizedBox(width: 4.w),
                Text("${repo.stargazersCount ?? 0}", style: TextStyle(fontSize: 14.sp)),
                Spacer(),
                Text(
                  repo.language ?? "N/A",
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
