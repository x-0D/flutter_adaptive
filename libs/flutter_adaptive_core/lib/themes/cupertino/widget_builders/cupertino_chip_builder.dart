// libs/flutter_adaptive_core/lib/themes/cupertino/widget_builders/cupertino_chip_builder.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart'
    hide CupertinoTheme, CupertinoIcons;

class CupertinoChipBuilder extends AdaptiveWidgetBuilder<AdaptiveChip> {
  @override
  Widget build(BuildContext context, AdaptiveChip component) {
    return Container(
      padding: component.padding ??
          const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: component.selected
            ? (component.selectedColor ??
                CupertinoColors.activeBlue.resolveFrom(context))
            : (component.backgroundColor ??
                CupertinoColors.systemGrey5.resolveFrom(context)),
        borderRadius: BorderRadius.circular(16),
        border: component.side != null
            ? Border.all(
                color: component.side!.color, width: component.side!.width)
            : null,
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
                  CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                        color: component.selected
                            ? CupertinoColors.label.resolveFrom(context)
                            : null,
                      ),
              child: component.label,
            ),
            if (component.onDeleted != null) ...[
              const SizedBox(width: 6),
              GestureDetector(
                onTap: component.onDeleted,
                child: component.deleteIcon ??
                    Icon(CupertinoIcons.clear_circled_solid,
                        size: 16, color: component.deleteIconColor),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
