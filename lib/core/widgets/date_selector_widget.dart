import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mortuary/core/constants/place_holders.dart';
import 'package:mortuary/core/utils/validators.dart';

import 'custom_text_field.dart';

/// Widget that renders [CustomTextField] widget to display
/// selected [DateTime] and allows to change the date
/// Exposes a [onTap] function, to allow to change the
/// [DateTime] in the parent widget.
/// Handles validation, using the [validator] param of [CustomTextField].
class DateSelectorWidget extends StatefulWidget {
  const DateSelectorWidget(
      {Key? key,
      required this.initialDate,
      required this.onTap,
      this.label,
      this.labelFontSize,
      this.icon,
      this.margin,
      this.firstDate,
      this.width,
      this.dateFormat,
      this.disabledDates,
      this.selectableDayOffset = 0,
      this.disabledWeekdays,
      this.disableWeekends = false,
      this.selectTime = true,
      this.borderColor,
      this.defaultInitialDate,
      this.lastDate})
      : super(key: key);

  final DateTime? initialDate;
  final Function(DateTime) onTap;
  final String? label;
  final double? labelFontSize;
  final IconData? icon;
  final EdgeInsets? margin;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final double? width;
  final bool disableWeekends;
  final bool selectTime;
  final Color? borderColor;
  final DateFormat? dateFormat;
  final DateTime? defaultInitialDate;
  final List<DateTime>? disabledDates;
  final List<int>? disabledWeekdays;
  final int selectableDayOffset;

  @override
  State<DateSelectorWidget> createState() => _DateSelectorWidgetState();
}

class _DateSelectorWidgetState extends State<DateSelectorWidget> {
  DateTime? dateTime;

  @override
  void initState() {
    super.initState();
    dateTime = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    double fontSize = Theme.of(context).textTheme.bodyMedium!.fontSize!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          SizedBox(
            child: Text(
              widget.label!,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.w500),
            ),
          ),
          minPlaceHolder
        ],
        TextFormField(
          key: UniqueKey(),
          initialValue: dateTime != null
              ? widget.dateFormat != null
              ? widget.dateFormat!.format(dateTime!)
              : !widget.selectTime
              ? DateFormat.MMMEd().add_y().format(dateTime!)
              : DateFormat.yMMMd().add_jm().format(dateTime!)
              : null,
          readOnly: true,
          validator: EmptyDateFieldValidator.validator,
          // controller: controller,
          onTap: () async {
            final newDate = await showDatePicker(
              context: context,
              initialDate: getInitialDate(
                  dateTime,
                  widget.defaultInitialDate,
                  widget.firstDate,
                  widget.lastDate,
                  widget.disabledDates,
                  widget.disabledWeekdays),
              firstDate: widget.firstDate ?? DateTime.now(),
              lastDate: widget.lastDate ?? DateTime(2050),
              selectableDayPredicate: (calendarDate) {
                final dateTime = DateTime.now();
                final now =
                    DateTime(dateTime.year, dateTime.month, dateTime.day);
                final offset = widget
                    .selectableDayOffset; // Replace this with your actual offset value
                final allowedDate =
                    now.add(Duration(days: offset == 0 ? 0 : offset - 1));

                // Check if the calendarDate is not in disabled dates and weekdays
                bool isSelectable = !(widget.disabledDates?.contains(DateTime(
                            calendarDate.year,
                            calendarDate.month,
                            calendarDate.day)) ??
                        false) &&
                    !(widget.disabledWeekdays?.contains(calendarDate.weekday) ??
                        false);

                // Check if the calendarDate is after the allowedDate
                isSelectable = isSelectable && offset == 0
                    ? true
                    : calendarDate.isAfter(allowedDate);

                return isSelectable;
              },
            );

            if (newDate != null) {
              if (widget.selectTime) {
                if (context.mounted) {
                  final newTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(newDate),
                  );
                  if (newTime != null) {
                    setState(() {
                      dateTime = newDate.add(Duration(
                          hours: newTime.hour, minutes: newTime.minute));
                    });
                  } else {
                    setState(() {
                      dateTime = newDate;
                    });
                  }
                  widget.onTap(dateTime!);
                }
              } else {
                setState(() {
                  dateTime = newDate;
                });
                widget.onTap(newDate);
              }
            }
          },
          // style: TextStyle(color: Colors.grey, fontSize: 14),
          textAlign: TextAlign.start,
          maxLines: 1,
          // initialValue: initialValue,

          decoration: InputDecoration(
            fillColor: Theme.of(context).colorScheme.outline.withOpacity(.3),
            hintText: 'Select date time',
            filled: true,
            contentPadding: EdgeInsets.all(10),
            // labelText: labelText,
            prefixIcon: Container(
                margin: EdgeInsets.only(right: 5),
                decoration: BoxDecoration(
                  color: Color(0xFFEEEEEEE),
                  borderRadius: const BorderRadius.all(Radius.circular(9.00)),
                ),
                child: const Icon(
                  Icons.calendar_month,
                  color: Colors.grey,
                )),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context)
                      .colorScheme
                      .outline), // Set border color
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            ),
            // errorBorder: ,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context)
                      .colorScheme
                      .outline), // Set border color
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            ),

            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context)
                      .colorScheme
                      .outline), // Set border color
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),

              // Set border color
            ),
            suffixIcon: Icon(
              widget.icon ?? Icons.calendar_month,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }

  DateTime getInitialDate(
    DateTime? selectedDate,
    DateTime? defaultInitialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    List<DateTime>? disabledDates,
    List<int>? disabledWeekdays,
  ) {
    final DateTime now = DateTime.now();

    DateTime initialDate = selectedDate ??
        dateTime ??
        defaultInitialDate?.add(Duration(days: widget.selectableDayOffset)) ??
        DateTime(now.year, now.month, now.day)
            .add(Duration(days: widget.selectableDayOffset));

    if (firstDate != null && initialDate.isBefore(firstDate)) {
      initialDate = firstDate;
    }

    if (lastDate != null && initialDate.isAfter(lastDate)) {
      initialDate = lastDate;
    }

    if (disabledDates != null && disabledWeekdays != null) {
      while (disabledDates.contains(initialDate) ||
          disabledWeekdays.contains(initialDate.weekday)) {
        initialDate = initialDate.add(const Duration(days: 1));
        if (lastDate != null && initialDate.isAfter(lastDate)) {
          initialDate = firstDate ?? now;
        }
      }
    } else if (disabledDates != null) {
      while (disabledDates.contains(initialDate)) {
        initialDate = initialDate.add(const Duration(days: 1));
        if (lastDate != null && initialDate.isAfter(lastDate)) {
          initialDate = firstDate ?? now;
        }
      }
    } else if (disabledWeekdays != null) {
      while (disabledWeekdays.contains(initialDate.weekday)) {
        initialDate = initialDate.add(const Duration(days: 1));
        if (lastDate != null && initialDate.isAfter(lastDate)) {
          initialDate = firstDate ?? now;
        }
      }
    }

    return initialDate;
  }
}
