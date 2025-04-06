import 'package:flutter/material.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import 'package:flutter_adaptive_core/layouts/adaptive_alert_dialog.dart';

class YaruAlertDialogBuilder
    extends AdaptiveWidgetBuilder<AdaptiveAlertDialogContent> {
  @override
  Widget build(BuildContext context, AdaptiveAlertDialogContent widget) {
    return AlertDialog(
      title: widget.title,
      content: widget.content,
      actions: widget.actions.map((action) {
        return TextButton(
          onPressed: action.onPressed,
          style: TextButton.styleFrom(
            foregroundColor: action.isDestructiveAction ? Colors.red : null,
          ),
          child: action.child,
        );
      }).toList(),
    );
  }
}
