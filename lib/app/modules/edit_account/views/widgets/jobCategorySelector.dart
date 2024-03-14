import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/registration/data/models/job_category.dart';
import 'package:flutter/material.dart';
import 'jobCategorySearchList.dart';

/// [SelectorButton]
class JobCategorySelectorButton extends StatelessWidget {
  final List<JobCategory> jobCategories;
  final int? selectedCat;
  final TextStyle? selectorTextStyle;
  final InputDecoration? searchBoxDecoration;
  final bool autoFocusSearchField;
  final String? locale;
  final bool isEnabled;
  final bool isScrollControlled;

  final ValueChanged<int?> onChanged;

  const JobCategorySelectorButton({
    super.key,
    required this.jobCategories,
    required this.selectedCat,
    required this.selectorTextStyle,
    required this.searchBoxDecoration,
    required this.autoFocusSearchField,
    required this.locale,
    required this.onChanged,
    required this.isEnabled,
    required this.isScrollControlled,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      key: const Key('intl_dropdown_key'),
      padding: EdgeInsets.zero,
      minWidth: 0,
      onPressed: jobCategories.isNotEmpty &&
              jobCategories.length > 1 &&
              isEnabled
          ? () async {
              JobCategory? selected;

              selected =
                  await showCategorySelectorBottomSheet(context, jobCategories);

              if (selected != null) {
                onChanged(jobCategories
                    .indexWhere((element) => element.id == selected!.id));
              }
            }
          : null,
      child: selectedCat != null
          ? Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    jobCategories
                        .firstWhere((element) => element.id == selectedCat)
                        .name,
                    style: Styles.getRegularStyle(color: Styles.black),
                  ),
                ],
              ),
            )
          : Container(),
    );
  }

  Future<JobCategory?> showCategorySelectorBottomSheet(
      BuildContext context, List<JobCategory> cats) {
    return showModalBottomSheet(
      context: context,
      clipBehavior: Clip.hardEdge,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      builder: (BuildContext context) {
        return Stack(children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
          ),
          DraggableScrollableSheet(
            builder: (BuildContext context, ScrollController controller) {
              return Container(
                decoration: const ShapeDecoration(
                  color: Styles.backgroundColor,
                  // Theme.of(context).canvasColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                ),
                child: CategoriesSearchListWidget(
                  cats,
                  locale,
                  searchBoxDecoration: searchBoxDecoration,
                  scrollController: controller,
                  showFlags: true,
                  // useEmoji: selectorConfig.useEmoji,
                  autoFocus: autoFocusSearchField,
                ),
              );
            },
          ),
        ]);
      },
    );
  }
}
