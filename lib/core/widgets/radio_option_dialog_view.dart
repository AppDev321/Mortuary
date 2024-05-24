import 'package:flutter/material.dart';

import '../constants/app_strings.dart';

class RadioOptionDialog<T> extends StatefulWidget {
  final String title;
  final List<T> options;
  final T selectedOption;
  final String Function(T) convertItemToStringName;
  final void Function(T?) onChanged;
  final void Function(T?) onConfirmed;

  const RadioOptionDialog({
    Key? key,
    required this.convertItemToStringName,
    required this.title,
    required this.options,
    required this.selectedOption,
    required this.onChanged,
    required this.onConfirmed,

  }) : super(key: key);

  @override
  _RadioOptionDialogState<T> createState() => _RadioOptionDialogState<T>();
}

class _RadioOptionDialogState<T> extends State<RadioOptionDialog<T>> {
  T? _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.selectedOption;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.title,
        style: TextStyle(fontSize: 16),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: widget.options.map((option) {
            return RadioListTile<T>(
              title: Text(widget.convertItemToStringName(option)),
              value: option,
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value;
                  widget.onChanged(value);
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(AppStrings.cancelButtonText),
        ),
        TextButton(
          onPressed: () {
            widget.onConfirmed(_selectedOption);
            Navigator.of(context).pop();
          },
          child: Text(AppStrings.okButtonText),
        ),
      ],
    );
  }
}
