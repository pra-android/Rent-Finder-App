import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rentfinderapp/extras/theme_provider.dart';
import 'package:rentfinderapp/screens/profile/change_password_form.dart';

class ChangePassword extends ConsumerWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final backgroundColor = isDarkMode ? Colors.black : Colors.green;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 18.sp,
            color: Colors.white, // Icon color based on theme
          ),
        ),
        backgroundColor: backgroundColor, // AppBar color based on theme
        title: Text(
          "Change Password",
          style: TextStyle(
            color: Colors.white, // Title text color based on theme
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 7),
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Text(
              "Your new password must fulfill the following fields criteria ",
              style: TextStyle(
                color: textColor, // Text color based on theme
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 15.h),
          ChangePasswordForm(),
        ],
      ),
    );
  }
}
