import 'package:flutter/material.dart';
import 'package:chicago/chicago.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import 'package:flutter_adaptive_chicago/utils/colors.dart';

class ChicagoModalDialogBuilder<T>
    extends AdaptiveFunctionBuilder<AdaptiveModalDialog<T>, T> {
  @override
  Future<T?> build(BuildContext context, AdaptiveModalDialog<T> component) {
    return showDialog<T>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: ChicagoColors.lightBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
            side: BorderSide(
              color: ChicagoColors.lightBackgroundColor,
              width: 1.0,
            ),
          ),
          title: component.title,
          content: component.content,
          actions: <Widget>[
            if (component.secondaryButton != null)
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                onPressed: component.secondaryButton!.onPressed,
                child: component.secondaryButton!.child,
              ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
              onPressed: component.primaryButton.onPressed,
              child: component.primaryButton.child,
            ),
          ],
        );
      },
      barrierDismissible: component.barrierDismissible,
      useRootNavigator: component.useRootNavigator,
      routeSettings: component.routeSettings,
      barrierLabel: component.barrierLabel,
    );
  }
}
