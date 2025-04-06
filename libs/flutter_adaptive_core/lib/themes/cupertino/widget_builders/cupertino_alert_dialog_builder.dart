import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import 'package:flutter_adaptive_core/layouts/adaptive_alert_dialog.dart';

class CupertinoAlertDialogBuilder
    extends AdaptiveWidgetBuilder<AdaptiveAlertDialogContent> {
  @override
  Widget build(BuildContext context, AdaptiveAlertDialogContent widget) {
    return CupertinoAlertDialog(
      title: widget.title,
      content: widget.content,
      actions: widget.actions.map((action) {
        return CupertinoDialogAction(
          onPressed: action.onPressed,
          isDestructiveAction: action.isDestructiveAction,
          child: action.child,
        );
      }).toList(),
    );
  }
}
