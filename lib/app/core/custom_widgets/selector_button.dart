import 'package:egyptians_abroad/app/core/custom_widgets/countries_search_list_widget.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/registration/data/models/country.dart';
import 'package:flutter/material.dart';

/// [SelectorButton]
class SelectorButton extends StatelessWidget {
  final List<Country> countries;
  final int? selectedCountry;
  final TextStyle? selectorTextStyle;
  final InputDecoration? searchBoxDecoration;
  final bool autoFocusSearchField;
  final String? locale;
  final bool isEnabled;
  final bool isScrollControlled;

  final ValueChanged<int?> onCountryChanged;

  const SelectorButton({
    super.key,
    required this.countries,
    required this.selectedCountry,
    required this.selectorTextStyle,
    required this.searchBoxDecoration,
    required this.autoFocusSearchField,
    required this.locale,
    required this.onCountryChanged,
    required this.isEnabled,
    required this.isScrollControlled,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      key: const Key('intl_dropdown_key'),
      padding: EdgeInsets.zero,
      minWidth: 0,
      onPressed: countries.isNotEmpty && countries.length > 1 && isEnabled
          ? () async {
              Country? selected;

              selected =
                  await showCountrySelectorBottomSheet(context, countries);

              if (selected != null) {
                onCountryChanged(countries
                    .indexWhere((element) => element.id == selected!.id));
              }
            }
          : null,
      child: selectedCountry != null
          ? Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                children: [
                  Image.network(
                    countries[selectedCountry!].flag,
                    width: 21,
                    height: 15,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    countries[selectedCountry!].country,
                    style: Styles.getRegularStyle(color: Styles.black),
                  ),
                ],
              ),
            )
          : Container(),
    );
  }

  Future<Country?> showCountrySelectorBottomSheet(
      BuildContext context, List<Country> countries) {
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
                child: CountrySearchListWidget(
                  countries,
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
