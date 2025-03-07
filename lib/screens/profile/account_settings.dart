import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rentfinderapp/extras/theme_provider.dart';
import 'package:rentfinderapp/screens/profile/change_password.dart';
import 'package:rentfinderapp/screens/profile/change_phone_number.dart';

import '../../providers/login_provider.dart';

class AccountSettings extends ConsumerWidget {
  const AccountSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the current theme mode from the theme provider
    final themeMode = ref.watch(themeProvider);

    final textColor = themeMode == ThemeMode.dark ? Colors.white : Colors.black;
    final cardColor =
        themeMode == ThemeMode.dark
            ? Colors.grey[850] // Dark mode card background color
            : Theme.of(context).cardColor; // Light mode card color

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: Text(
            "Account Settings",
            style: TextStyle(
              color: textColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Consumer(
          builder: (context, ref, child) {
            return InkWell(
              onTap: () {
                ref.read(authControllerProvider).signOut(ref);
              },
              child: Card(
                elevation: 0,
                color: cardColor, // Card color based on theme
                child: ListTile(
                  leading: Icon(
                    Icons.logout_outlined,
                    color: textColor, // Icon color based on theme
                  ),
                  title: Text(
                    "Sign out",
                    style: TextStyle(
                      color: textColor,
                    ), // Text color based on theme
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 14.sp,
                    color: textColor, // Icon color based on theme
                  ),
                ),
              ),
            );
          },
        ),

        InkWell(
          onTap: () {
            Get.to(() => ChangePassword());
          },
          child: Card(
            elevation: 0,
            color: cardColor, // Card color based on theme
            child: ListTile(
              leading: Icon(
                Icons.change_circle_outlined,
                color: textColor, // Icon color based on theme
              ),
              title: Text(
                "Change Password",
                style: TextStyle(color: textColor), // Text color based on theme
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                size: 14.sp,
                color: textColor, // Icon color based on theme
              ),
            ),
          ),
        ),
        //phone number
        InkWell(
          onTap: () {
            Get.to(() => ChangePhoneNumber());
          },
          child: Card(
            elevation: 0,
            color: cardColor, // Card color based on theme
            child: ListTile(
              leading: Icon(
                Icons.change_circle_outlined,
                color: textColor, // Icon color based on theme
              ),
              title: Text(
                "Change Phone number",
                style: TextStyle(color: textColor), // Text color based on theme
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                size: 14.sp,
                color: textColor, // Icon color based on theme
              ),
            ),
          ),
        ),

        Card(
          color: cardColor,
          elevation: 0,
          // Card color based on theme
          child: InkWell(
            onTap: () {
              exit(0);
            },
            child: ListTile(
              leading: Icon(
                Icons.exit_to_app_outlined,
                color: textColor, // Icon color based on theme
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                size: 14.sp,
                color: textColor, // Icon color based on theme
              ),
              title: Text(
                "Exit from app",
                style: TextStyle(color: textColor), // Text color based on theme
              ),
            ),
          ),
        ),
      ],
    );
  }
}
