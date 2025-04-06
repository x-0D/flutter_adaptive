import 'package:flutter/material.dart';
import 'package:chicago/chicago.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import '../utils/colors.dart';

class ChicagoTextButtonBuilder extends AdaptiveWidgetBuilder<AdaptiveTextButton> {
  @override
  Widget build(BuildContext context, AdaptiveTextButton widget) {
    final chicagoTheme = Theme.of(context).extension<ChicagoThemeData>();
    final colors = chicagoTheme?.colors ?? ChicagoThemeColors.light();

    return TextButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return colors.disabledTextColor;
          } else if (states.contains(MaterialState.pressed)) {
            return Colors.red;  // Classic XP pressed link color
          } else if (states.contains(MaterialState.hovered)) {
            return Colors.blue[800];  // Darker blue on hover
          }
          return Colors.blue;  // Default link color
        }),
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        textStyle: MaterialStateProperty.resolveWith((states) {
          return TextStyle(
            decoration: states.contains(MaterialState.disabled)
                ? TextDecoration.none
                : TextDecoration.underline,
          );
        }),
        mouseCursor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return SystemMouseCursors.forbidden;
          }
          return SystemMouseCursors.click;
        }),
      ),
      child: widget.child,
    );
  }
}
