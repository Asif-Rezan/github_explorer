import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constant/route_names.dart';
import '../../viewmodel/first_screen_viewmodel.dart';


class FirstScreen extends StatelessWidget {
  FirstScreen({Key? key}) : super(key: key);

  final FirstScreenViewModel controller = Get.put(FirstScreenViewModel());
  final TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GitHub User Finder"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Enter a GitHub Username",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                hintText: "e.g. torvalds",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.person),
              ),
              onChanged: (value) => controller.setUsername(value),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (controller.username.value.isEmpty) {
                  Get.snackbar(
                    "Error",
                    "Please enter a username",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                } else {
                  Get.toNamed(RouteNames.home, arguments: {
                    'username': controller.username.value,
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "View Repositories",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
