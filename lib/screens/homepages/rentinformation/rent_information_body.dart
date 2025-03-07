import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentfinderapp/extras/diagrams/rent_display_board.dart';

class RentInformationBody extends StatelessWidget {
  final String rentPrice;
  final String fullName;
  final String phoneNo;
  final String detailAddress;
  final String cityName;
  final String category;
  const RentInformationBody({
    super.key,
    required this.rentPrice,
    required this.fullName,
    required this.phoneNo,
    required this.detailAddress,
    required this.category,
    required this.cityName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 8.h),
        RentDisplayBoard(
          header: "Basic Rent Information:",
          firstPoint: "Owner Name:",
          secondPoint: "Contact number:",
          thirdPoint: "Rent Price:",
          fourthPoint: fullName,
          fifthPoint: phoneNo,
          sixPoint: rentPrice,
        ),
        SizedBox(height: 10.h),
        RentDisplayBoard(
          header: "Propety Details:",
          firstPoint: "City Name:",
          secondPoint: "Locality:",
          thirdPoint: "Category Type:",
          fourthPoint: cityName,
          fifthPoint: detailAddress,
          sixPoint: category,
        ),
      ],
    );
  }
}
