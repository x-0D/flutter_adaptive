import 'package:flutter/material.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class MaterialCardBuilder extends AdaptiveWidgetBuilder<AdaptiveCard> {
  @override
  Widget build(BuildContext context, AdaptiveCard component) {
    return Card(
      elevation: component.elevation,
      color: component.color,
      shadowColor: component.shadowColor,
      surfaceTintColor: component.surfaceTintColor,
      shape: component.shape,
      borderOnForeground: component.borderOnForeground,
      margin: component.margin,
      clipBehavior: component.clipBehavior,
      semanticContainer: component.semanticContainer,
      child: component.child,
    );
  }
}
