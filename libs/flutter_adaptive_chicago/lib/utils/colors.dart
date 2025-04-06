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

import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Base colors used throughout the Chicago package
class ChicagoColors {
  // Light theme colors
  static const Color lightTextColor = Color(0xff000000);
  static const Color lightDisabledTextColor = Color(0xff999999);
  static const Color lightButtonBackgroundColor = Color(0xffe0e0e0);
  static const Color lightButtonBorderColor = Color(0xff808080);
  static const Color lightButtonDisabledBackgroundColor = Color(0xffdddcd5);
  static const Color lightButtonDisabledBorderColor = Color(0xff999999);
  static const Color lightButtonHighlightColor =
      Color.fromARGB(255, 75, 125, 175);
  static const Color lightButtonHighlightBorderColor =
      Color.fromARGB(255, 60, 95, 131);
  static const Color lightAppBarBackgroundColor = Color(0xff3c77b2);
  static const Color lightAppBarForegroundColor = Color(0xffffffff);
  static const Color lightBackgroundColor = Color(0xfff0f0f0);
  static const Color lightSurfaceColor = Color(0xffffffff);
  static const Color lightDividerColor = Color(0xffe0e0e0);

  // Windows XP theme colors
  static const Color windowsXPBlue = Color(0xFF3B7CBD);
  static const Color windowsXPLightBlue = Color(0xFF5A9AE1);
  static const Color windowsXPDarkBlue = Color(0xFF2D6DBE);
  static const Color windowsXPGreen = Color(0xFF60B044);
  static const Color windowsXPSilver = Color(0xFFF0F0F0);
  static const Color windowsXPGrey = Color(0xFFD4D0C8);
  static const Color windowsXPBorderBlue = Color(0xFF3A6EA5);

  // Dark theme colors
  static const Color darkTextColor = Color(0xffffffff);
  static const Color darkDisabledTextColor = Color(0xff808080);
  static const Color darkButtonBackgroundColor = Color(0xff404040);
  static const Color darkButtonBorderColor = Color(0xff606060);
  static const Color darkButtonDisabledBackgroundColor = Color(0xff303030);
  static const Color darkButtonDisabledBorderColor = Color(0xff505050);
  static const Color darkButtonHighlightColor =
      Color.fromARGB(255, 60, 100, 140);
  static const Color darkButtonHighlightBorderColor =
      Color.fromARGB(255, 45, 70, 95);
  static const Color darkAppBarBackgroundColor = Color(0xff2c4f7c);
  static const Color darkAppBarForegroundColor = Color(0xffffffff);
  static const Color darkBackgroundColor = Color(0xff202020);
  static const Color darkSurfaceColor = Color(0xff303030);
  static const Color darkDividerColor = Color(0xff404040);

  // Common opacity values
  static const double progressIndicatorOpacity = 0.24;
  static const double listTileSelectedOpacity = 0.12;
}

/// Theme-specific colors based on brightness
class ChicagoThemeColors {
  final Color textColor;
  final Color disabledTextColor;
  final Color buttonBackgroundColor;
  final Color buttonBorderColor;
  final Color buttonDisabledBackgroundColor;
  final Color buttonDisabledBorderColor;
  final Color buttonHighlightColor;
  final Color buttonHighlightBorderColor;
  final Color appBarBackgroundColor;
  final Color appBarForegroundColor;
  final Color backgroundColor;
  final Color surfaceColor;
  final Color dividerColor;

  const ChicagoThemeColors({
    required this.textColor,
    required this.disabledTextColor,
    required this.buttonBackgroundColor,
    required this.buttonBorderColor,
    required this.buttonDisabledBackgroundColor,
    required this.buttonDisabledBorderColor,
    required this.buttonHighlightColor,
    required this.buttonHighlightBorderColor,
    required this.appBarBackgroundColor,
    required this.appBarForegroundColor,
    required this.backgroundColor,
    required this.surfaceColor,
    required this.dividerColor,
  });

  static ChicagoThemeColors light() {
    return const ChicagoThemeColors(
      textColor: ChicagoColors.lightTextColor,
      disabledTextColor: ChicagoColors.lightDisabledTextColor,
      buttonBackgroundColor: ChicagoColors.lightButtonBackgroundColor,
      buttonBorderColor: ChicagoColors.lightButtonBorderColor,
      buttonDisabledBackgroundColor:
          ChicagoColors.lightButtonDisabledBackgroundColor,
      buttonDisabledBorderColor: ChicagoColors.lightButtonDisabledBorderColor,
      buttonHighlightColor: ChicagoColors.lightButtonHighlightColor,
      buttonHighlightBorderColor: ChicagoColors.lightButtonHighlightBorderColor,
      appBarBackgroundColor: ChicagoColors.lightAppBarBackgroundColor,
      appBarForegroundColor: ChicagoColors.lightAppBarForegroundColor,
      backgroundColor: ChicagoColors.lightBackgroundColor,
      surfaceColor: ChicagoColors.lightSurfaceColor,
      dividerColor: ChicagoColors.lightDividerColor,
    );
  }

