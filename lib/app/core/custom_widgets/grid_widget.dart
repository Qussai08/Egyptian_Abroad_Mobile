import 'package:egyptians_abroad/app/core/custom_widgets/image_placeholder.dart';
import 'package:egyptians_abroad/app/core/helper/app_helper.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/services/models/category.dart';
import 'package:egyptians_abroad/app/core/services/models/service.dart';
import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/category/views/category_view.dart';
import 'package:egyptians_abroad/app/modules/home_showcase/views/widgets/favorite_button.dart';
import 'package:egyptians_abroad/app/modules/start_service/controllers/start_service_controller.dart';
import 'package:egyptians_abroad/app/modules/start_service/views/service_content_view.dart';
import 'package:egyptians_abroad/app/modules/start_service/views/start_service_redirect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class GridWidget extends GetView<StartServiceController> {
  final int widgetTag;
  final Category? category;
  final ServiceItem? serviceItem;
  final bool? inFavList;

  const GridWidget(
    this.widgetTag, {
    this.category,
    this.serviceItem,
    this.inFavList = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isService = serviceItem != null ? true : false;
    bool isNotPng;
    if (isService) {
      serviceItem!.servicesIcon != null
          ? serviceItem!.servicesIcon!.split('.').last.toLowerCase() != 'png'
              ? isNotPng = true
              : isNotPng = false
          : isNotPng = false;
    } else {
      category!.imagePath != null
          ? category!.imagePath!.split('.').last.toLowerCase() != 'png'
              ? isNotPng = true
              : isNotPng = false
          : isNotPng = false;
    }
    return GestureDetector(
      onTap: () async {
        print("widgetTag $widgetTag");
        print("category id ${category!.id}");
        print("serviceItem $serviceItem");
        print("inFavList $inFavList");

        if (isService) {
          var serviceContent =
              await controller.getServicesContent(serviceItem!.serviceId);

          Get.to(() {
            print("serviceItemIcon ${serviceItem!.servicesIcon}");

            print("ImagePath ${category!.categoryIcon!}");
            return serviceContent!.servicesType! == ServiceType.content
                ? ServiceContentView(
                    serviceItem: serviceItem,
                    serviceContent: serviceContent,
                    category: category,
                    iconIsPNG: !isNotPng,
                  )
                : StartServiceRedir(
                    serviceContent: serviceContent,
                    category: category,
                  );
          });
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
                category: category,
              ));
          // Get.toNamed(Routes.CATEGORY);
        }
      },
      child: GridTile(
        child: Hero(
            tag: Text('$widgetTag'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  color: Colors.transparent,
                  width: fixDpiWidth(82),
                  height: fixDpiHeight(82),
                  child: ClipRRect(
                      // borderRadius: BorderRadius.circular(15.0),
                      child: Stack(
                    children: [
                      isNotPng
                          ? SvgPicture.network(
                              (isService
                                      ? serviceItem!.servicesIcon
                                      : category!.imagePath) ??
                                  AppImages.imagePlaceHolder,
                              placeholderBuilder: (context) =>
                                  ImagePlaceholder(),
                            )
                          : Image.network(
                              (isService
                                      ? serviceItem!.servicesIcon
                                      : category!.imagePath) ??
                                  AppImages.imagePlaceHolder,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return ImagePlaceholder();
                              },
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(AppImages.imagePlaceHolder),
                            ),
                      isService
                          ? Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              child: inFavList!
                                  ? !serviceItem!.isFixedFavorite
                                      ? FavoriteButton(
                                          isFavorite: true,
                                          onTap: () async {
                                            await controller
                                                .removeFromFavoriteInHome(
                                                    serviceItem!);
                                          },
                                        )
                                      : Container()
                                  :

                                  /// for the services list

                                  !serviceItem!.isFixedFavorite
                                      ? Obx(() {
                                          return FavoriteButton(
                                            isFavorite:
                                                serviceItem!.isMyFavorite(),
                                            onTap: () async {
                                              print(
                                                  "serviceItem!.categoryId ${serviceItem!.categoryId}");
                                              await controller
                                                  .handleFavorite(serviceItem!);
                                            },
                                          );
                                        })
                                      : Container())
                          : Container(),
                    ],
                  )),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Expanded(
                  // fix overflow on english text
                  child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 100.w,
                      height: 50.h,
                      child: Text(
                        isService
                            ? serviceItem!.serviceName
                            : category!.categoryName,
                        maxLines: 2,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
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
