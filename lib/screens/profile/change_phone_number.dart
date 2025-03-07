import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rentfinderapp/extras/theme_provider.dart';
import 'package:rentfinderapp/providers/change_phone_provider.dart';

class ChangePhoneNumber extends ConsumerWidget {
  const ChangePhoneNumber({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final backgroundColor = isDarkMode ? Colors.black : Colors.green;
    final buttonColor = isDarkMode ? Colors.grey[850] : Colors.green;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 18.sp,
            color: Colors.white,
          ),
        ),
        backgroundColor: backgroundColor,
        title: Text(
          "Change Phone Number",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          return Form(
            key: ref.watch(keyForChangePhoneNo),
            child: Column(
              children: [
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.only(left: 8.w, right: 8.w),

                  child: Consumer(
                    builder: (context, ref, child) {
                      return TextFormField(
                        keyboardType: TextInputType.number,
                        controller: ref.watch(changePhoneNoController),
                        decoration: InputDecoration(
                          hintText: "Enter Phone no:",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.r),
                            borderSide: BorderSide(width: 1, color: textColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.r),
                            borderSide: BorderSide(width: 1, color: textColor),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.r),
                            borderSide: BorderSide(width: 1, color: textColor),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 15.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    fixedSize: Size(Get.context!.width / 2 + 80, 50),
                    backgroundColor: buttonColor,
                  ),
                  onPressed: () {
                    if (ref
                        .watch(keyForChangePhoneNo)
                        .currentState!
                        .validate()) {
                      ref
                          .watch(firestoreServiceProvider)
                          .updatePhoneNumber(
                            ref,
                            ref.watch(changePhoneNoController).text,
                          );
                    }
                  },
                  child:
                      ref.watch(changePhoneNoLoading)
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                            "Change Password",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                            ),
                          ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
