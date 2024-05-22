/// Widget that renders a [Button] with transparent or fill background
/// Exposes [onPressed] function
// class ButtonWidget extends StatefulWidget {
//   Future Function()? onPressed;
//   final String text;
//   final TextStyle? textStyle;
//   final Color? color;
//   final EdgeInsetsGeometry margin;
//   final bool isLoading;
//   final ButtonType buttonType;
//   final Icon? icon;
//   final double height;
//   final double? width;
//   final double radius;
//   final bool expand;
//
//   ButtonWidget(
//       {Key? key,
//       this.onPressed,
//       required this.text,
//       this.textStyle,
//       this.color,
//       this.margin = EdgeInsets.zero,
//       required this.buttonType,
//       this.isLoading = false,
//       this.icon,
//       this.width,
//       this.expand = true,
//       this.radius = 12.0,
//       this.height = 50.0})
//       : super(key: key);
//
//   @override
//   State<ButtonWidget> createState() => _ButtonWidgetState();
// }
//
// class _ButtonWidgetState extends State<ButtonWidget> {
//   LoadingState buttonLoadingState = LoadingState.loaded;
//
//   bool get isButtonLoadingState => buttonLoadingState == LoadingState.loading;
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     final buttonStyle = ButtonStyle(
//         elevation: MaterialStateProperty.all<double>(0),
//         backgroundColor: MaterialStateProperty.all(getBackgroundColor()),
//         foregroundColor: MaterialStateProperty.all(getForegroundColor()),
//         side: MaterialStateProperty.all(
//           BorderSide(color: widget.color ?? Theme.of(context).colorScheme.primary),
//         ),
//         shape: MaterialStateProperty.all(RoundedRectangleBorder(
//           side:  BorderSide(color: AppColors.primaryColor),
//           borderRadius: BorderRadius.circular(widget.radius),
//         )));
//
//     return Container(
//         height: widget.height,
//         margin: widget.margin,
//         width: widget.width,
//         //   width: width ?? (expand ? double.infinity : null),
//         child: ElevatedButton.icon(
//           icon: widget.icon ?? const SizedBox(),
//           style: buttonStyle,
//           onPressed: () async {
//             setState(() {
//               buttonLoadingState = LoadingState.loading;
//             });
//
//             await widget.onPressed!();
//
//             setState(() {
//               buttonLoadingState = LoadingState.loaded;
//             });
//           },
//           label: isButtonLoadingState
//               ?SizedBox(
//                   height: 30.0,
//                   width: 30.0,
//                   child: CircularProgressIndicator(
//                     color: getProgressIndicatorColor(),
//                   ),
//                 ): Text(
//             widget.text,
//             style: widget.textStyle,
//             textAlign: TextAlign.center,
//           )
//         ));
//   }
//
//   getForegroundColor() {
//     return widget.buttonType == ButtonType.fill
//         ? Colors.white
//         : widget.color ?? Colors.black;
//   }
//
//   getBackgroundColor() {
//     return widget.buttonType == ButtonType.transparent
//         ? Colors.transparent
//         : widget.buttonType == ButtonType.white
//             ? Colors.white
//             : widget.buttonType == ButtonType.fill
//                 ? widget.color ?? AppColors.primaryColor
//                 : Colors.white;
//   }
//
//   getProgressIndicatorColor() {
//     return widget.buttonType == ButtonType.fill
//         ? Colors.white
//         : (widget.color ?? AppColors.primaryColor);
//   }
// }
