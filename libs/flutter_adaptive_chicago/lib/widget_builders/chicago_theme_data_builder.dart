import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class ChicagoThemeDataBuilder
    extends AdaptiveComponentBuilder<AdaptiveThemeData, dynamic> {
  @override
  CupertinoThemeData? build(BuildContext context, AdaptiveThemeData component) {
    return CupertinoThemeData(
      brightness: component.brightness,
    );
  }
}
