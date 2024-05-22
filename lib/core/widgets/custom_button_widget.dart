import 'package:flutter/material.dart';

import 'custom_text_widget.dart';


class CustomButtonWidget extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final TextStyle? textStyle;
  final Color? borderColor;
  final EdgeInsetsGeometry margin;
  final bool isLoading;

  final Icon? icon;
  final double height;
  final double? width;
  final double radius;
  final bool expand;

  const CustomButtonWidget(
      {Key? key,
      this.onPressed,
      required this.text,
      this.textStyle,
      this.borderColor,
      this.margin = EdgeInsets.zero,
      this.isLoading = false,
      this.icon,
      this.width,
      this.expand = true,
      this.radius = 12.0,
      this.height = 45.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
        ),
        height: height,
        margin: margin,
        width: width,
        //   width: width ?? (expand ? double.infinity : null),
        child: MaterialButton(
          color: borderColor,
          onPressed: onPressed,
          child: CustomTextWidget(text: text),
        ));
  }
}
