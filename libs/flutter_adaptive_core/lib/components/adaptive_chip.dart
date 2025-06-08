import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class AdaptiveChip extends AdaptiveWidget {
  const AdaptiveChip({
    super.key,
    required this.label,
    this.avatar,
    this.onPressed,
    this.onDeleted,
    this.deleteIcon,
    this.backgroundColor,
    this.selectedColor,
    this.shadowColor,
    this.surfaceTintColor,
    this.elevation,
    this.pressElevation,
    this.selected = false,
    this.enabled = true,
    this.padding,
    this.labelPadding,
    this.side,
    this.shape,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.materialTapTargetSize,
    this.visualDensity,
    this.iconTheme,
    this.labelStyle,
    this.deleteIconColor,
    this.useDeleteButtonTooltip = true,
    this.deleteButtonTooltipMessage,
  });

  final Widget label;
  final Widget? avatar;
  final VoidCallback? onPressed;
  final VoidCallback? onDeleted;
  final Widget? deleteIcon;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final double? elevation;
  final double? pressElevation;
  final bool selected;
  final bool enabled;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? labelPadding;
  final BorderSide? side;
  final OutlinedBorder? shape;
  final Clip clipBehavior;
  final FocusNode? focusNode;
  final bool autofocus;
  final MaterialTapTargetSize? materialTapTargetSize;
  final VisualDensity? visualDensity;
  final IconThemeData? iconTheme;
  final TextStyle? labelStyle;
  final Color? deleteIconColor;
  final bool useDeleteButtonTooltip;
  final String? deleteButtonTooltipMessage;
}
