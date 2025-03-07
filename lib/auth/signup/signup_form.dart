import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentfinderapp/controller/signup_validation.dart';
import 'package:rentfinderapp/extras/diagrams/signup_textform_field.dart';
import 'package:rentfinderapp/extras/theme_provider.dart';
import 'package:rentfinderapp/providers/signup_provider.dart';

class SignupForm extends ConsumerWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailcontroller = ref.watch(emailController);
    final usernamecontroller = ref.watch(userNameController);
    final phonecontroller = ref.watch(phoneNumberController);
    final passwordcontroller = ref.watch(passwordController);
    final confirmpasswordcontroller = ref.watch(confirmPasswordController);
    final themeMode = ref.watch(themeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;
    final buttonColor = isDarkMode ? Colors.grey[850] : Colors.deepPurple;
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: ref.watch(signUpKey),
      child: Column(
        children: [
          SizedBox(height: 15.h),

          Padding(
            padding: EdgeInsets.only(left: 14.w, right: 14.w),
            child: SignupTextformField(
              textEditingController: emailcontroller,
              validator: (val) {
                return SignupValidation.emailValidation(val!);
              },
              hintText: "Email address",
              prefixIcon: Icon(Icons.email_outlined, color: Colors.black),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 14.w, right: 14.w, top: 7.h),
            child: SignupTextformField(
              textEditingController: usernamecontroller,
              validator: (val) {
                return SignupValidation.userNameValidation(val!);
              },
              hintText: "Username",
              prefixIcon: Icon(Icons.person_2_outlined, color: Colors.black),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 14.w, right: 14.w, top: 7.h),
            child: SignupTextformField(
              textEditingController: phonecontroller,
              textInputType: TextInputType.number,
              hintText: "Phone number",
              prefixIcon: Icon(
                Icons.phone_android_outlined,
                color: Colors.black,
              ),
              validator: (val) {
                return SignupValidation.phoneNumberValidation(val!);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 14.w, right: 14.w, top: 7.h),
            child: SignupTextformField(
              textEditingController: passwordcontroller,
              obscureText: true,
              hintText: "Password",
              validator: (val) {
                return SignupValidation.passwordValidation(val!);
              },

              prefixIcon: Icon(Icons.password_outlined, color: Colors.black),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 14.w, right: 14.w, top: 7.h),
            child: SignupTextformField(
              textEditingController: confirmpasswordcontroller,
              obscureText: true,
              hintText: "Confirm Password",
              prefixIcon: Icon(Icons.lock_outline, color: Colors.black),
              validator: (val) {
                return SignupValidation.confirmPasswordValidation(
                  passwordcontroller.text,
                  val!,
                );
              },
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.all(8.w),
            child: SizedBox(
              width: double.infinity,
              height: 57.h,
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: Consumer(
                  builder: (context, ref, child) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),

                      onPressed: () {
                        if (ref.watch(signUpKey).currentState!.validate()) {
                          ref
                              .read(authControllerProvider)
                              .signup(
                                ref.watch(emailController).text,
                                ref.watch(userNameController).text,
                                ref.watch(phoneNumberController).text,
                                ref.watch(passwordController).text,
                                ref,
                              );
                        }
                      },
                      child:
                          ref.watch(isLoading)
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                "Create Account",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Text("or sign up with"),
                ),
                Expanded(child: Divider()),
              ],
            ),
          ),

          //SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
