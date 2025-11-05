import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserHeader extends StatelessWidget {
  final user;
  const UserHeader({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.r,
              backgroundImage: NetworkImage(user.avatarUrl ?? ""),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name ?? "No Name",
                    style: TextStyle(
                        fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    user.bio ?? "No bio available",
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Icon(Icons.group, size: 16.sp, color: Colors.grey[600]),
                      SizedBox(width: 5.w),
                      Text("${user.followers ?? 0} followers",
                          style: TextStyle(fontSize: 12.sp)),
                      SizedBox(width: 10.w),
                      Text("• ${user.following ?? 0} following",
                          style: TextStyle(fontSize: 12.sp)),
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
}
