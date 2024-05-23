import 'dart:core';

import 'package:flutter/material.dart';

import '../../constants/app_strings.dart';
import '../../styles/colors.dart';

/// This is built for displaying error and success messages based on the
/// API response, and if any action is to be performed based on a particular response,
/// then prefer using [ChoiceBottomSheet] in [showModalBottomSheet]
class ChoiceDialog extends StatelessWidget {
  const ChoiceDialog(
      {Key? key,
      this.title = AppStrings.titleText,
      this.message = AppStrings.messageText,
      this.firstChoice = AppStrings.yesText,
      this.secondChoice = AppStrings.noText,
      required this.firstOnPressed,
      this.secondOnPressed})
      : super(key: key);
  final String title;
  final String message;
  final String firstChoice;
  final String? secondChoice;
  final Function() firstOnPressed;
  final Function()? secondOnPressed;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      clipBehavior: Clip.hardEdge,
      child: Container(
        padding: const EdgeInsets.only(top: 16.0, bottom: 0.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              //  AppPlaceHolders.sizeFieldSmallPlaceHolder,
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.blackColor,
                    fontSize:
                        Theme.of(context).textTheme.titleMedium!.fontSize!,
                    fontWeight: FontWeight.bold),
              ),
              //AppPlaceHolders.sizeFieldLargePlaceHolder,
              const SizedBox(
                height: 15.0,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  maxLines: 7,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    height: 1.4,
                    color: AppColors.blackColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              //  AppPlaceHolders.sizeFieldLargePlaceHolder,
              SizedBox(
                height: 50.0,
                child: TextButton(
                  style: getButtonStyles(0),
                  onPressed: firstOnPressed,
                  child: Text(firstChoice,
                      style: const TextStyle(
                        color: AppColors.blackColor,
                      )),
                ),
              ),
              if (secondOnPressed != null)
                SizedBox(
                  height: 50.0,
                  child: TextButton(
                    style: getButtonStyles(1),
                    onPressed: secondOnPressed,
                    child: Text(secondChoice!),
                  ),
                ),
            ]),
      ),
    );
  }

  getButtonStyles(int index) {
    return ButtonStyle(
        elevation: index == 0 ? MaterialStateProperty.all<double>(0) : null,
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        foregroundColor: MaterialStateProperty.all(AppColors.primaryColor),
        textStyle: MaterialStateProperty.all(
            const TextStyle(fontWeight: FontWeight.bold)),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
        side: index == 0
            ? MaterialStateProperty.all(BorderSide(
                color: AppColors.primaryColor,
              ))
            : null);
  }
}
