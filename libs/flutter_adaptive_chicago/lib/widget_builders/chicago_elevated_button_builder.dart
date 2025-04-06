import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chicago/chicago.dart' hide brighten, darken;
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import 'package:flutter_adaptive_chicago/utils/colors.dart';
// Licensed to the Apache Software Foundation (ASF) under one or more
// contributor license agreements.  See the NOTICE file distributed with
// this work for additional information regarding copyright ownership.
// The ASF licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

class ChicagoElevatedButtonBuilder
    extends AdaptiveWidgetBuilder<AdaptiveElevatedButton> {
  @override
  Widget build(BuildContext context, AdaptiveElevatedButton widget) {
    return _ChicagoElevatedButton(
      onPressed: widget.onPressed,
      child: widget.child,
    );
  }
}

class _ChicagoElevatedButton extends StatefulWidget {
  const _ChicagoElevatedButton({
    Key? key,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget child;

  @override
  _ChicagoElevatedButtonState createState() => _ChicagoElevatedButtonState();
}

class _ChicagoElevatedButtonState extends State<_ChicagoElevatedButton> {
  bool hover = false;
  bool pressed = false;
  bool focused = false;
  FocusNode? focusNode;

  static const EdgeInsets _defaultPadding = EdgeInsets.fromLTRB(3, 4, 4, 5);

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
    
    // Determine button colors based on state
    Color backgroundColor;
    Color borderColor;
    Color textColor;
    
    if (!isEnabled) {
      backgroundColor = colors.buttonDisabledBackgroundColor;
      borderColor = colors.buttonDisabledBorderColor;
      textColor = colors.disabledTextColor;
    } else if (pressed) {
      backgroundColor = colors.buttonHighlightColor;
      borderColor = colors.buttonHighlightBorderColor;
      textColor = Colors.white;
    } else if (hover) {
      backgroundColor = brighten(colors.buttonBackgroundColor);
      borderColor = colors.buttonBorderColor;
      textColor = colors.textColor;
    } else {
      backgroundColor = colors.buttonBackgroundColor;
      borderColor = colors.buttonBorderColor;
      textColor = colors.textColor;
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
      padding: _defaultPadding,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        gradient: gradient,
      ),
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: textColor,
            ),
        child: widget.child,
      ),
    );
    
    if (focused) {
      button = Stack(
        children: [
          button,
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                border: Border.all(color: colors.buttonBorderColor),
              ),
            ),
          ),
        ],
      );
    }
    
    button = Actions(
      actions: <Type, Action<Intent>>{
        ActivateIntent: CallbackAction<ActivateIntent>(
          onInvoke: (ActivateIntent intent) {
            if (isEnabled) {
              widget.onPressed!();
            }
            return null;
          },
        ),
      },
      child: Focus(
        canRequestFocus: isEnabled,
        descendantsAreFocusable: isEnabled,
        focusNode: focusNode,
        onKeyEvent: _handleKey,
        onFocusChange: _handleFocusChange,
        child: button,
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

    return button;
  }
}
