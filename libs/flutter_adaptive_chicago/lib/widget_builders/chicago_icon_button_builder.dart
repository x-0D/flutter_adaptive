import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chicago/chicago.dart' hide brighten, darken;
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import 'package:flutter_adaptive_chicago/utils/colors.dart';

class ChicagoIconButtonBuilder
    extends AdaptiveWidgetBuilder<AdaptiveIconButton> {
  @override
  Widget build(BuildContext context, AdaptiveIconButton widget) {
    return _ChicagoIconButton(
      onPressed: widget.onPressed,
      icon: widget.icon,
    );
  }
}

class _ChicagoIconButton extends StatefulWidget {
  const _ChicagoIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  _ChicagoIconButtonState createState() => _ChicagoIconButtonState();
}

class _ChicagoIconButtonState extends State<_ChicagoIconButton> {
  bool hover = false;
  bool pressed = false;
  bool focused = false;
  FocusNode? focusNode;

  void _handleFocusChange(bool hasFocus) {
    setState(() {
      focused = hasFocus;
      if (!hasFocus) {
        pressed = false;
      }
    });
  }

  bool isActivateKey(LogicalKeyboardKey key) {
    return key == LogicalKeyboardKey.enter || key == LogicalKeyboardKey.space;
  }

  KeyEventResult _handleKey(FocusNode focusNode, KeyEvent event) {
    if (isActivateKey(event.logicalKey)) {
      setState(() {
        pressed = event is KeyDownEvent;
      });
    }
    return KeyEventResult.ignored;
  }

  bool get isEnabled => widget.onPressed != null;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode(canRequestFocus: isEnabled);
  }

  @override
  void dispose() {
    focusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chicagoTheme = Theme.of(context).extension<ChicagoThemeData>();
    final colors = chicagoTheme?.colors ?? ChicagoThemeColors.light();
    
    // Button dimensions
    const double buttonSize = 32.0;
    const double iconSize = 16.0;
    
    // Determine button colors based on state
    Color backgroundColor;
    Color borderColor;
    Color iconColor;
    
    if (!isEnabled) {
      backgroundColor = colors.buttonDisabledBackgroundColor;
      borderColor = colors.buttonDisabledBorderColor;
      iconColor = colors.disabledTextColor;
    } else if (pressed) {
      backgroundColor = colors.buttonHighlightColor;
      borderColor = colors.buttonHighlightBorderColor;
      iconColor = Colors.white;
    } else if (hover) {
      backgroundColor = brighten(colors.buttonBackgroundColor);
      borderColor = colors.buttonBorderColor;
      iconColor = colors.textColor;
    } else {
      backgroundColor = colors.buttonBackgroundColor;
      borderColor = colors.buttonBorderColor;
      iconColor = colors.textColor;
    }
    
    // Create gradient based on state
    LinearGradient gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        brighten(backgroundColor),
        backgroundColor,
        darken(backgroundColor),
      ],
    );
    
    Widget button = Container(
      width: buttonSize,
      height: buttonSize,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        gradient: gradient,
      ),
      child: IconTheme(
        data: IconThemeData(color: iconColor, size: iconSize),
        child: widget.icon,
      ),
    );
    
    if (isEnabled) {
      button = MouseRegion(
        onEnter: (_) => setState(() => hover = true),
        onExit: (_) => setState(() => hover = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTapDown: (_) => setState(() => pressed = true),
          onTapUp: (_) => setState(() => pressed = false),
          onTapCancel: () => setState(() => pressed = false),
          onTap: widget.onPressed,
          child: button,
        ),
      );
    }
    
    return Focus(
      focusNode: focusNode,
      onFocusChange: _handleFocusChange,
      onKeyEvent: _handleKey,
      child: button,
    );
  }
}
