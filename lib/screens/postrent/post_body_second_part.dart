import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:rentfinderapp/controller/rent_validation.dart';
import 'package:rentfinderapp/extras/theme_provider.dart';
import 'package:rentfinderapp/providers/location_tracker_provider.dart';
import 'package:rentfinderapp/providers/rent_image_provider.dart';
import 'package:rentfinderapp/providers/rent_information_provider.dart';
import 'package:rentfinderapp/screens/postrent/map_screen.dart';

class PostBodySecondPart extends StatefulWidget {
  const PostBodySecondPart({super.key});

  @override
  State<PostBodySecondPart> createState() => _PostBodySecondPartState();
}

class _PostBodySecondPartState extends State<PostBodySecondPart> {
  String selectedValue = 'Single Room';
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final themeMode = ref.watch(themeProvider);
        final isDarkMode = themeMode == ThemeMode.dark;
        final textColor = isDarkMode ? Colors.white : Colors.black;
        final buttonColor = isDarkMode ? Colors.grey[850] : Colors.green;
        final selectedLocation = ref.watch(selectedLocationProvider);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5.h),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 8.w, top: 10.h),
                        child: Text(
                          "Enter no of beds",
                          style: TextStyle(
                            color: textColor, // Changed to textColor
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.r),
                        child: TextFormField(
                          controller: ref.watch(noOfBeds),
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            return RentValidation.validateNoOfBeds(val!);
                          },
                          decoration: InputDecoration(
                            hintText: "0 to 100",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: textColor),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: textColor),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: textColor),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 8.w, top: 10.h),
                        child: Text(
                          "Rent Price",
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.r),
                        child: TextFormField(
                          controller: ref.watch(rentPrice),
                          validator: (val) {
                            return RentValidation.validateRentPrice(val!);
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Rs XXXX",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: textColor),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: textColor),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: textColor),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.only(left: 8.w, top: 10.h),
              child: Text(
                "Select category",
                style: TextStyle(
                  color: textColor, // Changed to textColor
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.w),
              child: SizedBox(
                width: double.infinity,
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.w,
                      ), // Light border
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1.w,
                      ), // Focus color
                    ),
                  ),
                  value: selectedValue,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      // Added null check
                      setState(() {
                        selectedValue = newValue;
                      });
                    }
                  },
                  items:
                      <String>[
                        'Single Room',
                        'Whole Flat',
                        'House',
                        'Hostel/PG',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.r),
              child: Row(
                children: [
                  Text(
                    "Select Location of House from side icon",
                    style: TextStyle(
                      color: textColor, // Changed to textColor
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final LatLng? result = await Get.to(() => MapScreen());
                      if (result != null) {
                        Text(
                          "Latitude and Longitudes are:${result.latitude},${result.latitude}",
                        );
                        log(
                          "Latitude and Longitudes are:${result.latitude},${result.latitude}",
                        );
                      } else {
                        log("No location selected");
                      }
                    },
                    icon: Icon(
                      Icons.location_pin,
                      color: Colors.red,
                      size: 24.sp,
                    ),
                  ),
                ],
              ),
            ),
            if (selectedLocation != null)
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Text(
                  "Latitude: ${selectedLocation.latitude}\nLongitude: ${selectedLocation.longitude}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            else
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Text(
                  "No location selected",
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),

            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.all(14.w),
              child: SizedBox(
                height: 42.h,
                width: Get.context!.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.w),
                    ),
                  ),
                  onPressed: () {
                    final rentImageUrl = ref.watch(imageUploadProvider).value;

                    if (ref.watch(postRentKey).currentState!.validate() &&
                        (rentImageUrl != null) &&
                        selectedLocation != null) {
                      ref
                          .read(rentInformationProvider.notifier)
                          .postRentInformation(
                            ref: ref,
                            rentImage: rentImageUrl,
                            latitude: selectedLocation.latitude,
                            longitude: selectedLocation.longitude,
                            sellername: ref.watch(sellerName).text,
                            sellerphoneNumber:
                                ref.watch(sellerPhoneNumber).text,
                            cityname: ref.watch(cityName).text,
                            detailaddress: ref.watch(detailAddress).text,
                            noofBeds: ref.watch(noOfBeds).text,
                            rentprice: ref.watch(rentPrice).text,
                            category: selectedValue,
                          );
                      ref.watch(submittedStatus.notifier).state = true;
                      Future.delayed(Duration(seconds: 1), () {
                        ref.read(submittedStatus.notifier).state =
                            false; // Reset after submission
                      });
                    } else {
                      Fluttertoast.showToast(
                        msg: "You have missed the data while filling form",
                      );
                    }
                  },
                  child: Text(
                    "Create Rent ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
