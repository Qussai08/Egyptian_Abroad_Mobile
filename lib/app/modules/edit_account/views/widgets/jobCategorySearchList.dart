// ignore_for_file: library_private_types_in_public_api, prefer_final_fields

import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/registration/data/models/country.dart';
import 'package:egyptians_abroad/app/modules/registration/data/models/job_category.dart';
import 'package:flutter/material.dart';

/// Creates a list of Countries with a search textfield.
class CategoriesSearchListWidget extends StatefulWidget {
  final List<JobCategory> cats;
  final InputDecoration? searchBoxDecoration;
  final String? locale;
  final ScrollController? scrollController;
  final bool autoFocus;
  final bool? showFlags;
  final bool? useEmoji;
  final bool isCountrySearch;

  const CategoriesSearchListWidget(this.cats, this.locale,
      {super.key,
      this.searchBoxDecoration,
      this.scrollController,
      this.showFlags,
      this.useEmoji,
      this.autoFocus = false,
      this.isCountrySearch = true});

  @override
  _CategoriesSearchListWidgetState createState() =>
      _CategoriesSearchListWidgetState();
}

class _CategoriesSearchListWidgetState
    extends State<CategoriesSearchListWidget> {
  TextEditingController _searchController = TextEditingController();
  late List<JobCategory> filteredCats;

  @override
  void initState() {
    filteredCats = filterCats();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Returns [InputDecoration] of the search box
  InputDecoration getSearchBoxDecoration() {
    return widget.searchBoxDecoration ??
        InputDecoration(
            border: InputBorder.none,
            prefixIcon: const Icon(
              Icons.search,
              color: Styles.ghostGrey,
              size: 20.0,
            ),
            labelStyle: Styles.getRegularStyle(color: Styles.ghostGrey),
            labelText: 'البحث بالمهنة');
  }

  /// Filters the list of Country by text from the search box.
  List<JobCategory> filterCats() {
    final value = _searchController.text.trim();

    if (value.isNotEmpty) {
      return widget.cats
          .where((JobCategory cat) =>
                  cat.name.toLowerCase().contains(value.toLowerCase())
              // ||
              // getCountryName(country)!
              //     .toLowerCase()
              //     .contains(value.toLowerCase()) ||
              // country.dialCode!.contains(value.toLowerCase()),
              )
          .toList();
    }

    return widget.cats;
  }

  /// Returns the country name of a [Country]. if the locale is set and translation in available.
  /// returns the translated name.
  // String? getCountryName(Country country) {
  //   if (widget.locale != null && country.nameTranslations != null) {
  //     String? translated = country.nameTranslations![widget.locale!];
  //     if (translated != null && translated.isNotEmpty) {
  //       return translated;
  //     }
  //   }
  //   return country.name;
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 16, right: 16),
          child: TextFormField(
            key: const Key('intl_search_input_key'),
            decoration: getSearchBoxDecoration(),
            controller: _searchController,
            autofocus: widget.autoFocus,
            onChanged: (value) => setState(() => filteredCats = filterCats()),
          ),
        ),
        const Divider(indent: 16, endIndent: 16, color: Styles.ghostGrey),
        Flexible(
          child: ListView.builder(
            controller: widget.scrollController,
            shrinkWrap: true,
            itemCount: filteredCats.length,
            itemBuilder: (BuildContext context, int index) {
              JobCategory cat = filteredCats[index];
              return ListTile(
                key: Key('intl_country_${cat.id.toString().toUpperCase()}_key'),
                title: Align(
                  alignment: AlignmentDirectional.centerStart,
                  // child: Text('${getCountryName(country)}',textAlign: TextAlign.start),
                  child: Text(cat.name,
                      style: Styles.getLightStyle(color: Styles.black),
                      textAlign: TextAlign.start),
                ),
                onTap: () => Navigator.of(context).pop(cat),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
}
