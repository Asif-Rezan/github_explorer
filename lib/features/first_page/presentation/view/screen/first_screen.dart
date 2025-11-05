import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constant/route_names.dart';
import '../../viewmodel/first_screen_viewmodel.dart';

class FirstScreen extends StatelessWidget {
  FirstScreen({super.key});

  final FirstScreenViewModel controller = Get.put(FirstScreenViewModel());
  final TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "GitHub User Finder",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter a GitHub Username",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 20.h),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                hintText: "e.g. torvalds",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                prefixIcon: Icon(Icons.person, size: 24.sp),
              ),
              style: TextStyle(fontSize: 16.sp),
              onChanged: (value) => controller.setUsername(value),
            ),
            SizedBox(height: 30.h),
            ElevatedButton(
              onPressed: () {
                if (controller.username.value.isEmpty) {
                  Get.snackbar(
                    "Error",
                    "Please enter a username",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.redAccent,
                    colorText: Colors.white,
                    duration: Duration(seconds: 2),
                  );
                } else {
                  Get.toNamed(RouteNames.home, arguments: {
                    'username': controller.username.value,
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                "View Repositories",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
