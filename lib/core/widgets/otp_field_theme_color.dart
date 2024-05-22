import 'package:flutter/material.dart';

class OtpFieldThemeColor extends StatelessWidget {
  Widget child;

  OtpFieldThemeColor({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
              errorBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              outlineBorder: BorderSide.none,
              enabledBorder: InputBorder.none,
              border: InputBorder.none)),
      child: child,
    );
  }
}
