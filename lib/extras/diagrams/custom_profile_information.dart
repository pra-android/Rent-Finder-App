import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rentfinderapp/extras/theme_provider.dart';

class CustomProfileInformation extends ConsumerWidget {
  final String? userName;
  final String? emailId;
  final String? phoneNo;
  const CustomProfileInformation({
    super.key,
    this.userName,
    this.emailId,
    this.phoneNo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final textColor = themeMode == ThemeMode.dark ? Colors.white : Colors.black;

    final cardColor =
        themeMode == ThemeMode.dark
            ? Colors.grey[850]
            : Theme.of(context).cardColor;
    return Container(
      height: 90.h,
      width: Get.context!.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Username:",
                  style: TextStyle(color: textColor, fontSize: 14.sp),
                ),
                SizedBox(height: 5.h),
                Text(
                  "Email Id:",
                  style: TextStyle(color: textColor, fontSize: 14.sp),
                ),
                SizedBox(height: 5.h),
                Text(
                  "Phone number:",
                  style: TextStyle(color: textColor, fontSize: 14.sp),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName!,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  emailId!,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  phoneNo!,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
