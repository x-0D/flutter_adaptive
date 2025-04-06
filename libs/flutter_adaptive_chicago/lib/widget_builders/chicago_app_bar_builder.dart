import 'package:flutter/material.dart';
import 'package:chicago/chicago.dart' hide darken, brighten;

import 'package:flutter_adaptive_chicago/utils/colors.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class ChicagoAppBarBuilder extends AdaptiveWidgetBuilder<AdaptiveAppBar> {
  @override
  Widget build(BuildContext context, AdaptiveAppBar component) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            ChicagoColors.windowsXPLightBlue,
            ChicagoColors.windowsXPBlue,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 2.0,
            offset: Offset(0, 1),
          ),
        ],
        border: Border(
          bottom: BorderSide(
            color: ChicagoColors.windowsXPBorderBlue,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        children: [
          if (component.leading != null) component.leading!,
          Expanded(
            child: component.title ?? SizedBox(),
          ),
          if (component.actions != null)
            Row(
              children: component.actions!
                  .map((action) => IconButton(
                        onPressed: action.onPressed,
                        icon: action.icon,
                        tooltip: action.label is Text
                            ? (action.label as Text).data
                            : null,
                      ))
                  .toList(),
            ),
        ],
      ),
    );
  }
}
