import 'package:flutter/material.dart';
import 'package:chicago/chicago.dart' as chicago;
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class ChicagoAppBarBuilder extends AdaptiveWidgetBuilder<AdaptiveAppBar> {
  @override
  Widget build(BuildContext context, AdaptiveAppBar component) {
    return AppBar(
      leading: component.leading,
      title: component.title,
      actions: component.actions?.map((action) {
        return IconButton(
          onPressed: action.onPressed,
          icon: action.icon,
        );
      }).toList(),
    );
  }
}
