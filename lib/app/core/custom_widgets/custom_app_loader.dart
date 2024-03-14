import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:flutter/material.dart';

class CustomAppLoader extends StatelessWidget {
  const CustomAppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: fixDpiScreenHeight(),
      width: fixDpiScreenWidth(),
      color: Styles.lightBlack,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
