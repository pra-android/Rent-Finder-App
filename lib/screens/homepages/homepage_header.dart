import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rentfinderapp/extras/theme_provider.dart';
import 'package:rentfinderapp/providers/login_provider.dart';
import 'package:rentfinderapp/providers/search_provider.dart';
import 'package:rentfinderapp/screens/homepages/homepage_body.dart';

import '../../providers/display_userdata_provider.dart';

class HomepageHeader extends ConsumerWidget {
  const HomepageHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    final gradientColor =
        isDarkMode
            ? [Colors.black12, Colors.black12]
            : [Colors.teal.shade400, Colors.green.shade400];
    final asyncData = ref.watch(userDataProvider);

    return Column(
      children: [
        asyncData.when(
          data: (userData) {
            if (userData == null) {
              return Container(
                height: 230.h,
                width: Get.context!.width,
                alignment: Alignment.center,
                child: Text(
                  "No user data available",
                  style: TextStyle(color: Colors.black, fontSize: 16.sp),
                ),
              );
            }
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: gradientColor),
              ),

              height: 230.h,
              width: Get.context!.width,
              child: Column(
                children: [
                  SizedBox(height: 30.h),
                  Padding(
                    padding: EdgeInsets.only(left: 16.r),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 22.r,

                              backgroundImage:
                                  userData['profileImage'] == null ||
                                          userData['profileImage'] == ''
                                      ? AssetImage("assets/house.png")
                                      : NetworkImage(userData['profileImage']),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8.r),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hello",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.r,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    userData['userName'] ?? 'No Name',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.r,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 12.w),
                          child: InkWell(
                            onTap: () {
                              ref.read(authControllerProvider).signOut(ref);
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.logout_outlined,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 8.w),
                    child: TextFormField(
                      onChanged: (query) {
                        ref.read(searchQueryProvider.notifier).state = query;
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28.r),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28.r),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.teal,
                            child: Icon(Icons.map, color: Colors.white),
                          ),
                        ),
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        hintText: "Search address",
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(8.r), child: HomepageBody()),
                ],
              ),
            );
          },
          error:
              (error, stack) => Container(
                height: 230.h,
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
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: gradientColor),
                ),

                height: 230.h,
                width: Get.context!.width,
                child: const Center(child: CircularProgressIndicator()),
              ),
        ),
      ],
    );
  }
}
