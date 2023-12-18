import 'package:egyptians_abroad/app/core/helper/app_helper.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/services/models/category.dart';
import 'package:egyptians_abroad/app/core/services/models/service.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/category/views/category_view.dart';
import 'package:egyptians_abroad/app/modules/start_service/controllers/start_service_controller.dart';
import 'package:egyptians_abroad/app/modules/start_service/views/service_content_view.dart';
import 'package:egyptians_abroad/app/modules/start_service/views/start_service_redirect.dart';
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
    final controller = Get.put(StartServiceController());

    return GestureDetector(
      onTap: () async {
        if (isService) {
          var serviceContent = await controller
              .getServicesContent(widget.serviceItem!.serviceId);

          Get.to(() => serviceContent!.servicesType! == ServiceType.content
              ? ServiceContentView(
                  serviceContent: serviceContent,
                  category: widget.category,
                )
              : StartServiceRedir(
                  serviceContent: serviceContent,
                  category: widget.category,
                ));
          //     : ServiceContentView(
          //         category: widget.category,
          //         serviceContent: serviceContent,
          //       ));
          // Get.to(() => StartServiceRedir(
          //       category: widget.category,
          //       serviceContent: serviceContent,
          //     ));
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
                Container(
                  color: Colors.transparent,
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
                Expanded(
                  // fix overflow on english text
                  child: Align(
                    alignment: Alignment.center,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        isService
                            ? widget.serviceItem!.serviceName
                            : widget.category!.categoryName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Styles.getLightStyle(
                            color: Colors.black, fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
