import 'package:flutter/widgets.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

/// Builder for macOS UI cards.
class MacOSUICardBuilder extends AdaptiveWidgetBuilder<AdaptiveCard> {
  @override
  Widget build(BuildContext context, AdaptiveCard card) {
    // final theme = MacosTheme.of(context);
    // final isDark = theme.brightness == Brightness.dark;

    return MacosListTile(
      title: card.child is Column
          ? (card.child as Column).children.first
          : card.child,
      subtitle:
          card.child is Column && (card.child as Column).children.length > 1
              ? (card.child as Column).children[1]
              : null,
      onClick: null,
    );
  }
}
