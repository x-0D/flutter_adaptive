import 'package:flutter/material.dart';
import 'package:chicago/chicago.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class ChicagoAppBuilder extends AdaptiveWidgetBuilder<AdaptiveApp> {
  @override
  Widget build(BuildContext context, AdaptiveApp component) {
    return ChicagoApp(
      key: component.key,
      title: component.title ?? 'Chicago App',
      home: component.home,
    );
  }
}
