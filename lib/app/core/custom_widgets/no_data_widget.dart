import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  final String message;
  final double iconSize;
  final Color? color;

  const NoDataWidget(
      {Key? key,
      required this.message,
      this.iconSize = 100,
      this.color = Styles.primaryColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Icon(
          Icons.not_interested,
          size: iconSize,
          color: color,
        ),
        Container(
          margin: const EdgeInsets.only(top: 15),
          child: Text(
            message,
            style: Styles.getSemiBoldStyle(
                color: Styles.black, fontSize: fixDpiFont(18)),
          ),
        ),
      ],
    ));
  }
}
