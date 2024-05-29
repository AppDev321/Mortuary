import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mortuary/core/constants/app_strings.dart';
import 'package:mortuary/core/constants/place_holders.dart';
import 'package:mortuary/core/widgets/custom_text_widget.dart';
import 'package:mortuary/features/splash/domain/entities/splash_model.dart';

import '../../core/styles/colors.dart';
import './country.dart';
import 'country_code_picker.dart';

///This function returns list of countries
Future<List<Country>> getCountries(BuildContext context) async {
  String rawData = await DefaultAssetBundle.of(context).loadString(
      'assets/raw/country_codes.json');
  final parsed = json.decode(rawData.toString()).cast<Map<String, dynamic>>();
  return parsed.map<Country>((json) =>  Country.fromJson(json)).toList();
}



///This function returns an country whose [countryCode] matches with the passed one.
Future<Country?> getCountryByCountryCode(
    BuildContext context, String countryCode) async {
  final list = await getCountries(context);
  return list.firstWhere((element) => element.countryCode == countryCode);
}

Future<dynamic> showCountryPickerSheet(BuildContext context,
    {Widget? title,
    Widget? cancelWidget,
    double cornerRadius = 35,
    bool focusSearchBox= false,
    double heightFactor= 0.9,
    bool isFromApi = false,
      List<RadioOption>? countryApiList
    }) {
  assert(heightFactor <= 0.9 && heightFactor >= 0.4,
      'heightFactor must be between 0.4 and 0.9');
  return showModalBottomSheet<dynamic>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(cornerRadius),
              topRight: Radius.circular(cornerRadius))),
      builder: (_) {
        return Container(
          height: MediaQuery.of(context).size.height * heightFactor,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(cornerRadius),
                  topRight: Radius.circular(cornerRadius))),

          child: Column(
            children: <Widget>[
              sizeFieldMediumPlaceHolder,
              Stack(
                children: <Widget>[
                  cancelWidget ??
                      const Positioned(
                        right: 8,
                        top: 4,
                        bottom: 0,
                        child: SizedBox(),
                        // child: TextButton(
                        //     child: Text('Cancel'),
                        //     onPressed: () => Navigator.pop(context)),
                      ),
                  Center(
                    child: title ??
                        const CustomTextWidget(
                          text:AppStrings.chooseCountry,
                         size: 20,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
           sizeFieldMediumPlaceHolder,
              Expanded(
                child: CountryPickerWidget(
                  isFromApi: isFromApi ,
                  countryApiList:countryApiList,
                  onSelected: (country) => Navigator.of(context).pop(country),
                ),
              ),
            ],
          ),
        );
      });
}

Future<Country?> showCountryPickerDialog(
  BuildContext context, {
  Widget? title,
  double cornerRadius= 35,
  bool focusSearchBox= false,
}) {
  return showDialog<Country?>(
      context: context,
      barrierDismissible: true,
      builder: (_) => Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(cornerRadius),
            )),
            child: Column(
              children: <Widget>[
                sizeFieldMediumPlaceHolder,
                Stack(
                  children: <Widget>[
                    Positioned(
                      right: 8,
                      top: 4,
                      bottom: 0,
                      child: TextButton(
                          child: const Text('Cancel'),
                          onPressed: () => Navigator.pop(context)),
                    ),
                    Center(
                      child: title ??
                          const CustomTextWidget(
                            text:AppStrings.chooseCountry,
                            size: 20,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
                sizeFieldMediumPlaceHolder,
                Expanded(
                  child: CountryPickerWidget(
                    onSelected: (country) => Navigator.of(context).pop(country),
                  ),
                ),
              ],
            ),
          ));
}
