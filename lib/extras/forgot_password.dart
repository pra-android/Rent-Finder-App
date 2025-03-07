import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rentfinderapp/extras/theme_provider.dart';
import 'package:rentfinderapp/providers/forgot_password_provider.dart';

class ForgotPassword extends ConsumerWidget {
  const ForgotPassword({super.key});

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
            color: Colors.white, // Icon color based on theme
          ),
        ),
        backgroundColor: backgroundColor, // AppBar color based on theme
        title: Text(
          "Forgot Password",
          style: TextStyle(
            color: Colors.white, // Title text color based on theme
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Form(
        key: ref.watch(forgotPasswordKey),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.w),
              child: TextFormField(
                controller: ref.watch(forgotPasswordController),
                decoration: InputDecoration(
                  hintText: "Please enter your email",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.w),
                    borderSide: BorderSide(width: 1, color: textColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.w),
                    borderSide: BorderSide(width: 1, color: textColor),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.w),
                    borderSide: BorderSide(width: 1, color: textColor),
                  ),
                ),
              ),
            ),
            //button
            const SizedBox(height: 25),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  fixedSize: Size(Get.context!.width / 2 + 80, 50.h),
                  backgroundColor: buttonColor, // Button color based on theme
                ),
                onPressed: () async {
                  if (ref.watch(forgotPasswordKey).currentState!.validate()) {
                    try {
                      ref.watch(forgotPasswordLoading.notifier).state = true;
                      await ref
                          .read(authProvider)
                          .sendPasswordResetEmail(
                            email: ref.watch(forgotPasswordController).text,
                          );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Password reset email sent...Check your email",
                          ),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(e.toString())));
                    } finally {
                      ref.watch(forgotPasswordLoading.notifier).state = false;
                      ref.watch(forgotPasswordController).clear();
                    }
                  }
                },
                child:
                    ref.watch(forgotPasswordLoading)
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                          "Change Password",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
