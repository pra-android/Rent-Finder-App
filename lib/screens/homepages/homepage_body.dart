import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentfinderapp/extras/constants/home_categorize_constant.dart';
import 'package:rentfinderapp/providers/display_rent_information.dart';

class HomepageBody extends ConsumerWidget {
  const HomepageBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SizedBox(height: 3.h),
        Container(
          height: 73.h,
          width: 280.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),

          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: HomeCategorizeConstant.categories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  children: [
                    SizedBox(height: 12.h),
                    InkWell(
                      onTap: () {
                        ref.watch(categoryIndex.notifier).state = index;
                      },
                      child: CircleAvatar(
                        backgroundColor:
                            ref.watch(categoryIndex) == index
                                ? Colors.green
                                : Colors
                                    .blueGrey
                                    .shade100, // Change color on selection
                        radius: 22.r,
                        child: Icon(
                          HomeCategorizeConstant.categories[index]['icon']
                              as IconData,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      HomeCategorizeConstant.categories[index]['title']
                          as String,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
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
