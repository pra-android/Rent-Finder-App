import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rentfinderapp/extras/theme_provider.dart';
import 'package:rentfinderapp/screens/favourites/favourties_body.dart';

class Favourites extends ConsumerWidget {
  const Favourites({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final gradientColors =
        themeMode == ThemeMode.dark
            ? [Colors.black, Colors.black] // Dark mode (no teal/green)
            : [Colors.teal, Colors.green];

    return Column(
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
                  "Favourites 💜",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        FavouritesBody(),
      ],
    );
  }
}
