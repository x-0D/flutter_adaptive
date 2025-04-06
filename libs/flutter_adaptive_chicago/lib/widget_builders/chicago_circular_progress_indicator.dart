import 'package:flutter/material.dart';
import 'package:chicago/chicago.dart' as chicago;
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import 'package:flutter_adaptive_chicago/utils/colors.dart';

class ChicagoCircularProgressIndicatorBuilder
    extends AdaptiveWidgetBuilder<AdaptiveCircularProgressIndicator> {
  @override
  Widget build(BuildContext context, AdaptiveCircularProgressIndicator widget) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors =
        isDark ? ChicagoThemeColors.dark() : ChicagoThemeColors.light();

    return SizedBox(
      width: 20,
      height: 20,
      child: Center(
        child: chicago.ActivityIndicator(
          color: colors.buttonHighlightColor,
          semanticLabel: 'Loading',
        ),
      ),
    );
  }
}
