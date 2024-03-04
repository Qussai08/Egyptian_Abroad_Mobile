import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class GridPlaceholder extends StatelessWidget {
  const GridPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SizedBox(
        width: fixDpiScreenWidth(),
        height: 200.h,
      ),
    );
  }
}
