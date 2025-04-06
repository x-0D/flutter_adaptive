import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

/// Builder for Cupertino cards.
class CupertinoCardBuilder extends AdaptiveWidgetBuilder<AdaptiveCard> {
  @override
  Widget build(BuildContext context, AdaptiveCard card) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: card.margin,
      decoration: BoxDecoration(
        color: card.color ?? theme.cardColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isDark ? const Color(0xFF404040) : const Color(0xFFE0E0E0),
          width: 1,
        ),
        boxShadow: card.elevation != null
            ? [
                BoxShadow(
                  color: isDark
                      ? const Color(0xFF000000).withOpacity(0.3)
                      : const Color(0xFF000000).withOpacity(0.1),
                  blurRadius: card.elevation! * 2,
                  offset: Offset(0, card.elevation!),
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: card.child,
      ),
    );
  }
}
