import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/services/models/category.dart';
import 'package:egyptians_abroad/app/core/services/models/service.dart';
import 'package:egyptians_abroad/app/modules/category/views/category_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GridWidget extends StatefulWidget {
  final int tag;
  final Category? category;
  final ServiceItem? serviceItem;

  const GridWidget(this.tag, {this.category, this.serviceItem, super.key});

  @override
  _GridWidgetState createState() => _GridWidgetState();
}

class _GridWidgetState extends State<GridWidget> {
  @override
  Widget build(BuildContext context) {
    bool isService = widget.serviceItem != null ? true : false;
    return GestureDetector(
      onTap: () {
        if (isService) {
        } else {
          Get.to(() => CategoryView(
                category: widget.category,
              ));
          // Get.toNamed(Routes.CATEGORY);
        }
      },
      child: GridTile(
        child: Hero(
            tag: Text('${widget.tag}'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: fixDpiWidth(82),
                  height: fixDpiHeight(82),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(isService
                          ? widget.serviceItem!.servicesIcon ??
                              "https://www.kuleuven.be/communicatie/congresbureau/fotos-en-afbeeldingen/no-image.png/image"
                          : widget.category!.imagePath ??
                              "https://www.kuleuven.be/communicatie/congresbureau/fotos-en-afbeeldingen/no-image.png/image")),
                ),
                const SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.center,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                        isService
                            ? widget.serviceItem!.serviceName
                            : widget.category!.categoryName,
                        maxLines: 2,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'baloo')),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
