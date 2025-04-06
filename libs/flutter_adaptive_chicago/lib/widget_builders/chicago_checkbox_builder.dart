import 'package:flutter/material.dart';
import 'package:chicago/chicago.dart' as chicago;
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import 'package:flutter_adaptive_chicago/utils/colors.dart';

class ChicagoCheckboxBuilder extends AdaptiveWidgetBuilder<AdaptiveCheckbox> {
  @override
  Widget build(BuildContext context, AdaptiveCheckbox widget) {
    return _CheckboxRenderWidget(widget: widget);
  }
}

class _CheckboxRenderWidget extends StatefulWidget {
  final AdaptiveCheckbox widget;

  const _CheckboxRenderWidget({required this.widget});

  @override
  State<_CheckboxRenderWidget> createState() => _CheckboxRenderWidgetState();
}

class _CheckboxRenderWidgetState extends State<_CheckboxRenderWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final chicagoTheme = Theme.of(context).extension<ChicagoThemeData>();
    final colors = chicagoTheme?.colors ?? ChicagoThemeColors.light();
    final bool isEnabled = widget.widget.onChanged != null;

    // Checkbox dimensions
    const double checkboxSize = 16.0;

    // Windows XP style colors
    final Color outerBorderColor = Colors.grey.shade700;
    final Color innerBorderColor = Colors.white;
    final Color checkedColor = Color(0xFF3B7CBD); // Windows XP blue
    final Color checkedHoverColor = Color(0xFF4C8DD7); // Lighter blue for hover
    final Color uncheckedColor = Colors.white;
    final Color checkmarkColor = Colors.white;

    // Determine colors based on state
    Color fillColor;
    Color borderColor = outerBorderColor;

    if (!isEnabled) {
      fillColor = Colors.grey.shade300;
      borderColor = Colors.grey.shade500;
    } else if (widget.widget.value == true) {
      fillColor = _isHovered ? checkedHoverColor : checkedColor;
    } else {
      fillColor = uncheckedColor;
    }

    // Create gradient based on state
    LinearGradient gradient;

    if (!isEnabled) {
      // Disabled state
      gradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.grey.shade200,
          Colors.grey.shade300,
        ],
      );
    } else if (widget.widget.value == true) {
      // Checked state - Windows XP blue gradient
      gradient = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          _isHovered
              ? Color(0xFF5A9AE1)
              : Color(0xFF4A8AD0), // Top left (lighter)
          _isHovered
              ? Color(0xFF3D7DCE)
              : Color(0xFF2D6DBE), // Bottom right (darker)
        ],
      );
    } else {
      // Unchecked state - Windows XP white gradient
      gradient = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white,
          Color(0xFFF5F5F5),
        ],
      );
    }

    Widget checkbox = SizedBox(
      width: checkboxSize,
      height: checkboxSize,
      child: OverflowBox(
        maxWidth: checkboxSize,
        minWidth: checkboxSize,
        maxHeight: checkboxSize,
        minHeight: checkboxSize,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 1.0),
            gradient: gradient,
          ),
          child: widget.widget.value == true
              ? Center(
                  child: Icon(
                    Icons.check,
                    size: 9.0,
                    color: checkmarkColor,
                    weight: 900,
                  ),
                )
              : null,
        ),
      ),
    );

    if (isEnabled) {
      checkbox = MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: () {
            widget.widget.onChanged?.call(!(widget.widget.value ?? false));
          },
          child: checkbox,
        ),
      );
    }

    return checkbox;
  }
}
