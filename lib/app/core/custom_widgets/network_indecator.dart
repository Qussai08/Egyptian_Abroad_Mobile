import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/home/views/widgets/home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
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
      child: Container(
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
                margin: const EdgeInsets.only(top: 10),
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
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                      fontFamily: 'baloo'),
                )),
            Container(
                margin: EdgeInsets.only(top: fixDpiScreenHeight() * 0.04),
                child: Text(
                  AppStrings.tryAgain.tr,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                      fontFamily: 'baloo'),
                )),
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
            appBar: HomeAppBar(),
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
