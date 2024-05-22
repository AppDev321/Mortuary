import 'package:cupertino_will_pop_scope/cupertino_will_pop_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

OutlineInputBorder inputBorder = OutlineInputBorder(
    borderSide: BorderSide(width: 1, color: AppColors.primaryColor),
    borderRadius: BorderRadius.circular(15.0));

OutlineInputBorder errorInputBorder = OutlineInputBorder(
    borderSide: const BorderSide(width: 1, color: Colors.red),
    borderRadius: BorderRadius.circular(15.0));

class AppTheme {
  static ThemeData lightTheme(context) {
    return ThemeData(
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
         TargetPlatform.iOS: CupertinoWillPopScopePageTransionsBuilder(),
        },
      ),
      iconButtonTheme: IconButtonThemeData(style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.white)
      )),

      appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppColors.primaryColor,
          ),
          centerTitle: false,
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: Theme.of(context)
              .appBarTheme
              .titleTextStyle
              ?.copyWith(color: Colors.white),
          actionsIconTheme: const IconThemeData(color: Colors.white)),
      snackBarTheme: SnackBarThemeData(
          backgroundColor: AppColors.primaryColor,
          contentTextStyle: TextStyle(
              fontSize: Theme.of(context).textTheme.titleMedium!.fontSize)),
      bottomSheetTheme: const BottomSheetThemeData(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
        topLeft: Radius.circular(14.0),
        topRight: Radius.circular(14.0),
      ))),
      disabledColor: Colors.grey,
      inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(
              fontSize: Theme.of(context).textTheme.bodySmall!.fontSize!,
              color: Colors.black.withOpacity(.4)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          errorStyle: const TextStyle(height: 0.0),
          enabledBorder: inputBorder,
          disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.zero),
          focusedBorder: inputBorder,
          errorBorder: errorInputBorder,
          focusedErrorBorder: errorInputBorder,
          suffixIconColor: AppColors.primaryColor),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryColor),
      hintColor: AppColors.primaryColor,
      textTheme: Theme.of(context).textTheme.apply(
            bodyColor: Colors.black,
            displayColor: AppColors.primaryColor,
            fontFamily: "Poppins",
          ),
      // dropdownMenuTheme: DropdownMenuThemeData(
      //     menuStyle: MenuStyle(backgroundColor: )),
      iconTheme: IconThemeData(color: AppColors.primaryColor),
      primaryColor: AppColors.primaryColor,
      colorScheme:
          ColorScheme.fromSwatch(primarySwatch: AppColors.primarySwatch)
              .copyWith(secondary: AppColors.primaryColor),
    );
  }
}
