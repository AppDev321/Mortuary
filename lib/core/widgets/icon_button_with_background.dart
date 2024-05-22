import 'package:flutter/material.dart';

class IconButtonBackground extends StatelessWidget {
  const IconButtonBackground({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
  }) : super(key: key);

  final Icon icon;
  final Function() onPressed;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white, shape: BoxShape.circle),
      child: IconButton(
        icon: icon,
        onPressed: onPressed,
      ),
    );
  }
}
