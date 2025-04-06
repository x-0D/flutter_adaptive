import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class ChicagoModalBottomSheetBuilder<T>
    extends AdaptiveFunctionBuilder<AdaptiveModalBottomSheet<T>, T> {
  @override
  Future<T?> build(
      BuildContext context, AdaptiveModalBottomSheet<T> component) {
    return showCupertinoModalPopup<T>(
      context: context,
      barrierDismissible: component.isDismissible,
      useRootNavigator: component.useRootNavigator ?? true,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.only(top: 6.0),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (component.title != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: component.title,
                  ),
                  const Divider(height: 0),
                ],
                ...component.actions.map((action) => CupertinoButton(
                      onPressed: () {
                        action.onPressed(context);
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          if (action.leading != null) ...[
                            action.leading!,
                            const SizedBox(width: 16),
                          ],
                          Expanded(child: action.title),
                          if (action.trailing != null) ...[
                            const SizedBox(width: 16),
                            action.trailing!,
                          ],
                        ],
                      ),
                    )),
                if (component.cancelAction != null) ...[
                  const Divider(height: 0),
                  CupertinoButton(
                    onPressed: () {
                      component.cancelAction!.onPressed?.call(context);
                      Navigator.pop(context);
                    },
                    child: component.cancelAction!.title,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
