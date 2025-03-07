import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rentfinderapp/extras/theme_provider.dart';
import 'package:rentfinderapp/providers/display_rent_information.dart';
import 'package:rentfinderapp/providers/search_provider.dart';
import 'package:rentfinderapp/screens/homepages/rentinformation/rent_information_page.dart';

class HomePageFooter extends ConsumerWidget {
  const HomePageFooter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;
    final textColor = isDarkMode ? Colors.grey.shade400 : Colors.black;
    final iconColor = isDarkMode ? Colors.white : Colors.red;
    final rentsAsyncValue = ref.watch(rentStreamProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    final cardColor =
        themeMode == ThemeMode.dark
            ? Colors.grey[850]
            : Theme.of(context).cardColor;

    return rentsAsyncValue.when(
      data: (rents) {
        final filteredRents =
            rents.where((rent) {
              final cityName = rent['cityName'].toLowerCase();
              return cityName.contains(searchQuery.toLowerCase());
            }).toList();
        if (filteredRents.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100.h),
              Center(
                child: Text(
                  'No rents available',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          );
        } else {
          return Column(
            children: [
              ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(height: 1.h);
                },
                itemCount: filteredRents.length,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  final rent = filteredRents[index];
                  return SizedBox(
                    height: 245.h,
                    width: Get.context!.width,

                    child: InkWell(
                      onTap: () {
                        Get.to(
                          RentInformationPage(
                            rentId: rent['rentId'],
                            latitude: rent['latitude'],
                            longitude: rent['longitude'],
                            rentImage: rent['rentImage'],
                            fullName: rent['sellerName'],
                            cityName: rent['cityName'],
                            detailAddress: rent['detailAddress'],
                            category: rent['category'],
                            phoneNo: rent['sellerPhoneNumber'],
                            rentPrice: rent['rentPrice'],
                            noofBeds: int.parse(rent['noOfBeds']),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 12.0,
                              right: 12.0,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child:
                                  rent['rentImage'] == null
                                      ? Container(
                                        color: cardColor,
                                        height: 165.h,
                                        width: Get.context!.width,
                                        child: Center(
                                          child: Text(
                                            "No image available",
                                            style: TextStyle(color: textColor),
                                          ),
                                        ),
                                      )
                                      : Image.network(
                                        loadingBuilder: (
                                          context,
                                          child,
                                          loadingProgress,
                                        ) {
                                          if (loadingProgress == null)
                                            return child;
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) {
                                          return Container(
                                            color: cardColor,
                                            height: 165.h,
                                            width: Get.context!.width,
                                            child: Center(
                                              child: Text(
                                                "Check your internet connection to preview image",
                                                style: TextStyle(
                                                  color: textColor,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        rent['rentImage'],
                                        height: 165.h,
                                        width: Get.context!.width,
                                        fit: BoxFit.fill,
                                      ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.location_pin, color: iconColor),
                                    Text(
                                      "${rent['cityName']},${rent['detailAddress']}",
                                      style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 9.w),
                                  child: Text(
                                    "Rs ${rent['rentPrice']}",
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: textColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 18.w),
                            child: Text(
                              "Number of Beds:${rent['noOfBeds']}",
                              style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 18.w),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.time_to_leave_outlined,
                                  color: textColor,
                                ),
                                Text(
                                  "Posted at: ",
                                  style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                Text(
                                  DateFormat(
                                    'yyyy-MM-dd HH:mm',
                                  ).format(rent['createdAt'].toDate()),
                                  style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        }
      },
      error: (err, stack) => Center(child: Text('Error: $err')),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}
