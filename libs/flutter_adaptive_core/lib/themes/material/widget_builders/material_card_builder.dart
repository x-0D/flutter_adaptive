import 'package:flutter/material.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

/// Builder for Material Design cards.
class MaterialCardBuilder extends AdaptiveWidgetBuilder<AdaptiveCard> {
  @override
  Widget build(BuildContext context, AdaptiveCard card) {
    final theme = Theme.of(context);
    return Card(
      color: card.color ?? theme.cardColor,
      elevation: card.elevation ?? 2.0,
      shape: card.shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
      margin: card.margin,
      child: card.child,
    );
  }
}
