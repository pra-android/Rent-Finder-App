import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rentfinderapp/extras/theme_provider.dart';
import 'package:rentfinderapp/screens/postrent/post_body.dart';

class PostRent extends ConsumerWidget {
  const PostRent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final gradientColors =
        themeMode == ThemeMode.dark
            ? [Colors.black, Colors.black] // Dark mode (no teal/green)
            : [Colors.teal, Colors.green];

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 72.h,
            width: Get.context!.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: gradientColors),
            ),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 40.h),
                  Text(
                    "Post Rent Facilities",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          PostBody(),
        ],
      ),
    );
  }
}
