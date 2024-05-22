import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer(
      {super.key,
      this.height = double.maxFinite,
      this.width = double.maxFinite,
      this.margin,
      this.radius});

  final double? height;
  final double? width;
  final double? radius;
  final EdgeInsetsGeometry? margin;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 12.0)),
        ),
      ),
    );
  }
}
