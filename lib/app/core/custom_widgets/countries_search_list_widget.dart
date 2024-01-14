// ignore_for_file: library_private_types_in_public_api, prefer_final_fields

import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/registration/data/models/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Creates a list of Countries with a search textfield.
class CountrySearchListWidget extends StatefulWidget {
  final List<Country> countries;
  final InputDecoration? searchBoxDecoration;
  final String? locale;
  final ScrollController? scrollController;
  final bool autoFocus;
  final bool? showFlags;
  final bool? useEmoji;

  const CountrySearchListWidget(this.countries, this.locale,
      {super.key,
      this.searchBoxDecoration,
      this.scrollController,
      this.showFlags,
      this.useEmoji,
      this.autoFocus = false});

  @override
  _CountrySearchListWidgetState createState() =>
      _CountrySearchListWidgetState();
}

class _CountrySearchListWidgetState extends State<CountrySearchListWidget> {
  TextEditingController _searchController = TextEditingController();
  late List<Country> filteredCountries;

  @override
  void initState() {
    filteredCountries = filterCountries();
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
            labelText: 'البحث باسم الدولة');
  }

  /// Filters the list of Country by text from the search box.
  List<Country> filterCountries() {
    final value = _searchController.text.trim();

    if (value.isNotEmpty) {
      return widget.countries
          .where((Country country) =>
                  country.country.toLowerCase().contains(value.toLowerCase())
              // ||
              // getCountryName(country)!
              //     .toLowerCase()
              //     .contains(value.toLowerCase()) ||
              // country.dialCode!.contains(value.toLowerCase()),
              )
          .toList();
    }

    return widget.countries;
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
            onChanged: (value) =>
                setState(() => filteredCountries = filterCountries()),
          ),
        ),
        const Divider(indent: 16, endIndent: 16, color: Styles.ghostGrey),
        Flexible(
          child: ListView.builder(
            controller: widget.scrollController,
            shrinkWrap: true,
            itemCount: filteredCountries.length,
            itemBuilder: (BuildContext context, int index) {
              Country country = filteredCountries[index];
              return ListTile(
                key: Key(
                    'intl_country_${country.id.toString().toUpperCase()}_key'),
                leading: widget.showFlags!
                    ? Image.network(
                        country.flag,
                        width: 25.w,
                      )
                    : null,
                title: Align(
                  alignment: AlignmentDirectional.centerStart,
                  // child: Text('${getCountryName(country)}',textAlign: TextAlign.start),
                  child: Text(country.country,
                      style: Styles.getLightStyle(color: Styles.black),
                      textAlign: TextAlign.start),
                ),
                onTap: () => Navigator.of(context).pop(country),
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
