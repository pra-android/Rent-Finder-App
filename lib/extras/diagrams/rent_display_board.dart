import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rentfinderapp/extras/theme_provider.dart';

class RentDisplayBoard extends ConsumerWidget {
  final String header;
  final String firstPoint;
  final String secondPoint;
  final String thirdPoint;
  final String fourthPoint;
  final String fifthPoint;
  final String sixPoint;
  const RentDisplayBoard({
    super.key,
    required this.header,
    required this.firstPoint,
    required this.secondPoint,
    required this.fifthPoint,
    required this.fourthPoint,
    required this.sixPoint,
    required this.thirdPoint,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;
    final cardColor =
        themeMode == ThemeMode.dark
            ? Colors.grey[850]
            : Theme.of(context).cardColor;
    final textColor = isDarkMode ? Colors.grey.shade400 : Colors.black;
    final gradientColors =
        themeMode == ThemeMode.dark
            ? [Colors.black, Colors.black]
            : [Colors.teal, Colors.green];
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.w, right: 8.w),
          child: Container(
            height: 35.h,
            width: Get.context!.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: gradientColors),
            ),

            child: Padding(
              padding: EdgeInsets.only(top: 8.h, left: 5.h),
              child: Text(
                header,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 6.w),
          child: Card(
            elevation: 1,
            color: cardColor,
            child: Padding(
              padding: EdgeInsets.only(top: 8.h, left: 8.h, bottom: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        firstPoint,
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ),
                      Text(
                        secondPoint,
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ),
                      Text(
                        thirdPoint,
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fourthPoint,
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          fifthPoint,
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          sixPoint,
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
