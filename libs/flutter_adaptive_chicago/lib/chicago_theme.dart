import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import 'package:flutter_adaptive_chicago/flutter_adaptive_chicago.dart';

/// Chicago theme bundle that provides Chicago-style widgets and theming
class ChicagoTheme extends AdaptiveBundle {
  /// Creates a Chicago theme bundle
  ChicagoTheme()
      : super(builders: {
          ChicagoAppBuilder(),
          ChicagoTextBuilder(),
          ChicagoTextInputBuilder(),
          ChicagoTextButtonBuilder(),
          ChicagoElevatedButtonBuilder(),
          ChicagoIconButtonBuilder(),
          ChicagoSliderBuilder(),
          ChicagoCheckboxBuilder(),
          ChicagoSwitchBuilder(),
          ChicagoCircularProgressIndicatorBuilder(),
          ChicagoLinearProgressIndicatorBuilder(),
          ChicagoModalDialogBuilder(),
          ChicagoContextMenuBuilder(),
          ChicagoPageBuilder(),
          ChicagoThemeDataBuilder(),
          ChicagoAppBarBuilder(),
          ChicagoNavigationBuilder(),
          ChicagoMasterDetailBuilder(),
          ChicagoDetailPageBuilder(),
          ChicagoMasterTileBuilder(),
          ChicagoListTileBuilder(),
          ChicagoAlertDialogBuilder(),
          ChicagoCardBuilder(),
        }, bundles: {
          ChicagoIcons(),
        });
}
