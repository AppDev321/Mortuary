import 'package:flutter/material.dart';
import 'package:mortuary/core/widgets/custom_text_field.dart';

/// [TextFormField] build on top of [CustomTextField], to handle
/// [obscureText] property. User can tap on icon button in the suffix to
/// show or hide password.
///
class PasswordField extends StatefulWidget {
  const PasswordField({
    Key? key,
    this.width,
    this.labelText,
    this.initialValue,
    this.validator,
    this.label,
    this.borderEnable = false,
    this.onChanged,
    this.prefixIcon
  }) : super(key: key);

  final String? initialValue;
  final Function(String?)? onChanged;
  final bool borderEnable;
  final String? Function(String?)? validator;
  final String? labelText;
  final String? label;
  final double? width;
  final Widget? prefixIcon;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool showPass = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(

      label: widget.label,
      width: widget.width,
      text: widget.labelText,
      headText: widget.labelText,
      initialValue: widget.initialValue,
      onChanged: widget.onChanged,
      fontWeight: FontWeight.bold,
      color: Colors.black,
      borderEnable: widget.borderEnable,
      validator: widget.validator,
      obscureText: showPass,
      prefixIcon: widget.prefixIcon,
      suffixIcon: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              showPass = !showPass;
            });
          },
          child: Icon(
            showPass ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            size: 24,
            color: Colors.black.withOpacity(.5),
          ),
        ),
      ),
    );
  }
}