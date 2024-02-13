import 'package:flutter/material.dart';

import '../../../../core/helper/dpi_helper.dart';

import '../../../../core/theme/styles.dart';

class HomeLoadingWidget extends StatelessWidget {
  const HomeLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: fixDpiScreenHeight() * 0.8,
      width: fixDpiScreenWidth(),
      child: const Center(
        child: CircularProgressIndicator(
          color: Styles.primaryColor,
        ),
      ),
    );
  }
}
