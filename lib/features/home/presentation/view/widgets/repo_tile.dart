import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RepoTile extends StatelessWidget {
  final repo;
  const RepoTile({Key? key, required this.repo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 2,
      child: ListTile(
        title: Text(
          repo.name ?? "",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          repo.description ?? "No description",
          style: TextStyle(fontSize: 13.sp),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.star, color: Colors.amber, size: 16.sp),
            SizedBox(width: 4.w),
            Text("${repo.stargazersCount ?? 0}", style: TextStyle(fontSize: 14.sp)),
          ],
        ),
      ),
    );
  }
}
