import 'package:flutter/material.dart';

import '../error/errors.dart';
import 'error_widget.dart';

class ErrorScaffold extends StatelessWidget {
  final Future Function()? reStart;
  final CustomError? customError;
  final Icon? icon;
  final String? text;
  const ErrorScaffold({
    this.text = 'Refresh',
    this.icon,
    required this.reStart,
    required this.customError,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomErrorWidget(
          customError: customError!,
          icon: icon ?? const Icon(Icons.refresh),
          text: text,
          reStart: reStart,
        ),
      ],
    ));
  }
}
