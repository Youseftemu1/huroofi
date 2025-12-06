import 'package:flutter/widgets.dart';

/// Provides a simple scaling helper so UI elements look consistent across
/// devices with different logical widths and pixel densities.
class UiScale {
  static const double _baseWidth = 390.0;
  static const double _minScale = 0.85;
  static const double _maxScale = 1.12;

  final double scale;
  final double textScale;

  const UiScale._(this.scale, this.textScale);

  factory UiScale.of(BuildContext context) {
    final media = MediaQuery.of(context);
    final width = media.size.width;
    final baseScale = (width / _baseWidth).clamp(_minScale, _maxScale);
    final textScale = (baseScale * 0.7 + media.textScaleFactor * 0.3)
        .clamp(_minScale, _maxScale);
    return UiScale._(baseScale, textScale);
  }

  double size(double value) => value * scale;

  double spacing(double value) => value * scale;

  double font(double value) => value * textScale;
}

