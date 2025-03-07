import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rentfinderapp/auth/signup/signup.dart';
import 'package:rentfinderapp/extras/theme_provider.dart';

class LoginFooter extends ConsumerWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Have not created account?",
              style: TextStyle(color: textColor, fontSize: 14.w),
            ),
            TextButton(
              onPressed: () {
                Get.to(() => SignUpScreen());
              },
              child: Text(
                "Signup",
                style: TextStyle(fontSize: 16.w, color: textColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
