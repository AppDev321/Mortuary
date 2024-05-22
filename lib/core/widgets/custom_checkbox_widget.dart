import 'package:flutter/material.dart';
import 'package:mortuary/core/enums/enums.dart';
import 'package:mortuary/core/utils/validators.dart';
import 'package:mortuary/core/widgets/small_progress_indicator.dart';
import '../styles/colors.dart';

class CustomCheckBoxFormField extends FormField<bool> {
  final bool? value;
  final Future Function(bool) onChanged;

  CustomCheckBoxFormField(
      {super.key,
      this.value,
      required this.onChanged,
      double? width,
      Widget? title})
      : super(
            initialValue: value,
            validator: TrueValidator.validator,
            builder: (state) =>
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                  CustomCheckBoxWidget(
                    title: title,
                    initialValue: value,
                    onChanged: onChanged,
                    width: width,
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  if (state.hasError) ...[
                    Row(
                      children: [
                        const SizedBox(
                          width: 10.0,
                        ),
                        Builder(
                            builder: (context) => Text(
                                  state.errorText ?? "Validation Error",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: Colors.red),
                                )),
                      ],
                    ),
                  ],
                ]));
}

class CustomCheckBoxWidget extends StatefulWidget {
  final bool preventChange;
  final Widget? title;
  final _formKey = GlobalKey<FormState>();
  final Function(bool) onChanged;
  final bool? initialValue;
  final String? Function(String?)? validator;
  final double? width;

  CustomCheckBoxWidget(
      {Key? key,
      this.title,
      this.width,
      this.preventChange = false,
      this.validator,
      required this.onChanged,
      this.initialValue})
      : super(key: key);

  @override
  State<CustomCheckBoxWidget> createState() => _CustomCheckBoxWidgetState();
}

class _CustomCheckBoxWidgetState extends State<CustomCheckBoxWidget> {
  LoadingState markDoneLoadingState = LoadingState.loaded;

  bool remember = false;

  @override
  void initState() {
    super.initState();
    remember = widget.initialValue ?? remember;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Form(
        key: widget._formKey,
        child: markDoneLoadingState == LoadingState.loaded
            ? CheckboxListTile(
                value: widget.initialValue,
                onChanged: (newValue) async {
                  setState(() {
                    remember = newValue as bool;
                  });
                  widget.onChanged(remember);
                },

                controlAffinity: ListTileControlAffinity.trailing,
                selectedTileColor: AppColors.primaryColor,
                checkColor: Colors.white,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                // Rounded Checkb,
                side: const BorderSide(),
                activeColor: AppColors.primaryColor,
                contentPadding: EdgeInsets.zero,
                // controlAffinity: ListTileControlAffinity.leading,
                title: widget.title,
              )
            : const SizedBox(
                width: 48.0,
                height: 48.0,
                child: Center(
                  child: SmallProgressIndicator(
                    size: 15.0,
                    strokeWidth: 2,
                  ),
                )),
      ),
    );
  }
}
