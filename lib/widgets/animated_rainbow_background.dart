import 'package:flutter/material.dart';

/// Full-screen animated rainbow gradient inspired by the provided CSS.
/// Colors cycle over time, but the gradient itself does not "slide".
class AnimatedRainbowBackground extends StatefulWidget {
  final Widget child;

  const AnimatedRainbowBackground({super.key, required this.child});

  @override
  State<AnimatedRainbowBackground> createState() =>
      _AnimatedRainbowBackgroundState();
}

class _AnimatedRainbowBackgroundState extends State<AnimatedRainbowBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      // Faster, smoother lockscreen-style animation
      duration: const Duration(seconds: 15),
    )..repeat();
    
    // Smooth, elegant curve for lockscreen feel
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final t = _animation.value; // 0..1
        // Shift hue over time for a smooth rainbow loop.
        final baseHue = (t * 360.0) % 360.0;

        List<Color> _rainbowColors() {
          const count = 13;
          return List<Color>.generate(count, (index) {
            final hue = (baseHue + (index * 360.0 / (count - 1))) % 360.0;
            // Lighter, whiter lockscreen look: low saturation (0.25), high brightness (0.98)
            return HSVColor.fromAHSV(1.0, hue, 0.25, 0.98).toColor();
          });
        }

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: _rainbowColors(),
            ),
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}


