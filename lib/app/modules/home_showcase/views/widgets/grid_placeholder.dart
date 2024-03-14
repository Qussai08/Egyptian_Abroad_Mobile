import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class GridPlaceholder extends StatelessWidget {
  const GridPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 23.h),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 125.w,
        childAspectRatio: 0.96,
      ),
      scrollDirection: Axis.vertical,
      itemCount: 6,
      itemBuilder: (ctx, i) {
        return Column(
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: CircleAvatar(
                minRadius: 40,
              ),
            ),
            SizedBox(height: 6.h),
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: SizedBox(
                width: 80.w,
                height: 45.h,
              ),
            )
          ],
        );
      },
    );
    // return Shimmer.fromColors(
    //   baseColor: Colors.grey.shade300,
    //   highlightColor: Colors.grey.shade100,
    //   child: SizedBox(
    //     width: fixDpiScreenWidth(),
    //     height: 200.h,
    //   ),
    // );
  }
}
