import 'package:flutter/material.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import 'package:macos_ui/macos_ui.dart';

class MacosUICardBuilder extends AdaptiveWidgetBuilder<AdaptiveCard> {
  @override
  Widget build(BuildContext context, AdaptiveCard component) {
    final theme = MacosTheme.of(context);

    return Container(
      margin: component.margin ?? const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: component.color ?? theme.dividerColor,
        borderRadius: BorderRadius.circular(6.0), // macOS corner radius
        border: Border.all(
          color: theme.dividerColor,
          width: 0.5,
        ),
        boxShadow: _getMacOSShadow(component.elevation, context),
      ),
      clipBehavior: component.clipBehavior ?? Clip.antiAlias,
      child: component.child,
    );
  }

  List<BoxShadow> _getMacOSShadow(double? elevation, BuildContext context) {
    if (elevation == null || elevation <= 0) return [];
    final theme = MacosTheme.of(context);
    return [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: elevation * 1.5,
        offset: Offset(0, elevation * 0.5),
      ),
    ];
  }
}
