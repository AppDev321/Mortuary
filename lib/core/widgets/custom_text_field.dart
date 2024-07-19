
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mortuary/core/styles/colors.dart';
import 'package:mortuary/core/widgets/custom_text_widget.dart';

/// A custom [TextFormField] for this app to allow
/// for uniform design changes throughout the app.

class CustomPasswordField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final String? initialValue;
  final void Function(String)? onChanged; // New onChanged property
  final String? Function(String?)? validator;

  const CustomPasswordField({
    Key? key,
    this.validator,
    this.initialValue,
    this.hintText,
    this.labelText,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      initialValue: widget.initialValue,
      onChanged: widget.onChanged,
      suffixIcon: IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      ),
      hintText: widget.hintText,
      labelText: widget.labelText,
      obscureText: _obscureText,
      validator: widget.validator,
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final String? Function(String?)? validator; // New validator property
  final Widget? suffixIcon;
  final bool? obscureText;
  final int? maxLines;
  final void Function(String)? onChanged; // New onChanged property
  final String? initialValue;

  const CustomTextFormField({super.key, 
    Key? key,
    this.labelText,
    this.hintText,
    this.validator,
    this.suffixIcon,
    this.obscureText,
    this.initialValue,
    this.maxLines,
    this.onChanged, // Pass the onChanged through the constructor
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: obscureText == true ? 1 : maxLines,
      initialValue: initialValue,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        labelText: labelText,
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        hintStyle: Theme.of(context).textTheme.bodyLarge,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        suffixIcon: suffixIcon,
      ),
      validator: validator,
      onChanged: onChanged, // Assign the onChanged from the widget's property
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String? text;
  final double size;
  final String? headText;
  final FontWeight fontWeight;
  final Color? color;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType textInputType;
  final String? initialValue;
  final bool borderEnable;
  final String? label;
  final Widget? prefixIcon;
  final double? width;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final bool readOnly;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final Function()? onTap;

  const CustomTextField(
      {Key? key,
      @required this.text,
      this.initialValue,
      this.onTap,
      this.obscureText = false,
      this.width,
      this.focusNode,
      this.readOnly = false,
      this.headText,
      this.inputFormatters,
      this.suffixIcon,
      this.label,
      this.textInputType = TextInputType.text,
      this.size = 14,
      this.fontWeight = FontWeight.normal,
      this.color = Colors.black,
      this.validator,
      this.prefixIcon,
      this.controller,
      this.borderEnable = false,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (headText != null) ...[
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: CustomTextWidget(
                text: headText,
                size: 14,
                colorText: AppColors.blackColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 5,
            )
          ],
          TextFormField(
              initialValue: initialValue,
              onTap: onTap,
              validator: validator,
              cursorColor: AppColors.blackColor,
              readOnly: readOnly,
              style: TextStyle(color: color ?? Colors.grey, fontSize: 12,fontWeight: FontWeight.w300),
              autofocus: false,
              focusNode: focusNode,
              inputFormatters: inputFormatters,
              keyboardType: textInputType,
              controller: controller,
              obscureText: obscureText,
              decoration: boxContainer(context, text!),
              onChanged: onChanged),
        ],
      ),
    );
  }

  InputDecoration boxContainer(BuildContext context, String hintText) {
    return InputDecoration(
      // errorBorder: OutlineInputBorder(
      //   borderSide: const BorderSide(width: 1, color: Colors.red),
      //   borderRadius: BorderRadius.circular(15),
      // ),
      // focusedErrorBorder: OutlineInputBorder(
      //   borderSide: const BorderSide(width: 1, color: Colors.red),
      //   borderRadius: BorderRadius.circular(15),
      // ),
      contentPadding: const EdgeInsets.all(15),
      labelText: label,
      prefixIcon: prefixIcon,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.white,
      hintText: hintText,
      hintStyle: const TextStyle(
          color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w300),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            width: 1,
            color: borderEnable
                ? Theme.of(context).colorScheme.primary
                : Colors.transparent),
        borderRadius: BorderRadius.circular(35),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(35)),

      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
            width: 2,
            color: borderEnable
                ?Colors.grey.withOpacity(.1) : Theme.of(context).colorScheme.primary
                ),
        borderRadius: BorderRadius.circular(35),
      ),
    );
  }
}
