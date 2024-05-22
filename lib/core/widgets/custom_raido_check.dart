import 'package:flutter/material.dart';

import 'custom_text_widget.dart';

class LabeledRadio<T> extends StatelessWidget {
  const LabeledRadio(
      {Key? key,
      required this.label,
      required this.padding,
      required this.groupValue,
      required this.value,
      required this.onChanged,
      this.icon})
      : super(key: key);

  final String label;
  final EdgeInsets padding;
  final T? groupValue;
  final T value;
  final ValueChanged<T> onChanged;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.surface,
        ),
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(icon),
            CustomTextWidget(
              text: label,
              size: 16,
              fontWeight: FontWeight.w500,
            ),
            CustomTextWidget(
              text: 'S \$200',
              size: 14,
              fontWeight: FontWeight.w500,
            ),

            Radio<T>(
              groupValue: groupValue,
              value: value,
              onChanged: (T? newValue) {
                onChanged(newValue as T);
              },
            ),
          ],
        ),
      ),
    );
  }
}
