import 'package:flutter/material.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import 'package:yaru/yaru.dart';

class YaruCardBuilder extends AdaptiveWidgetBuilder<AdaptiveCard> {
  @override
  Widget build(BuildContext context, AdaptiveCard component) {
    final theme = Theme.of(context);
    final yaruTheme = YaruTheme.of(context);

    return Card(
      elevation: component.elevation ?? 1.0, // Yaru uses subtle elevation
      color: component.color ?? theme.cardColor,
      shadowColor: component.shadowColor,
      surfaceTintColor: component.surfaceTintColor,
      shape: component.shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // Yaru corner radius
          ),
      borderOnForeground: component.borderOnForeground,
      margin: component.margin ?? const EdgeInsets.all(8.0),
      clipBehavior: component.clipBehavior,
      semanticContainer: component.semanticContainer,
      child: component.child,
    );
  }
}
