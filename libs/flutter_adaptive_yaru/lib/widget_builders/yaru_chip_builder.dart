// libs/flutter_adaptive_yaru/lib/widget_builders/yaru_chip_builder.dart
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class YaruChipBuilder extends AdaptiveWidgetBuilder<AdaptiveChip> {
  @override
  Widget build(BuildContext context, AdaptiveChip component) {
    // Use Material chip with Yaru theming
    if (component.onPressed != null) {
      return ActionChip(
        label: component.label,
        avatar: component.avatar,
        onPressed: component.onPressed,
        backgroundColor:
            component.backgroundColor ?? ColorScheme.of(context).surface,
        shadowColor: component.shadowColor,
        elevation: component.elevation ?? 1,
        padding: component.padding,
        labelPadding: component.labelPadding,
        side: component.side ??
            BorderSide(color: ColorScheme.of(context).outline),
        shape: component.shape ??
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        clipBehavior: component.clipBehavior,
        focusNode: component.focusNode,
        autofocus: component.autofocus,
        materialTapTargetSize: component.materialTapTargetSize,
        visualDensity: component.visualDensity,
        iconTheme: component.iconTheme,
        labelStyle: component.labelStyle,
      );
    } else {
      return Chip(
        label: component.label,
        avatar: component.avatar,
        backgroundColor:
            component.backgroundColor ?? ColorScheme.of(context).surface,
        shadowColor: component.shadowColor,
        elevation: component.elevation ?? 1,
        padding: component.padding,
        labelPadding: component.labelPadding,
        side: component.side ??
            BorderSide(color: ColorScheme.of(context).outline),
        shape: component.shape ??
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        clipBehavior: component.clipBehavior,
        materialTapTargetSize: component.materialTapTargetSize,
        visualDensity: component.visualDensity,
        iconTheme: component.iconTheme,
        labelStyle: component.labelStyle,
      );
    }
  }
}
