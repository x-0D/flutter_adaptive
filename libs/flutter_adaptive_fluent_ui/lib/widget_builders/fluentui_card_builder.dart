import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class FluentUICardBuilder extends AdaptiveWidgetBuilder<AdaptiveCard> {
  @override
  Widget build(BuildContext context, AdaptiveCard component) {
    return Container(
      margin: component.margin ?? const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: component.color ?? FluentTheme.of(context).cardColor,
        borderRadius: BorderRadius.circular(4.0), // Fluent UI corner radius
        border: Border.all(
          color: FluentTheme.of(context).resources.cardStrokeColorDefault,
          width: 1.0,
        ),
        boxShadow: _getFluentShadow(component.elevation, context),
      ),
      clipBehavior: component.clipBehavior ?? Clip.antiAlias,
      child: component.child,
    );
  }

  List<BoxShadow> _getFluentShadow(double? elevation, BuildContext context) {
    if (elevation == null || elevation <= 0) return [];
    return [
      BoxShadow(
        color: FluentTheme.of(context).shadowColor.withOpacity(0.14),
        blurRadius: elevation * 1.5,
        offset: Offset(0, elevation * 0.5),
      ),
    ];
  }
}
