
import 'package:flutter/material.dart';
import 'package:mortuary/core/widgets/custom_shimmer_widget.dart';

extension WidgetsExtensions on Widget {
  Widget wrapWithLoading(ValueNotifier<bool> valueNotifier) {
    return ValueListenableBuilder<bool>(
      valueListenable: valueNotifier,
      builder: (_, loading, __) {
        return loading
            ? const Center(
          child: CircularProgressIndicator.adaptive(),
        )
            : this;
      },
    );
  }
  Widget wrapWithLoadingBool(bool valueNotifier) {
    return valueNotifier
        ? const Center(
      child: CircularProgressIndicator.adaptive(),
    )
        : this;
  }

  Widget wrapWithListViewSkeleton(bool valueNotifier) {
    return valueNotifier
        ? Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Center(
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true, // Add this line
          primary: false,   // Add this line
          itemBuilder: (context, index) {
            return const CustomShimmer(height: 100);
          },
          itemCount: 10,
        ),
      ),
    )
        : this;
  }
}