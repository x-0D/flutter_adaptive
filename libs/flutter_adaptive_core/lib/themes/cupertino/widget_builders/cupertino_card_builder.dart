import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class CupertinoCardBuilder extends AdaptiveWidgetBuilder<AdaptiveCard> {
  @override
  Widget build(BuildContext context, AdaptiveCard component) {
    return Container(
      margin: component.margin ?? const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: component.color ??
            CupertinoColors.systemBackground.resolveFrom(context),
        borderRadius: _getBorderRadius(component.shape),
        boxShadow:
            _getBoxShadow(component.elevation, component.shadowColor, context),
      ),
      clipBehavior: component.clipBehavior ?? Clip.none,
      child: component.child,
    );
  }

  BorderRadius _getBorderRadius(ShapeBorder? shape) {
    if (shape is RoundedRectangleBorder) {
      return shape.borderRadius as BorderRadius;
    }
    return BorderRadius.circular(8.0); // iOS default corner radius
  }

  List<BoxShadow> _getBoxShadow(
      double? elevation, Color? shadowColor, BuildContext context) {
    if (elevation == null || elevation <= 0) return [];
    return [
      BoxShadow(
        color: (shadowColor ?? CupertinoColors.systemGrey.resolveFrom(context))
            .withOpacity(0.2),
        blurRadius: elevation * 2,
        offset: Offset(0, elevation),
      ),
    ];
  }
}
