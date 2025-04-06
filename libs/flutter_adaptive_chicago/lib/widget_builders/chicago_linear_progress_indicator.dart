import 'package:flutter/material.dart';
import 'package:chicago/chicago.dart' as chicago;
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import 'package:flutter_adaptive_chicago/utils/colors.dart';

class ChicagoLinearProgressIndicatorBuilder
    extends AdaptiveWidgetBuilder<AdaptiveLinearProgressIndicator> {
  @override
  Widget build(BuildContext context, AdaptiveLinearProgressIndicator widget) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors =
        isDark ? ChicagoThemeColors.dark() : ChicagoThemeColors.light();

    // Handle the value conversion:
    // If value is null or negative, show 0
    // Otherwise, clamp value between 0 and 1
    final double percentage = widget.value != null && widget.value! >= 0
        ? (widget.value! / 100).clamp(0.0, 1.0)
        : 0.0;

    return SizedBox(
      height: 4,
      child: chicago.Meter(
        gridFrequency: 0.1,
        percentage: percentage,
      ),
    );
  }
}
