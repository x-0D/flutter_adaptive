import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class ChicagoContextMenuItemBuilder
    extends AdaptiveWidgetBuilder<AdaptiveContextMenuItem> {
  @override
  Widget build(BuildContext context, AdaptiveContextMenuItem widget) {
    return CupertinoContextMenuAction(
      onPressed: widget.onPressed,
      child: Text(widget.text),
    );
  }
}
