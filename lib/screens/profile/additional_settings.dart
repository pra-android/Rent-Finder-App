import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rentfinderapp/extras/privacy_policy.dart';
import 'package:rentfinderapp/extras/theme_provider.dart';

class AdditionalSettings extends ConsumerWidget {
  const AdditionalSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the current theme mode from the theme provider
    final themeMode = ref.watch(themeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;

    // Set text and background colors based on theme
    final textColor = isDarkMode ? Colors.white : Colors.black; // Text color
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
            "Additional Settings",
            style: TextStyle(
              color: textColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Consumer(
          builder: (context, ref, child) {
            return Card(
              elevation: 0,
              color: cardColor, // Card color based on theme
              child: ListTile(
                leading: Icon(
                  Icons.brightness_1,
                  color: textColor, // Icon color based on theme
                ),
                trailing: Switch(
                  value: isDarkMode,
                  onChanged: (val) {
                    ref.read(themeProvider.notifier).toggleTheme();
                  },
                ),
                title: Text(
                  "Theme Mode",
                  style: TextStyle(
                    color: textColor,
                  ), // Text color based on theme
                ),
              ),
            );
          },
        ),

        InkWell(
          onTap: () {
            Get.to(() => PrivacyPolicy());
          },
          child: Card(
            elevation: 0,

            color: cardColor, // Card color based on theme
            child: ListTile(
              leading: Icon(
                Icons.privacy_tip_outlined,
                color: textColor, // Icon color based on theme
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                size: 14.sp,
                color: textColor, // Icon color based on theme
              ),
              title: Text(
                "Privacy Policy",
                style: TextStyle(color: textColor), // Text color based on theme
              ),
            ),
          ),
        ),
      ],
    );
  }
}
