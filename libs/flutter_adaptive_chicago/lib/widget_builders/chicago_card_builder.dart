import 'package:flutter/material.dart';
import 'package:chicago/chicago.dart' hide darken, brighten;

import 'package:flutter_adaptive_chicago/utils/colors.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class ChicagoCardBuilder extends AdaptiveWidgetBuilder<AdaptiveCard> {
  @override
  Widget build(BuildContext context, AdaptiveCard widget) {
    return Container(
      margin: widget.margin,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            ChicagoColors.windowsXPGrey,
            ChicagoColors.lightBackgroundColor,
          ],
        ),
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
          color: ChicagoColors.windowsXPBorderBlue,
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 2.0,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: widget.child,
      ),
    );
  }
}
