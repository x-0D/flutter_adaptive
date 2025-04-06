import 'package:flutter/material.dart';
import 'package:chicago/chicago.dart' as chicago;
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import 'package:flutter_adaptive_chicago/utils/colors.dart';

class ChicagoSwitchBuilder extends AdaptiveWidgetBuilder<AdaptiveSwitch> {
  @override
  Widget build(BuildContext context, AdaptiveSwitch widget) {
    final chicagoTheme = Theme.of(context).extension<ChicagoThemeData>();
    final colors = chicagoTheme?.colors ?? ChicagoThemeColors.light();
    final bool isEnabled = widget.onChanged != null;

    // Track dimensions
    const double trackWidth = 44.0;
    const double trackHeight = 20.0;
    const double thumbWidth = 16.0;
    const double thumbHeight = 16.0;
    const double thumbPadding = 2.0;

    // Track decoration
    final Decoration trackDecoration = BoxDecoration(
      border: Border.all(
        color: isEnabled
            ? (widget.value
                ? colors.buttonHighlightBorderColor
                : colors.buttonBorderColor)
            : colors.buttonDisabledBorderColor,
        width: 1,
      ),
      color: isEnabled
          ? (widget.value
              ? colors.buttonHighlightColor
              : colors.buttonBackgroundColor)
          : colors.buttonDisabledBackgroundColor,
      gradient: isEnabled
          ? LinearGradient(
              begin: Alignment.center,
              end: Alignment.topCenter,
              colors: widget.value
                  ? [
                      colors.buttonHighlightColor,
                      darken(colors.buttonHighlightColor),
                    ]
                  : [
                      colors.buttonBackgroundColor,
                      darken(colors.buttonBackgroundColor),
                    ],
            )
          : null,
    );

    // Thumb decoration
    final Decoration thumbDecoration = BoxDecoration(
      border: Border.all(
        color: isEnabled
            ? colors.buttonBorderColor
            : colors.buttonDisabledBorderColor,
        width: 1,
      ),
      color: isEnabled
          ? colors.surfaceColor
          : colors.buttonDisabledBackgroundColor,
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          brighten(colors.surfaceColor),
          colors.surfaceColor,
          darken(colors.surfaceColor),
        ],
      ),
    );

    Widget result = SizedBox(
      width: trackWidth,
      height: trackHeight,
      child: OverflowBox(
        maxWidth: trackWidth,
        minWidth: trackWidth,
        child: Container(
          decoration: trackDecoration,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeInOut,
                left: widget.value
                    ? trackWidth - thumbWidth - thumbPadding
                    : thumbPadding,
                top: (trackHeight - thumbHeight) / 3, // Reduced top padding by positioning thumb higher
                child: Container(
                  width: thumbWidth,
                  height: thumbHeight,
                  decoration: thumbDecoration,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (isEnabled) {
      result = MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => widget.onChanged!(!widget.value),
          child: result,
        ),
      );
    }

    return result;
  }
}
