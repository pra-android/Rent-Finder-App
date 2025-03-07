import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rentfinderapp/controller/signup_validation.dart';
import 'package:rentfinderapp/extras/diagrams/custom_text_form_field.dart';
import 'package:rentfinderapp/extras/forgot_password.dart';
import 'package:rentfinderapp/extras/theme_provider.dart';
import 'package:rentfinderapp/providers/login_provider.dart';

class LoginForm extends ConsumerWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPasswordVisible = ref.watch(hidePassword);
    final themeMode = ref.watch(themeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final buttonColor = isDarkMode ? Colors.grey[850] : Colors.deepPurple;
    return Form(
      key: ref.watch(logInKey),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(14.w),
            child: CustomTextFormField(
              controller: ref.watch(loginEmailController),
              prefixIcon: Icon(Icons.email_outlined),
              hintText: "Email",
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 14.w, right: 14.w),
            child: CustomTextFormField(
              controller: ref.watch(loginPasswordController),
              obscureText: isPasswordVisible,
              hintText: "Password",
              prefixIcon: Icon(Icons.password_outlined),
              suffixIcon: IconButton(
                onPressed: () {
                  ref.read(hidePassword.notifier).state = !isPasswordVisible;
                },
                icon:
                    ref.watch(hidePassword)
                        ? Icon(Icons.visibility_off_outlined)
                        : Icon(Icons.visibility_outlined),
              ),
            ),
          ),
          SizedBox(height: 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Get.to(() => ForgotPassword());
                },
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(fontSize: 13.w, color: textColor),
                ),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: SizedBox(
              width: double.infinity,
              height: 42.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),

                onPressed: () {
                  ref
                      .read(authControllerProvider)
                      .loginWithEmail(
                        ref,
                        ref.watch(loginEmailController).text,
                        ref.watch(loginPasswordController).text,
                      );
                },
                child:
                    ref.watch(loginLoading)
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                          "Login Now",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.w,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
