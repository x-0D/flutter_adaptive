// libs/flutter_adaptive_core/lib/themes/material/widget_builders/material_chip_builder.dart
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class MaterialChipBuilder extends AdaptiveWidgetBuilder<AdaptiveChip> {
  @override
  Widget build(BuildContext context, AdaptiveChip component) {
    if (component.onPressed != null) {
      return ActionChip(
        label: component.label,
        avatar: component.avatar,
        onPressed: component.onPressed,
        backgroundColor: component.backgroundColor,
        shadowColor: component.shadowColor,
        surfaceTintColor: component.surfaceTintColor,
        elevation: component.elevation,
        pressElevation: component.pressElevation,
        padding: component.padding,
        labelPadding: component.labelPadding,
        side: component.side,
        shape: component.shape,
        clipBehavior: component.clipBehavior,
        focusNode: component.focusNode,
        autofocus: component.autofocus,
        materialTapTargetSize: component.materialTapTargetSize,
        visualDensity: component.visualDensity,
        iconTheme: component.iconTheme,
        labelStyle: component.labelStyle,
      );
    } else if (component.onDeleted != null) {
      return InputChip(
        label: component.label,
        avatar: component.avatar,
        onDeleted: component.onDeleted,
        deleteIcon: component.deleteIcon,
        backgroundColor: component.backgroundColor,
        selectedColor: component.selectedColor,
        shadowColor: component.shadowColor,
        surfaceTintColor: component.surfaceTintColor,
        elevation: component.elevation,
        pressElevation: component.pressElevation,
        selected: component.selected,
        padding: component.padding,
        labelPadding: component.labelPadding,
        side: component.side,
        shape: component.shape,
        clipBehavior: component.clipBehavior,
        focusNode: component.focusNode,
        autofocus: component.autofocus,
        materialTapTargetSize: component.materialTapTargetSize,
        visualDensity: component.visualDensity,
        iconTheme: component.iconTheme,
        labelStyle: component.labelStyle,
        deleteIconColor: component.deleteIconColor,
        deleteButtonTooltipMessage: component.deleteButtonTooltipMessage,
      );
    } else {
      return Chip(
        label: component.label,
        avatar: component.avatar,
        backgroundColor: component.backgroundColor,
        shadowColor: component.shadowColor,
        surfaceTintColor: component.surfaceTintColor,
        elevation: component.elevation,
        padding: component.padding,
        labelPadding: component.labelPadding,
        side: component.side,
        shape: component.shape,
        clipBehavior: component.clipBehavior,
        materialTapTargetSize: component.materialTapTargetSize,
        visualDensity: component.visualDensity,
        iconTheme: component.iconTheme,
        labelStyle: component.labelStyle,
      );
    }
  }
}
