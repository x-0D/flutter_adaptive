import 'package:flutter/material.dart';
import 'package:chicago/chicago.dart' as chicago;
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class ChicagoContextMenuBuilder
    extends AdaptiveWidgetBuilder<AdaptiveContextMenu> {
  @override
  Widget build(BuildContext context, AdaptiveContextMenu widget) {
    return GestureDetector(
      onSecondaryTapDown: (details) {
        final RenderBox button = context.findRenderObject() as RenderBox;
        final Offset position = button.globalToLocal(details.globalPosition);
        showMenu(
          context: context,
          position: RelativeRect.fromLTRB(
            details.globalPosition.dx,
            details.globalPosition.dy,
            details.globalPosition.dx + 1,
            details.globalPosition.dy + 1,
          ),
          items: widget.actions.map((action) {
            return PopupMenuItem(
              onTap: action.onPressed,
              child: Text(action.text),
            );
          }).toList(),
        );
      },
      child: widget.child,
    );
  }
}
