import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import 'package:flutter_adaptive_core/layouts/adaptive_alert_dialog.dart';

class FluentUIAlertDialogBuilder
    extends AdaptiveWidgetBuilder<AdaptiveAlertDialogContent> {
  @override
  Widget build(BuildContext context, AdaptiveAlertDialogContent widget) {
    return ContentDialog(
      title: widget.title,
      content: widget.content,
      actions: widget.actions.map((action) {
        return Button(
          onPressed: action.onPressed,
          style: ButtonStyle(
            backgroundColor:
                action.isDestructiveAction ? ButtonState.all(Colors.red) : null,
            foregroundColor: action.isDestructiveAction
                ? ButtonState.all(Colors.white)
                : null,
          ),
          child: action.child,
        );
      }).toList(),
    );
  }
}
