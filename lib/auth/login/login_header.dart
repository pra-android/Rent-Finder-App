import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentfinderapp/extras/constants/image_constant.dart';
import 'package:rentfinderapp/extras/theme_provider.dart';

class LoginHeader extends ConsumerWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Image.asset(
            ImageConstant.loginLogo,
            height: 300.h,
            width: 300.w,
            fit: BoxFit.cover,
          ),
        ),
        Center(
          child: Text(
            "Welcome back",
            style: TextStyle(
              color: textColor,
              fontSize: 15.w,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Center(
          child: Text(
            "Login to your account",
            style: TextStyle(
              color: textColor,
              fontSize: 18.w,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}
