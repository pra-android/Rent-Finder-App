import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rentfinderapp/extras/diagrams/custom_profile_information.dart';
import 'package:rentfinderapp/extras/theme_provider.dart';
import 'package:rentfinderapp/providers/display_userdata_provider.dart';

class ProfileInformation extends ConsumerWidget {
  const ProfileInformation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final textColor = themeMode == ThemeMode.dark ? Colors.white : Colors.black;

    final cardColor =
        themeMode == ThemeMode.dark
            ? Colors.grey[850]
            : Theme.of(context).cardColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: Text(
            "Profile Information",
            style: TextStyle(
              color: textColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Consumer(
          builder: (context, ref, child) {
            final asyncData = ref.watch(userDataProvider);
            return Card(
              elevation: 3,
              color: cardColor, // Card color based on theme
              child: asyncData.when(
                data: (userData) {
                  if (userData == null) {
                    return CustomProfileInformation(
                      userName: "N/A",
                      emailId: "N/A",
                      phoneNo: "N/A",
                    );
                  } else {
                    return CustomProfileInformation(
                      userName: userData['userName'],
                      phoneNo: userData['phoneNumber'],
                      emailId: userData['emailId'],
                    );
                  }
                },
                error:
                    (error, stack) => Container(
                      height: 90.h,
                      width: Get.context!.width,
                      child: Center(
                        child: Text(
                          "Error: $error",
                          style: TextStyle(color: textColor),
                        ),
                      ),
                    ),
                loading:
                    () => Container(
                      height: 90.h,
                      width: Get.context!.width,
                      child: const Center(child: CircularProgressIndicator()),
                    ),
              ),
            );
          },
        ),
      ],
    );
  }
}
