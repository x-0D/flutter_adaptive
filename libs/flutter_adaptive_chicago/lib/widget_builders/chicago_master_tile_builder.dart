import 'package:flutter/material.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import 'master_detail/master_detail_library.dart';

class ChicagoMasterTileBuilder
    extends AdaptiveWidgetBuilder<AdaptiveMasterTile> {
  @override
  Widget build(BuildContext context, AdaptiveMasterTile component) {
    // Windows XP style colors
    final Color windowsXPBlue = Color(0xFF3B7CBD);
    final Color windowsXPLightBlue = Color(0xFF5A9AE1);
    final Color windowsXPDarkBlue = Color(0xFF2D6DBE);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        gradient: component.selected == true
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  windowsXPLightBlue,
                  windowsXPDarkBlue,
                ],
              )
            : null,
        border: Border.all(
          color: component.selected == true
              ? windowsXPDarkBlue
              : Colors.transparent,
          width: 1,
        ),
      ),
      child: ListTile(
        leading: component.selected == true
            ? ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    colors: [Colors.white, Colors.white70],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ).createShader(bounds);
                },
                child: component.leading ?? const SizedBox(),
              )
            : component.leading,
        title: component.title != null
            ? DefaultTextStyle(
                style: TextStyle(
                  color:
                      component.selected == true ? Colors.white : Colors.black,
                  fontWeight: component.selected == true
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
                child: component.title!,
              )
            : null,
        subtitle: component.subtitle != null
            ? DefaultTextStyle(
                style: TextStyle(
                  color: component.selected == true
                      ? Colors.white70
                      : Colors.grey.shade700,
                  fontSize: 12,
                ),
                child: component.subtitle!,
              )
            : null,
        trailing: component.trailing,
        onTap: component.onTap,
      ),
    );
  }
}
