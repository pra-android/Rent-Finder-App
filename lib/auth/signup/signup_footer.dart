import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentfinderapp/extras/constants/image_constant.dart';
import 'package:rentfinderapp/providers/login_with_google_provider.dart';

class SignupFooter extends StatelessWidget {
  const SignupFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),

                    onPressed: () {
                      ref.read(authController).signInWithGoogle(ref);
                    },
                    child:
                        ref.watch(loginGoogleLoading)
                            ? Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.black,
                              ),
                            )
                            : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  ImageConstant.googleLogo,
                                  height: 30.h,
                                  width: 40.w,
                                ),
                                Text(
                                  "Continue with Google",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                  );
                },
              ),
            ),
          ),
        ),
        SizedBox(height: 20.h),
        Center(
          child: Text(
            "By Clicking Create account you create to Recognotes",
            style: TextStyle(
              color: Colors.black,
              fontSize: 12.w,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
