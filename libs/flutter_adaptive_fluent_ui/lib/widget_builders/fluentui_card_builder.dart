import 'package:flutter/material.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

/// Builder for Fluent UI cards.
class FluentUICardBuilder extends AdaptiveWidgetBuilder<AdaptiveCard> {
  @override
  Widget build(BuildContext context, AdaptiveCard card) {
    final theme = Theme.of(context);

    return Container(
      margin: card.margin,
      decoration: BoxDecoration(
        color: card.color ?? theme.cardTheme.color,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: (theme.cardTheme.color?.computeLuminance() ?? 0.0) > 0.5
              ? const Color(0xFF404040)
              : const Color(0xFFE0E0E0),
          width: 1,
        ),
        boxShadow: card.elevation != null
            ? [
                BoxShadow(
                  color: theme.cardTheme.shadowColor?.withOpacity(0.1) ??
                      Colors.black.withOpacity(0.1),
                  blurRadius: card.elevation! * 2,
                  offset: Offset(0, card.elevation!),
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: card.child,
      ),
    );
  }
}
