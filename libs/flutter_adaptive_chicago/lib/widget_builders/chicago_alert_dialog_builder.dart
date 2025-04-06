import 'package:flutter/material.dart';
import 'package:chicago/chicago.dart' hide darken, brighten;

import 'package:flutter_adaptive_chicago/utils/colors.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import 'package:flutter_adaptive_core/layouts/adaptive_alert_dialog.dart';

class ChicagoAlertDialogBuilder<T>
    extends AdaptiveFunctionBuilder<AdaptiveAlertDialog<T>, T> {
  @override
  Future<T?> build(BuildContext context, AdaptiveAlertDialog<T> component) {
    return showDialog<T>(
      context: context,
      builder: (context) {
        return Material(
          type: MaterialType.canvas,
          color: const Color(0xebf6f4ed),
          elevation: 4,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              border: Border.fromBorderSide(
                  BorderSide(color: const Color(0xff999999))),
            ),
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  border: Border.fromBorderSide(
                      BorderSide(color: const Color(0xff999999))),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (component.title != null)
                      Container(
                        padding: EdgeInsets.all(13),
                        decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                          border: Border.all(
                            color: const Color(0xff999999),
                          ),
                        ),
                        child: component.title,
                      ),
                    Padding(
                      padding: EdgeInsets.all(13),
                      child: component.content,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: List<Widget>.generate(
                            component.actions.length, (int index) {
                          final action = component.actions[index];
                          return Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: CommandPushButton(
                                onPressed: action.onPressed,
                                label: (action.child as Text).data!,
                                autofocus: action.isDefaultAction,
                              ));
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      barrierDismissible: component.barrierDismissible,
      useRootNavigator: component.useRootNavigator,
      routeSettings: component.routeSettings,
      barrierLabel: component.barrierLabel,
    );
  }
}
