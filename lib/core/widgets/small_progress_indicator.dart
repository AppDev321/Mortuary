import 'package:flutter/material.dart';

class SmallProgressIndicator extends StatelessWidget {
  const SmallProgressIndicator(
      {Key? key, this.color, this.size = 20.0, this.strokeWidth})
      : super(key: key);

  final double? size;
  final Color? color;
  final double? strokeWidth;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          color: color,
          strokeWidth: strokeWidth ?? 2.0,
        ));
  }
}
