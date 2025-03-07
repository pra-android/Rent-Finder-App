import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rentfinderapp/extras/theme_provider.dart';

class SignUpHeader extends ConsumerWidget {
  const SignUpHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Column(
      children: [
        SizedBox(height: 40.h),
        Text(
          "Create an account",
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
            fontSize: min(18.sp, 22),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already Have an account?",
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                "Login",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