  static ChicagoThemeColors dark() {
    return const ChicagoThemeColors(
      textColor: ChicagoColors.darkTextColor,
      disabledTextColor: ChicagoColors.darkDisabledTextColor,
      buttonBackgroundColor: ChicagoColors.darkButtonBackgroundColor,
      buttonBorderColor: ChicagoColors.darkButtonBorderColor,
      buttonDisabledBackgroundColor:
          ChicagoColors.darkButtonDisabledBackgroundColor,
      buttonDisabledBorderColor: ChicagoColors.darkButtonDisabledBorderColor,
      buttonHighlightColor: ChicagoColors.darkButtonHighlightColor,
      buttonHighlightBorderColor: ChicagoColors.darkButtonHighlightBorderColor,
      appBarBackgroundColor: ChicagoColors.darkAppBarBackgroundColor,
      appBarForegroundColor: ChicagoColors.darkAppBarForegroundColor,
      backgroundColor: ChicagoColors.darkBackgroundColor,
      surfaceColor: ChicagoColors.darkSurfaceColor,
      dividerColor: ChicagoColors.darkDividerColor,
    );
  }
}

/// Gradients used throughout the Chicago package
class ChicagoGradients {
  /// Default button gradient (Windows XP style)
  static LinearGradient buttonDefaultGradient(ChicagoThemeColors colors) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[
        brighten(colors.buttonBackgroundColor),
        colors.buttonBackgroundColor,
        darken(colors.buttonBackgroundColor),
      ],
    );
  }

  /// Button highlight gradient
  static LinearGradient buttonHighlightGradient(ChicagoThemeColors colors) {
    return LinearGradient(
      begin: Alignment(0, 0.2),
      end: Alignment.topCenter,
      colors: <Color>[
        colors.buttonHighlightColor,
        brighten(colors.buttonHighlightColor),
      ],
    );
  }

  /// Button pressed gradient
  static LinearGradient buttonPressedGradient(ChicagoThemeColors colors) {
    return LinearGradient(
      begin: Alignment.center,
      end: Alignment.topCenter,
      colors: <Color>[
        colors.buttonHighlightColor,
        darken(colors.buttonHighlightColor),
      ],
    );
  }

  /// Checkbox default gradient (Windows XP style)
  static LinearGradient checkboxDefaultGradient(ChicagoThemeColors colors) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[
        Colors.white,
        Color(0xFFF5F5F5),
      ],
    );
  }

  /// Checkbox hover gradient
  static LinearGradient checkboxHoverGradient(ChicagoThemeColors colors) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[
        Colors.white,
        Color(0xFFF8F8F8),
      ],
    );
  }

  /// Checkbox checked gradient (Windows XP blue style)
  static LinearGradient checkboxCheckedGradient(ChicagoThemeColors colors) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[
        Color(0xFF4A8AD0), // Top left (lighter blue)
        Color(0xFF2D6DBE), // Bottom right (darker blue)
      ],
    );
  }

  /// Checkbox checked hover gradient
  static LinearGradient checkboxCheckedHoverGradient(
      ChicagoThemeColors colors) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[
        Color(0xFF5A9AE1), // Top left (lighter blue)
        Color(0xFF3D7DCE), // Bottom right (darker blue)
      ],
    );
  }
}

/// Chicago theme data
class ChicagoThemeData extends ThemeExtension<ChicagoThemeData> {
  final ChicagoThemeColors colors;
  final Brightness brightness;

  const ChicagoThemeData({
    required this.colors,
    required this.brightness,
  });

  static ChicagoThemeData light() {
    return ChicagoThemeData(
      colors: ChicagoThemeColors.light(),
      brightness: Brightness.light,
    );
  }

  static ChicagoThemeData dark() {
    return ChicagoThemeData(
      colors: ChicagoThemeColors.dark(),
      brightness: Brightness.dark,
    );
  }

  @override
  ThemeExtension<ChicagoThemeData> copyWith({
    ChicagoThemeColors? colors,
    Brightness? brightness,
  }) {
    return ChicagoThemeData(
      colors: colors ?? this.colors,
      brightness: brightness ?? this.brightness,
    );
  }

  @override
  ThemeExtension<ChicagoThemeData> lerp(
    ThemeExtension<ChicagoThemeData>? other,
    double t,
  ) {
    if (other is! ChicagoThemeData) {
      return this;
    }
    return ChicagoThemeData(
      colors: colors,
      brightness: brightness,
    );
  }
}

/// Utility functions for color manipulation
Color brighten(Color color, [double amount = 0.1]) {
  return _adjustBrightness(color, amount);
}

Color darken(Color color, [double amount = 0.1]) {
  return _adjustBrightness(color, -amount);
}

Color _adjustBrightness(Color color, double adjustment) {
  HSVColor hsv = HSVColor.fromColor(color);
  HSVColor adjusted = HSVColor.fromAHSV(
    hsv.alpha,
    hsv.hue,
    hsv.saturation,
    math.min(math.max(hsv.value + adjustment, 0), 1),
  );
  return adjusted.toColor();
}
