import 'package:flutter/material.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

/// A platform-adaptive card widget that follows platform-specific design guidelines.
class AdaptiveCard extends AdaptiveWidget {
  /// The widget to be displayed inside the card.
  final Widget child;

  /// The color of the card.
  final Color? color;

  /// The elevation of the card.
  final double? elevation;

  /// The shape of the card.
  final ShapeBorder? shape;

  /// The margin around the card.
  final EdgeInsetsGeometry? margin;

  /// Creates a platform-adaptive card.
  const AdaptiveCard({
    super.key,
    required this.child,
    this.color,
    this.elevation,
    this.shape,
    this.margin,
  });

  // @override
  // Widget build(BuildContext context) {
  //   // there's no AdaptiveBuilder in the core package
  //   return AdaptiveBuilder<AdaptiveCard>(
  //     builder: (context, theme) => theme.buildCard(context, this),
  //   );
  // }
}
