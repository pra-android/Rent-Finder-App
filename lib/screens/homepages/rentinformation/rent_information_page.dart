import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rentfinderapp/extras/theme_provider.dart';
import 'package:rentfinderapp/model/favourites_rent.dart';
import 'package:rentfinderapp/providers/favourites_provider.dart';
import 'package:rentfinderapp/screens/homepages/rentinformation/rent_information_body.dart';
import 'package:rentfinderapp/screens/homepages/rentinformation/rent_information_footer.dart';

class RentInformationPage extends ConsumerWidget {
  final String? rentImage;
  final String rentPrice;
  final String fullName;
  final String phoneNo;
  final String category;
  final String detailAddress;
  final double latitude;

  final double longitude;
  final String cityName;
  final String rentId;
  final int noofBeds;
  const RentInformationPage({
    super.key,
    this.rentImage,
    required this.fullName,
    required this.latitude,
    required this.longitude,
    required this.category,
    required this.noofBeds,
    required this.cityName,
    required this.detailAddress,
    required this.rentPrice,
    required this.phoneNo,
    required this.rentId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;
    final textColor = isDarkMode ? Colors.grey.shade400 : Colors.black;
    final cardColor =
        themeMode == ThemeMode.dark
            ? Colors.grey[850]
            : Theme.of(context).cardColor;
    // final iconColor = isDarkMode ? Colors.white : Colors.red;
    RentModel rentModel = RentModel(
      noofBeds: noofBeds,
      imageUrl: rentImage!,
      cityName: cityName,
      detailAddress: detailAddress,
      rentPrice: rentPrice,
      rentId: rentId,
    );

    final favouriteProvider = ref.watch(favouritesProvider);
    final isFavourite = favouriteProvider.any((item) => item.rentId == rentId);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.network(
                    rentImage!,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(child: CircularProgressIndicator());
                    },
                    height: 250.h,
                    width: Get.context!.width,
                    fit: BoxFit.cover,

                    errorBuilder: (context, error, stackTrace) {
                      return SizedBox(
                        height: 165.h,
                        width: Get.context!.width,
                        child: Center(child: Text("No image available")),
                      );
                    },
                  ),
                  Positioned(
                    left: 10.0.w,
                    top: 8.h,
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: CircleAvatar(
                        backgroundColor: cardColor,
                        child: Icon(
                          Icons.arrow_back_ios_new_outlined,
                          size: 18.sp,
                          color: textColor,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 9,
                    top: 8.h,
                    child: InkWell(
                      onTap: () {
                        if (isFavourite) {
                          final rentItem = favouriteProvider.firstWhere(
                            (item) => item.rentId == rentId,
                          );
                          ref
                              .read(favouritesProvider.notifier)
                              .removeFromFavourites(rentItem.id!);
                        } else {
                          ref
                              .read(favouritesProvider.notifier)
                              .addingFavourites(rentModel);
                        }
                      },
                      child: CircleAvatar(
                        backgroundColor: cardColor,
                        child: Icon(
                          Icons.favorite_outline_outlined,
                          color: isFavourite ? Colors.red : textColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              RentInformationBody(
                fullName: fullName,
                phoneNo: phoneNo,
                rentPrice: rentPrice,
                cityName: cityName,
                detailAddress: detailAddress,
                category: category,
              ),
              RentInformationFooter(latitude: latitude, longitude: longitude),
            ],
          ),
        ),
      ),
    );
  }
}
