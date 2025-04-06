import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:chicago/chicago.dart' as chicago;
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import 'package:flutter_adaptive_chicago/utils/colors.dart';

class ChicagoTextInputBuilder extends AdaptiveWidgetBuilder<AdaptiveTextInput> {
  @override
  Widget build(BuildContext context, AdaptiveTextInput component) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors =
        isDark ? ChicagoThemeColors.dark() : ChicagoThemeColors.light();

    return Container(
      height: 22,
      padding: const EdgeInsets.symmetric(vertical: 1),
      decoration: BoxDecoration(
        border: Border.all(color: colors.buttonBorderColor),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            brighten(colors.surfaceColor),
            colors.surfaceColor,
            darken(colors.surfaceColor),
          ],
        ),
      ),
      child: TextField(
        decoration: InputDecoration(
          isDense: true,
          hintText: component.placeholder,
          hintStyle: TextStyle(
            color: colors.disabledTextColor,
            fontSize: 12,
            height: 1.0,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 4),
          border: InputBorder.none,
        ),
        controller: component.controller,
        onChanged: component.onChanged,
        focusNode: component.focusNode,
        keyboardType: component.keyboardType,
        textInputAction: component.textInputAction,
        textCapitalization: component.textCapitalization,
        style: (component.style?.copyWith(
              color: colors.textColor,
              fontSize: 12,
              height: 1.0,
            ) ??
            Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colors.textColor,
                  fontSize: 12,
                  height: 1.0,
                )),
        strutStyle: component.strutStyle,
        textAlign: component.textAlign,
        textAlignVertical: TextAlignVertical.center,
        readOnly: component.readOnly,
        showCursor: component.showCursor,
        autofocus: component.autofocus,
        obscuringCharacter: component.obscuringCharacter,
        obscureText: component.obscureText,
        autocorrect: component.autocorrect,
        smartDashesType: component.smartDashesType,
        smartQuotesType: component.smartQuotesType,
        enableSuggestions: component.enableSuggestions,
        maxLines: component.maxLines,
        minLines: component.minLines,
        expands: component.expands,
        maxLength: component.maxLength,
        maxLengthEnforcement: component.maxLengthEnforcement,
        onEditingComplete: component.onEditingComplete,
        onSubmitted: component.onSubmitted,
        inputFormatters: component.inputFormatters,
        enabled: component.enabled ?? true,
        cursorWidth: 1,
        cursorHeight: 14,
        cursorRadius: const Radius.circular(1.0),
        cursorColor: colors.textColor,
        selectionHeightStyle: component.selectionHeightStyle,
        selectionWidthStyle: component.selectionWidthStyle,
        keyboardAppearance: component.keyboardAppearance,
        scrollPadding: component.scrollPadding,
        dragStartBehavior: component.dragStartBehavior,
        enableInteractiveSelection: component.enableInteractiveSelection,
        selectionControls: component.selectionControls,
        onTap: component.onTap,
        scrollController: component.scrollController,
        scrollPhysics: component.scrollPhysics,
        autofillHints: component.autofillHints,
        restorationId: component.restorationId,
        contextMenuBuilder: component.contextMenuBuilder,
      ),
    );
  }
}
