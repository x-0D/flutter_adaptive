import 'package:flutter/material.dart';
import 'package:chicago/chicago.dart' as chicago;
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class ChicagoDatePickerBuilder
    extends AdaptiveWidgetBuilder<AdaptiveDatePicker> {
  @override
  Widget build(BuildContext context, AdaptiveDatePicker widget) {
    return CalendarDatePicker(
      initialDate: widget.initialDate,
      firstDate: widget.minDate,
      lastDate: widget.maxDate,
      onDateChanged: widget.onDateTimeChanged,
      initialCalendarMode: DatePickerMode.day,
    );
  }
}
