import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDarkMode ? Colors.black12 : Colors.green.shade700;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final headerTextColor = isDarkMode ? Colors.white : Colors.black;
    final subHeaderTextColor =
        isDarkMode ? Colors.grey.shade300 : Colors.black87;

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
        backgroundColor: primaryColor,
        title: Text(
          "Privacy Policy",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8.w),
                child: Text(
                  "Privacy Policy of Rent Finder App",
                  style: TextStyle(
                    color: headerTextColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                "Welcome to Rent Finder! Your privacy is important to us. This Privacy Policy explains how we collect, use, and protect your information when you use our application.",
                style: TextStyle(color: textColor),
              ),
              SizedBox(height: 5.h),
              Padding(
                padding: EdgeInsets.all(8.w),
                child: Text(
                  "Information We Collect:",
                  style: TextStyle(
                    color: headerTextColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                "Personal Information: When you sign up, we may collect your name, email address, phone number, and profile picture.\n\tUsage Data: We collect information on how you interact with the app to improve our services.",
                style: TextStyle(color: textColor),
              ),
              Padding(
                padding: EdgeInsets.all(8.w),
                child: Text(
                  "How we use your information:",
                  style: TextStyle(
                    color: headerTextColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(4.w),
                child: Text(
                  "Provide, maintain, and improve the Rent Finder app.\nFacilitate communication between renters and landlords.\nPersonalize your experience by displaying relevant rental listings.\nEnhance security and prevent fraud.",
                  style: TextStyle(color: textColor),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.w),
                child: Text(
                  "Data Security:",
                  style: TextStyle(
                    color: headerTextColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                "We take appropriate measures to protect your data from unauthorized access, alteration, or disclosure.",
                style: TextStyle(color: textColor),
              ),
              Padding(
                padding: EdgeInsets.all(8.w),
                child: Text(
                  "Your rights:",
                  style: TextStyle(
                    color: headerTextColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.r),
                child: Text(
                  "Access, update, or delete your personal information.\nDisable location tracking from your device settings.\nContact us to inquire about your data privacy concerns.",
                  style: TextStyle(color: textColor),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.w),
                child: Text(
                  "Contact Us:",
                  style: TextStyle(
                    color: headerTextColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Text(
                  "If you have any questions, please contact us at bhattaraipravin123@gmail.com",
                  style: TextStyle(color: subHeaderTextColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
