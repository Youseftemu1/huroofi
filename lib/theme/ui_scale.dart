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
    final height = media.size.height;
    
    // Consider both width and height for better scaling on different aspect ratios
    final widthScale = width / _baseWidth;
    final heightScale = height / 844.0; // Base height (iPhone 12/13 standard)
    final aspectRatio = width / height;
    
    // For very tall or very wide screens, adjust scaling
    double baseScale;
    if (aspectRatio < 0.45) {
      // Very tall screen (like some Samsung devices)
      baseScale = (widthScale * 0.7 + heightScale * 0.3).clamp(_minScale, _maxScale);
    } else if (aspectRatio > 0.6) {
      // Very wide screen
      baseScale = widthScale.clamp(_minScale, _maxScale);
    } else {
      // Normal aspect ratio
      baseScale = widthScale.clamp(_minScale, _maxScale);
    }
    
    final textScale = (baseScale * 0.7 + media.textScaleFactor * 0.3)
        .clamp(_minScale, _maxScale);
    return UiScale._(baseScale, textScale);
  }

  double size(double value) => value * scale;

  double spacing(double value) => value * scale;

  double font(double value) => value * textScale;
}

