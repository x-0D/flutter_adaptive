import 'package:flutter/material.dart';

import 'package:chicago/chicago.dart' hide darken, brighten;
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import 'package:flutter_adaptive_chicago/utils/colors.dart';

class ChicagoPageBuilder extends AdaptiveWidgetBuilder<AdaptivePage> {
  @override
  Widget build(BuildContext context, AdaptivePage component) {
    final colors = ChicagoThemeData.light().colors;

    return Scaffold(
      appBar: component.appBar != null
          ? AppBar(
              leading: component.appBar!.leading,
              title: component.appBar!.title,
              actions: component.appBar!.actions
                  ?.map((action) => IconButton(
                        onPressed: action.onPressed,
                        icon: action.icon,
                        tooltip: action.label is Text
                            ? (action.label as Text).data
                            : null,
                      ))
                  .toList(),
              backgroundColor: colors.appBarBackgroundColor,
              foregroundColor: colors.appBarForegroundColor,
              elevation: 0,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      ChicagoColors.windowsXPLightBlue,
                      ChicagoColors.windowsXPDarkBlue,
                    ],
                  ),
                ),
              ),
            )
          : null,
      body: Container(
        color: colors.backgroundColor,
        child: component.child,
      ),
      bottomNavigationBar: component.bottomBar,
    );
  }
}
