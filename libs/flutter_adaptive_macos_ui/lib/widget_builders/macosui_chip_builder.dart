// libs/flutter_adaptive_macos_ui/lib/widget_builders/macosui_chip_builder.dart
import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart'
    hide CupertinoIcons;

class MacosUIChipBuilder extends AdaptiveWidgetBuilder<AdaptiveChip> {
  @override
  Widget build(BuildContext context, AdaptiveChip component) {
    return Container(
      padding: component.padding ??
          const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: component.selected
            ? (component.selectedColor ?? MacosTheme.of(context).primaryColor)
            : (component.backgroundColor ?? MacosColors.separatorColor),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: component.side?.color ?? MacosColors.separatorColor,
          width: component.side?.width ?? 1,
        ),
      ),
      child: GestureDetector(
        onTap: component.onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (component.avatar != null) ...[
              component.avatar!,
              const SizedBox(width: 6),
            ],
            DefaultTextStyle(
              style: component.labelStyle ??
                  MacosTheme.of(context).typography.body.copyWith(
                        color: component.selected ? MacosColors.white : null,
                      ),
              child: component.label,
            ),
            if (component.onDeleted != null) ...[
              const SizedBox(width: 6),
              GestureDetector(
                onTap: component.onDeleted,
                child: component.deleteIcon ??
                    const MacosIcon(CupertinoIcons.clear_circled_solid,
                        size: 16),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
