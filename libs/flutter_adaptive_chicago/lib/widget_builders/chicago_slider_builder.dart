import 'package:flutter/material.dart';
import 'package:chicago/chicago.dart' hide brighten, darken;
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import 'package:flutter_adaptive_chicago/utils/colors.dart';

class ChicagoSliderBuilder extends AdaptiveWidgetBuilder<AdaptiveSlider> {
  @override
  Widget build(BuildContext context, AdaptiveSlider widget) {
    final chicagoTheme = Theme.of(context).extension<ChicagoThemeData>();
    final colors = chicagoTheme?.colors ?? ChicagoThemeColors.light();
    final bool isEnabled = widget.onChanged != null;

    // Custom slider dimensions
    const double trackHeight = 8.0;
    const double thumbSize = 18.0;
    
    return SliderTheme(
      data: SliderThemeData(
        trackHeight: trackHeight,
        thumbShape: _ChicagoThumbShape(isEnabled: isEnabled, colors: colors),
        trackShape: _ChicagoTrackShape(isEnabled: isEnabled, colors: colors),
        overlayShape: SliderComponentShape.noOverlay,
        activeTrackColor: Colors.transparent,
        inactiveTrackColor: Colors.transparent,
        thumbColor: Colors.transparent,
        overlayColor: Colors.transparent,
        disabledThumbColor: Colors.transparent,
        disabledActiveTrackColor: Colors.transparent,
        disabledInactiveTrackColor: Colors.transparent,
      ),
      child: Slider(
        value: widget.value,
        onChanged: widget.onChanged,
      ),
    );
  }
}

// Custom thumb shape for Chicago XP style
class _ChicagoThumbShape extends SliderComponentShape {
  final bool isEnabled;
  final ChicagoThemeColors colors;

  const _ChicagoThumbShape({required this.isEnabled, required this.colors});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size.square(18.0);
  }

  @override
  void paint(PaintingContext context, Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;
    final Rect thumbRect = Rect.fromCenter(
      center: center,
      width: 18.0,
      height: 18.0,
    );

    // Thumb decoration
    final thumbPaint = Paint()..style = PaintingStyle.fill;
    
    // Gradient background
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        brighten(isEnabled ? colors.surfaceColor : colors.buttonDisabledBackgroundColor),
        isEnabled ? colors.surfaceColor : colors.buttonDisabledBackgroundColor,
        darken(isEnabled ? colors.surfaceColor : colors.buttonDisabledBackgroundColor),
      ],
    );
    
    thumbPaint.shader = gradient.createShader(thumbRect);
    canvas.drawRect(thumbRect, thumbPaint);
    
    // Border
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = isEnabled ? colors.buttonBorderColor : colors.buttonDisabledBorderColor;
    
    canvas.drawRect(thumbRect, borderPaint);
  }
}

// Custom track shape for Chicago XP style
class _ChicagoTrackShape extends RectangularSliderTrackShape {
  final bool isEnabled;
  final ChicagoThemeColors colors;

  const _ChicagoTrackShape({required this.isEnabled, required this.colors});

  @override
  void paint(PaintingContext context, Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isEnabled = true,
    bool isDiscrete = false,
    required TextDirection textDirection,
  }) {
    final Canvas canvas = context.canvas;
    
    // Track dimensions
    final trackHeight = sliderTheme.trackHeight ?? 8.0;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final trackWidth = parentBox.size.width;
    final trackRect = Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
    
    // Active track portion
    final activeTrackPaint = Paint()..style = PaintingStyle.fill;
    final double activeTrackWidth = thumbCenter.dx - trackLeft;
    final Rect activeTrackRect = Rect.fromLTWH(trackLeft, trackTop, activeTrackWidth, trackHeight);
    
    // Active track gradient
    final activeGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        brighten(colors.buttonHighlightColor),
        colors.buttonHighlightColor,
        darken(colors.buttonHighlightColor),
      ],
    );
    
    // Inactive track portion
    final inactiveTrackPaint = Paint()..style = PaintingStyle.fill;
    final double inactiveTrackWidth = trackWidth - activeTrackWidth;
    final Rect inactiveTrackRect = Rect.fromLTWH(thumbCenter.dx, trackTop, inactiveTrackWidth, trackHeight);
    
    // Inactive track gradient
    final inactiveGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        brighten(colors.buttonBackgroundColor),
        colors.buttonBackgroundColor,
        darken(colors.buttonBackgroundColor),
      ],
    );
    
    if (this.isEnabled) {
      // Draw active track with gradient
      activeTrackPaint.shader = activeGradient.createShader(activeTrackRect);
      canvas.drawRect(activeTrackRect, activeTrackPaint);
      
      // Draw inactive track with gradient
      inactiveTrackPaint.shader = inactiveGradient.createShader(inactiveTrackRect);
      canvas.drawRect(inactiveTrackRect, inactiveTrackPaint);
    } else {
      // Draw disabled track
      final disabledPaint = Paint()
        ..style = PaintingStyle.fill
        ..color = colors.buttonDisabledBackgroundColor;
      canvas.drawRect(trackRect, disabledPaint);
    }
    
    // Draw track border
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = this.isEnabled ? colors.buttonBorderColor : colors.buttonDisabledBorderColor;
    
    canvas.drawRect(trackRect, borderPaint);
  }
}
