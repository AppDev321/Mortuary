import 'package:flutter/material.dart';
import 'package:mortuary/core/styles/colors.dart';

/// Widget that renders a [Button] with transparent or fill background
/// Exposes [onPressed] function
class ButtonWidget extends StatefulWidget {
  final void Function()? onPressed;
  final String text;
  final TextStyle? textStyle;
  final Color? color;
  final EdgeInsetsGeometry margin;
  final bool isLoading;
  final ButtonType buttonType;
  final dynamic icon;
  final double height;
  double? width;
  final double radius;
  final bool expand;

   ButtonWidget(
      {Key? key,
      this.onPressed,
      required this.text,
      this.textStyle,
      this.color,
      this.margin = EdgeInsets.zero,
      required this.buttonType,
      this.isLoading = false,
      this.icon,
      this.width,
      this.expand = true,
      this.radius = 30.0,
      this.height = 50.0})
      : super(key: key);

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  // LoadingState buttonLoadingState = LoadingState.loaded;

  // bool get isButtonLoadingState => buttonLoadingState == LoadingState.loading;

  @override
  Widget build(BuildContext context) {

    widget.width ??= MediaQuery.of(context).size.width * 0.78;

    final buttonStyle = ButtonStyle(
      elevation: MaterialStateProperty.all<double>(0),
      backgroundColor: MaterialStateProperty.all(getBackgroundColor()),
      foregroundColor: MaterialStateProperty.all(getForegroundColor()),
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return widget.color ?? Theme.of(context).colorScheme.primary.withOpacity(0.5); // Set the overlay color for pressed state
          }
          return null; // Return null for other states
        }),
      side: MaterialStateProperty.all(
        BorderSide(
            color: widget.color ?? Theme.of(context).colorScheme.primary),
      ),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
        side: BorderSide(color: Theme.of(context).colorScheme.primary),
        borderRadius: BorderRadius.circular(widget.radius),
      )),
    );

    return Container(
      height: widget.height,
      margin: widget.margin,
      width: widget.width,
      decoration: widget.buttonType == ButtonType.gradient
          ? BoxDecoration(gradient: buttonGradientColor,borderRadius:BorderRadius.circular(widget.radius) )
          : null,
      child: ElevatedButton.icon(
        icon: widget.icon ?? const SizedBox(),
        style:
        buttonStyle,
        onPressed: () async {
          if (widget.onPressed != null) {
            widget.onPressed!();
          }
        },
        label: widget.isLoading
            ? SizedBox(
          height: 30.0,
          width: 30.0,
          child: CircularProgressIndicator(
            color: getProgressIndicatorColor(),
          ),
        )
            : Text(
          widget.text,
          style: widget.textStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  getForegroundColor() {
    return   widget.buttonType == ButtonType.fill || widget.buttonType == ButtonType.gradient
        ? Colors.white
        : widget.color ?? Colors.black;
  }

  getBackgroundColor() {
    return  widget.buttonType == ButtonType.gradient|| widget.buttonType == ButtonType.transparent
            ? Colors.transparent
            : widget.buttonType == ButtonType.white
                ? Colors.transparent
                : widget.buttonType == ButtonType.fill
                    ? widget.color ?? Theme.of(context).colorScheme.primary
                    : Colors.white;
  }

  getProgressIndicatorColor() {
    return widget.buttonType == ButtonType.fill
        ? Colors.white
        : (widget.color ?? AppColors.primaryColor);
  }

  var buttonGradientColor = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF72AB66),
      Color(0xFF31634D),
    ],
  );
}

enum ButtonType { transparent, fill, white, gradient }
