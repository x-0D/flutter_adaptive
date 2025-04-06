import 'package:flutter/widgets.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import 'package:flutter_adaptive_core/layouts/adaptive_alert_dialog.dart';

class MacosUIAlertDialogBuilder
    extends AdaptiveWidgetBuilder<AdaptiveAlertDialogContent> {
  @override
  Widget build(BuildContext context, AdaptiveAlertDialogContent widget) {
    return MacosAlertDialog(
      appIcon: const FlutterLogo(size: 56),
      title: widget.title,
      message: widget.content,
      primaryButton: PushButton(
        controlSize: ControlSize.large,
        onPressed: () {
          if (widget.actions.isNotEmpty) {
            widget.actions.first.onPressed();
          }
        },
        child: widget.actions.isNotEmpty
            ? widget.actions.first.child
            : const Text('OK'),
      ),
      secondaryButton: widget.actions.length > 1
          ? PushButton(
              controlSize: ControlSize.large,
              onPressed: () {
                widget.actions[1].onPressed();
              },
              child: widget.actions[1].child,
            )
          : null,
    );
  }
}
