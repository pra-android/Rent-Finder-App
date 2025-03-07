import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_walkthrough_screen/flutter_walkthrough_screen.dart';
import 'package:rentfinderapp/extras/constants/image_constant.dart';

class OnboardingConstant {
  static List<OnbordingData> list = [
    OnbordingData(
      image: AssetImage(ImageConstant.onboarding1),
      titleText: Text(
        "Find Your Perfect Home",
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      descText: Text(
        "🏡 Description: Discover rental properties that match your needs. Browse listings with detailed information, photos, and locations—all in one place!",
        style: TextStyle(color: Colors.black),
      ),
    ),
    OnbordingData(
      image: AssetImage(ImageConstant.onboarding2),
      titleText: Text(
        "Explore Locations Easily",
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      descText: Text(
        "📍 Description: View rental listings on an interactive map and find properties near your desired location. Navigate effortlessly with built-in directions.",
        style: TextStyle(color: Colors.black),
      ),
    ),
    OnbordingData(
      image: AssetImage(ImageConstant.onboarding3),
      titleText: Text(
        "Connect with Owners Instantly",
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      descText: Text(
        "📞 Description: Contact property owners directly through the app. Schedule visits, negotiate rent, and secure your ideal home with ease.",
        style: TextStyle(color: Colors.black),
      ),
    ),
  ];
}
