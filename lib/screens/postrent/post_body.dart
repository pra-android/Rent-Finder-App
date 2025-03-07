import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentfinderapp/controller/rent_validation.dart';
import 'package:rentfinderapp/extras/diagrams/build_text_field_column.dart';
import 'package:rentfinderapp/extras/theme_provider.dart';
import 'package:rentfinderapp/providers/rent_image_provider.dart';
import 'package:rentfinderapp/providers/rent_information_provider.dart';
import 'package:rentfinderapp/screens/postrent/post_body_second_part.dart';

class PostBody extends StatefulWidget {
  const PostBody({super.key});

  @override
  State<PostBody> createState() => _PostBodyState();
}

class _PostBodyState extends State<PostBody> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final themeMode = ref.watch(themeProvider);
        final isDarkMode = themeMode == ThemeMode.dark;
        final textColor = isDarkMode ? Colors.white : Colors.black;
        final buttonColor = isDarkMode ? Colors.grey[850] : Colors.green;
        final imageUrl = ref.watch(imageUploadProvider);
        final submissionStatus = ref.watch(submittedStatus);

        return Form(
          autovalidateMode:
              submissionStatus
                  ? AutovalidateMode.disabled
                  : AutovalidateMode.onUserInteraction,
          key: ref.watch(postRentKey),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Text(
                  "Add your Properties photo by clicking camera",
                  style: TextStyle(
                    color: textColor, // Changed to textColor
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              Center(
                child: InkWell(
                  onTap: () async {
                    await ref
                        .read(imageUploadProvider.notifier)
                        .pickAndUploadRentImage();
                  },

                  child: CircleAvatar(
                    backgroundColor: buttonColor,
                    radius: 35.r,
                    backgroundImage: imageUrl.when(
                      data:
                          (url) =>
                              url != null
                                  ? NetworkImage(url)
                                  : AssetImage("assets/house.png"),
                      error: (_, _) => null,
                      loading: () => AssetImage('assets/loading.gif'),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.r),
                child: Row(
                  children: [
                    Expanded(
                      child: BuildTextFieldColumn.buildTextFieldColumn(
                        validation: (val) {
                          return RentValidation.validateSellerName(val!);
                        },
                        controller: ref.watch(sellerName),
                        context: context,
                        label: "Seller name",
                        hintText: "Mr X",
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Expanded(
                      child: BuildTextFieldColumn.buildTextFieldColumn(
                        validation: (val) {
                          return RentValidation.validateSellerPhoneNumber(val!);
                        },
                        context: context,
                        controller: ref.watch(sellerPhoneNumber),
                        label: "Seller Phone no",
                        hintText: "98XXX",
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              //Address
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.r),
                child: Row(
                  children: [
                    Expanded(
                      child: BuildTextFieldColumn.buildTextFieldColumn(
                        validation: (val) {
                          return RentValidation.validatecityName(val!);
                        },
                        controller: ref.watch(cityName),
                        context: context,
                        label: "City name",
                        hintText: "Biratnagar",
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Expanded(
                      child: BuildTextFieldColumn.buildTextFieldColumn(
                        validation: (val) {
                          return RentValidation.validatedetailAddress(val!);
                        },
                        controller: ref.watch(detailAddress),
                        label: "Detail Address",
                        context: context,
                        hintText: "OilNigam",
                      ),
                    ),
                  ],
                ),
              ),
              PostBodySecondPart(),
            ],
          ),
        );
      },
    );
  }
}
