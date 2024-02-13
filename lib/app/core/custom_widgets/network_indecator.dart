import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/home_showcase/views/widgets/home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NetworkIndicator extends StatefulWidget {
  final Widget child;

  const NetworkIndicator({super.key, required this.child});
  @override
  NetworkIndicatorState createState() => NetworkIndicatorState();
}

class NetworkIndicatorState extends State<NetworkIndicator> {
  Widget _buildBodyItem() {
    return SafeArea(
      child: SizedBox(
        height: fixDpiScreenHeight(),
        width: fixDpiScreenWidth(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.signal_wifi_off,
              size: fixDpiScreenHeight() * 0.20,
              color: Styles.primaryColor,
            ),
            Container(
                margin: EdgeInsets.only(top: 10.h),
                child: Text(
                  AppStrings.noInternet.tr,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'baloo'),
                )),
            Container(
              margin: EdgeInsets.only(top: fixDpiScreenHeight() * 0.04),
              child: Text(
                AppStrings.checkRouter.tr,
                style: Styles.getRegularStyle(
                  color: Styles.grey_600,
                  fontSize: fixDpiFont(18),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: fixDpiScreenHeight() * 0.04),
              child: Text(
                AppStrings.tryAgain.tr,
                style: Styles.getRegularStyle(
                  color: Styles.grey_600,
                  fontSize: fixDpiFont(18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (
        BuildContext context,
        ConnectivityResult connectivity,
        Widget child,
      ) {
        if (connectivity == ConnectivityResult.none) {
          return Scaffold(
            appBar: const HomeAppBar(),
            body: _buildBodyItem(),
          );
        } else {
          return child;
        }
      },
      builder: (BuildContext context) {
        return widget.child;
      },
    );
  }
}
