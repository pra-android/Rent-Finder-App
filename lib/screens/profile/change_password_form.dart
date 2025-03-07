import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rentfinderapp/controller/change_password_validation.dart';
import 'package:rentfinderapp/extras/theme_provider.dart';
import 'package:rentfinderapp/providers/change_password_provider.dart';

class ChangePasswordForm extends ConsumerWidget {
  const ChangePasswordForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final buttonColor = isDarkMode ? Colors.grey[850] : Colors.green;
    return Form(
      key: ref.watch(keyForChangePassword),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text("Current Password", style: TextStyle(color: textColor)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: TextFormField(
              controller: ref.watch(currentPasswordController),
              obscureText: ref.watch(passwordStatus1),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    ref.read(passwordStatus1.notifier).state =
                        !ref.watch(passwordStatus1);
                  },
                  icon:
                      ref.watch(passwordStatus1)
                          ? Icon(
                            Icons.visibility_off_outlined,
                            color: textColor,
                          )
                          : Icon(Icons.visibility_outlined, color: textColor),
                ),
                hintText: "******",
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 17.0,
                  horizontal: 15.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  borderSide: BorderSide(width: 1, color: textColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  borderSide: BorderSide(width: 1, color: textColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  borderSide: BorderSide(width: 1, color: textColor),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text("Password", style: TextStyle(color: textColor)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: TextFormField(
              obscureText: ref.watch(passwordStatus2),
              validator: (val) {
                return ChangePasswordValidation.passwordValidation(val!);
              },
              controller: ref.watch(changePasswordController),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    ref.read(passwordStatus2.notifier).state =
                        !ref.watch(passwordStatus2);
                  },
                  icon:
                      ref.watch(passwordStatus2)
                          ? Icon(
                            Icons.visibility_off_outlined,
                            color: textColor,
                          )
                          : Icon(Icons.visibility_outlined, color: textColor),
                ),
                hintText: "******",
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 17.0,
                  horizontal: 15.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  borderSide: BorderSide(width: 1, color: textColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  borderSide: BorderSide(width: 1, color: textColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  borderSide: BorderSide(width: 1, color: textColor),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          //Confirm Password
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text("Confirm Password", style: TextStyle(color: textColor)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: TextFormField(
              obscureText: ref.watch(passwordStatus3),
              validator: (val) {
                return ChangePasswordValidation.confirmPasswordValidation(
                  ref.watch(changePasswordController).text,
                  val!,
                );
              },
              controller: ref.watch(changePasswordConfirmController),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    ref.read(passwordStatus3.notifier).state =
                        !ref.watch(passwordStatus3);
                  },
                  icon:
                      ref.watch(passwordStatus3)
                          ? Icon(
                            Icons.visibility_off_outlined,
                            color: textColor,
                          )
                          : Icon(Icons.visibility_outlined, color: textColor),
                ),
                hintText: "******",
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 17.0,
                  horizontal: 15.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  borderSide: BorderSide(width: 1, color: textColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  borderSide: BorderSide(width: 1, color: textColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  borderSide: BorderSide(width: 1, color: textColor),
                ),
              ),
            ),
          ),

          const SizedBox(height: 25),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                fixedSize: Size(Get.context!.width / 2 + 80, 50),
                backgroundColor: buttonColor, // Button color based on theme
              ),
              onPressed: () {
                if (ref.watch(keyForChangePassword).currentState!.validate()) {
                  ref
                      .watch(authControllerChangePassword)
                      .changePassword(
                        ref,
                        ref.watch(currentPasswordController).text,
                        ref.watch(changePasswordController).text,
                      );
                }
              },
              child:
                  ref.watch(changePasswordLoading)
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                        "Change Password",
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
