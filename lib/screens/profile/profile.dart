import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rentfinderapp/extras/theme_provider.dart';
import 'package:rentfinderapp/providers/profile_photo_provider.dart';
import 'package:rentfinderapp/screens/profile/account_settings.dart';
import 'package:rentfinderapp/screens/profile/additional_settings.dart';
import 'package:rentfinderapp/screens/profile/profile_information.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final gradientColors =
        themeMode == ThemeMode.dark
            ? [Colors.black, Colors.black]
            : [Colors.teal, Colors.green];
    final avatarBackgroundColor =
        themeMode == ThemeMode.dark ? Colors.grey[800] : Colors.blueGrey;
    final imageState = ref.watch(imageUploadProvider);
    final imageNotifier = ref.read(imageUploadProvider.notifier);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    "👨🏻‍💼 Profile 👨🏻‍💼",
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
          SizedBox(height: 10.h),
          InkWell(
            onTap: () {
              imageNotifier.pickAndUploadImage();
            },
            child: imageState.when(
              data: (data) {
                return Center(
                  child: CircleAvatar(
                    radius: 45.r,
                    backgroundColor: avatarBackgroundColor,
                    backgroundImage:
                        data != null && data.isNotEmpty
                            ? NetworkImage(data)
                            : AssetImage("assets/house.png"),
                  ),
                );
              },
              error: (err, stackTrace) {
                return Center(
                  child: CircleAvatar(
                    radius: 45.r,
                    backgroundColor: avatarBackgroundColor,
                    child: Icon(Icons.error, size: 50.r, color: Colors.red),
                  ),
                );
              },
              loading: () {
                return Center(
                  child: CircleAvatar(
                    radius: 45.r,
                    backgroundColor: avatarBackgroundColor,
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10.h),

          // Profile information
          ProfileInformation(),
          // Account settings
          AccountSettings(),
          // Additional Settings
          AdditionalSettings(),
        ],
      ),
    );
  }
}
