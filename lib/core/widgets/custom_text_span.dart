import 'package:flutter/material.dart';

class CustomTextSpan extends StatelessWidget {
  final String firstText;
  final String secondText;
  final TextStyle? textStyleFirst;
  final TextStyle? textStyle;
  final void Function()? onTap;
  TextAlign? textAlign;

  CustomTextSpan(
      {super.key,
      required this.firstText,
      required this.secondText,
      this.textStyleFirst,
      this.textStyle,
      this.textAlign,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
        // textAlign: TextAlign.center,
        TextSpan(text: firstText, style: textStyleFirst, children: <InlineSpan>[
      WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: GestureDetector(
          onTap: onTap,

          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(

              textAlign: textAlign,
              secondText,
              style: textStyle,
            ),
          ),
        ),
      ),
    ]));
  }
}
