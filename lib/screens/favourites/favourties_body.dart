import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rentfinderapp/extras/theme_provider.dart';
import 'package:rentfinderapp/providers/favourites_provider.dart';

class FavouritesBody extends ConsumerWidget {
  const FavouritesBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;

    // Set text and background colors based on theme
    final textColor = isDarkMode ? Colors.white : Colors.black;

    final priceColor =
        isDarkMode ? Colors.grey.shade500 : Colors.teal; // Text color
    final cardColor =
        themeMode == ThemeMode.dark
            ? Colors.grey[850] // Dark mode card background color
            : Theme.of(context).cardColor;

    final favorites = ref.watch(favouritesProvider);
    final iconColor = isDarkMode ? Colors.white : Colors.red;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w),
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return SizedBox(height: 3);
            },
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final rentItem = favorites[index];

              return Container(
                color: cardColor,
                height: 115.h,
                width: Get.context!.width,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(4.r),
                          child: Image.network(
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: cardColor,
                                height: 90.h,
                                width: 100.w,

                                child: Center(
                                  child: Text(
                                    "Image not available",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              );
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(child: CircularProgressIndicator());
                            },
                            rentItem.imageUrl,
                            height: 90.h,
                            width: 100.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(10.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${rentItem.cityName},${rentItem.detailAddress}",
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),

                                Text(
                                  "Rs ${rentItem.rentPrice}",
                                  style: TextStyle(
                                    color: priceColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "No.of Beds: ${rentItem.noofBeds}",
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        IconButton(
                          onPressed: () {
                            ref
                                .watch(favouritesProvider.notifier)
                                .removeFromFavourites(rentItem.id!);
                          },
                          icon: Icon(Icons.delete, color: iconColor),
                        ),
                      ],
                    ),
                    Divider(),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
