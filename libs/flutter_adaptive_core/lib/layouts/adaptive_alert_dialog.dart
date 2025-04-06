import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' show showDialog;
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

/// A platform-adaptive alert dialog that follows platform-specific design guidelines.
///
/// On Windows, it follows Fluent Design guidelines.
/// On macOS, it follows Apple Human Interface Guidelines.
/// On Linux, it follows GNOME Human Interface Guidelines.
class AdaptiveAlertDialog<T> extends AdaptiveFunction<T> {
  const AdaptiveAlertDialog({
    required this.title,
    required this.content,
    required this.actions,
    this.semanticLabel,
    this.barrierDismissible = true,
    this.useRootNavigator = true,
    this.routeSettings,
    this.barrierLabel,
  });

  /// The title of the dialog is displayed at the top of the dialog.
  ///
  /// Typically a [Text] widget with a [TextStyle.headlineSmall] style.
  final Widget title;

  /// The content of the dialog is displayed in the center of the dialog.
  ///
  /// Typically a [Text] widget with a [TextStyle.bodyMedium] style.
  final Widget content;

  /// The set of actions that are displayed at the bottom of the dialog.
  ///
  /// Typically this is a list of [AdaptiveAlertDialogAction] widgets.
  final List<AdaptiveAlertDialogAction> actions;

  /// The semantic label of the dialog used by accessibility frameworks to
  /// announce the dialog when it is shown.
  ///
  /// If this label is not provided, it will fall back to [title]'s text.
  final String? semanticLabel;

  /// Whether the dialog can be dismissed by tapping the barrier.
  final bool barrierDismissible;

  /// Whether to use the root navigator.
  final bool useRootNavigator;

  /// The settings for this route.
  final RouteSettings? routeSettings;

  /// The semantic label used for a dismissible barrier.
  final String? barrierLabel;

  @override
  Future<T?> build(BuildContext context) async {
    final result = await showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      barrierLabel: semanticLabel ?? barrierLabel,
      builder: (context) => AdaptiveAlertDialogContent(
        title: title,
        content: content,
        actions: actions,
        semanticLabel: semanticLabel,
      ),
    );
    return result;
  }
}

/// The content of an [AdaptiveAlertDialog].
class AdaptiveAlertDialogContent extends AdaptiveWidget {
  const AdaptiveAlertDialogContent({
    super.key,
    required this.title,
    required this.content,
    required this.actions,
    this.semanticLabel,
  });

  /// The title of the dialog is displayed at the top of the dialog.
  ///
  /// Typically a [Text] widget with a [TextStyle.headlineSmall] style.
  final Widget title;

  /// The content of the dialog is displayed in the center of the dialog.
  ///
  /// Typically a [Text] widget with a [TextStyle.bodyMedium] style.
  final Widget content;

  /// The set of actions that are displayed at the bottom of the dialog.
  ///
  /// Typically this is a list of [AdaptiveAlertDialogAction] widgets.
  final List<AdaptiveAlertDialogAction> actions;

  /// The semantic label of the dialog used by accessibility frameworks to
  /// announce the dialog when it is shown.
  ///
  /// If this label is not provided, it will fall back to [title]'s text.
  final String? semanticLabel;
}

/// A button that is part of an [AdaptiveAlertDialog].
class AdaptiveAlertDialogAction extends AdaptiveWidget {
  const AdaptiveAlertDialogAction({
    super.key,
    required this.onPressed,
    required this.child,
    this.isDefaultAction = false,
    this.isDestructiveAction = false,
  });

  /// The callback that is called when the button is pressed.
  final VoidCallback onPressed;

  /// The widget to display inside the button.
  ///
  /// Typically a [Text] widget with a [TextStyle.labelLarge] style.
  final Widget child;

  /// Whether this action is the default action for the dialog.
  ///
  /// On Windows, this will make the button the default button.
  /// On macOS, this will make the button the default button.
  /// On Linux, this will make the button the default button.
  final bool isDefaultAction;

  /// Whether this action is a destructive action.
  ///
  /// On Windows, this will make the button red.
  /// On macOS, this will make the button red.
  /// On Linux, this will make the button red.
  final bool isDestructiveAction;
}

/// Shows a platform-adaptive alert dialog.
///
/// The [context] argument is used to look up the [Navigator] and [Theme] for the
/// dialog. It is only used when the method returns. It can be null, but must not
/// be null when the method returns.
///
/// The [barrierDismissible] argument is used to indicate whether tapping on the
/// barrier will dismiss the dialog. It is true by default and can not be null.
///
/// The [useRootNavigator] argument is used to determine whether to push the
/// dialog to the [Navigator] furthest from or nearest to the given [context]. It
/// is true by default and can not be null.
///
/// The [routeSettings] argument is used to configure the settings for this
/// route. See [RouteSettings] for more details.
///
/// The [barrierLabel] argument is the semantic label used for a dismissible
/// barrier. If not provided, it will be automatically generated.
///
/// The [builder] argument is used to build the dialog's content. It is required.
Future<T?> showAdaptiveAlertDialog<T>({
  required BuildContext context,
  required Widget title,
  required Widget content,
  required List<AdaptiveAlertDialogAction> actions,
  String? semanticLabel,
  bool barrierDismissible = true,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  String? barrierLabel,
}) {
  return AdaptiveAlertDialog<T>(
    title: title,
    content: content,
    actions: actions,
    semanticLabel: semanticLabel,
    barrierDismissible: barrierDismissible,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
    barrierLabel: barrierLabel,
  ).build(context);
}
