import 'package:flutter/material.dart';

/// Animated gradient background inspired by CSS keyframe gradients.
class AnimatedGradientBackground extends StatefulWidget {
  final Widget child;

  const AnimatedGradientBackground({
    super.key,
    required this.child,
  });

  @override
  State<AnimatedGradientBackground> createState() =>
      _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState
    extends State<AnimatedGradientBackground> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15), // Slower animation
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    // Use AnimatedBuilder with lower frame rate by checking value changes
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final progress = _controller.value;
        final colors = _buildAnimatedColors(progress);

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: colors,
            ),
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Color> _buildAnimatedColors(double progress) {
    const saturation = 0.4;
    const value = 1.0;
    const colorCount = 5;

    return List<Color>.generate(colorCount, (index) {
      final hue = (progress * 360 + index * (360 / colorCount)) % 360;
      return HSVColor.fromAHSV(1, hue, saturation, value).toColor();
    });
  }
}

