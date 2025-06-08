import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class FluentUIChipBuilder extends AdaptiveWidgetBuilder<AdaptiveChip> {
  @override
  Widget build(BuildContext context, AdaptiveChip component) {
    return Container(
      padding: component.padding ??
          const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: component.selected
            ? (component.selectedColor ?? FluentTheme.of(context).accentColor)
            : (component.backgroundColor ?? FluentTheme.of(context).cardColor),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: component.side?.color ?? FluentTheme.of(context).menuColor,
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
                  FluentTheme.of(context).typography.body?.copyWith(
                        color: component.selected
                            ? Colors.white
                            : FluentTheme.of(context).typography.body?.color,
                      ) ??
                  const TextStyle(),
              child: component.label,
            ),
            if (component.onDeleted != null) ...[
              const SizedBox(width: 6),
              GestureDetector(
                onTap: component.onDeleted,
                child: component.deleteIcon ??
                    Icon(FluentIcons.clear,
                        size: 12, color: component.deleteIconColor),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
