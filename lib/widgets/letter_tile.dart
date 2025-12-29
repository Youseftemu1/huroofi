import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/ui_scale.dart';

class LetterTile extends StatelessWidget {
  final String letter;
  final Color color;
  final VoidCallback? onTap;
  final bool isSelected;
  final VoidCallback onDragStart;
  final bool isDragging;

  const LetterTile({
    super.key,
    required this.letter,
    required this.color,
    this.onTap,
    this.isSelected = false,
    required this.onDragStart,
    required this.isDragging,
  });

  @override
  Widget build(BuildContext context) {
    final ui = UiScale.of(context);
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;
    
    // Calculate tile size based on available space and screen dimensions
    // Limit tile size to prevent it from being too large on certain devices
    final double baseTileSize = ui.size(96);
    final double maxTileSize = math.min(screenWidth * 0.15, screenHeight * 0.12);
    final double tileSize = math.min(baseTileSize, maxTileSize).clamp(70.0, 96.0);
    
    // Scale font size proportionally to tile size
    final double fontSize = (tileSize / 96) * ui.font(44);
    final double tileSpacing = ui.spacing(12);

    final tileWidget = AnimatedContainer(
      duration: const Duration(milliseconds: 280),
      width: tileSize,
      height: tileSize,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isSelected ? 0.18 : 0.12),
            blurRadius: isSelected ? 12 : 9,
            offset: const Offset(0, 3),
            spreadRadius: 0,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 250),
            style: TextStyle(
              fontFamily: 'ArialKids',
              fontSize: fontSize * 1.05,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.35),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(letter),
          ),
        ),
      ),
    );

    final Widget borderedTile =
        isSelected ? _RainbowTileOutline(child: tileWidget) : tileWidget;

    final paddedTile = Padding(
      padding: EdgeInsets.only(bottom: tileSpacing),
      child: borderedTile,
    );

    if (onTap != null) {
      return paddedTile;
    } else {
      return Draggable<String>(
        data: letter,
        feedback: Material(
          color: Colors.transparent,
          child: Transform.scale(
            scale: 1.1,
            child: Container(
              width: tileSize,
              height: tileSize,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 14,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  letter,
                  style: TextStyle(
                    fontFamily: 'ArialKids',
                    fontSize: fontSize * 1.05,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ),
        childWhenDragging: Padding(
          padding: EdgeInsets.only(bottom: tileSpacing),
          child: Container(
            width: tileSize,
            height: tileSize,
            decoration: BoxDecoration(
              color: color.withOpacity(0.25),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: color.withOpacity(0.45),
                width: 2,
              ),
            ),
          ),
        ),
        onDragStarted: onDragStart,
        child: paddedTile,
      );
    }
  }
}

class _RainbowTileOutline extends StatefulWidget {
  final Widget child;

  const _RainbowTileOutline({required this.child});

  @override
  State<_RainbowTileOutline> createState() => _RainbowTileOutlineState();
}

class _RainbowTileOutlineState extends State<_RainbowTileOutline>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  static const double _borderWidth = 3.0;
  static const BorderRadius _radius = BorderRadius.all(Radius.circular(22));

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _TileRainbowPainter(
            progress: _controller.value,
            borderWidth: _borderWidth,
            borderRadius: _radius,
          ),
          child: Padding(
            padding: const EdgeInsets.all(_borderWidth + 1.5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                (_radius.topLeft.x - _borderWidth).clamp(0.0, double.infinity),
              ),
              child: child,
            ),
          ),
        );
      },
      child: widget.child,
    );
  }
}

class _TileRainbowPainter extends CustomPainter {
  final double progress;
  final double borderWidth;
  final BorderRadius borderRadius;

  _TileRainbowPainter({
    required this.progress,
    required this.borderWidth,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final inset = borderWidth / 2;

    Radius shrink(Radius r) => Radius.circular(math.max(0, r.x - inset));

    final rrect = RRect.fromRectAndCorners(
      Rect.fromLTWH(
        inset,
        inset,
        size.width - borderWidth,
        size.height - borderWidth,
      ),
      topLeft: shrink(borderRadius.topLeft),
      topRight: shrink(borderRadius.topRight),
      bottomLeft: shrink(borderRadius.bottomLeft),
      bottomRight: shrink(borderRadius.bottomRight),
    );

    final shader = LinearGradient(
      colors: const [
        Color(0xFFFF5F6D),
        Color(0xFFFFC371),
        Color(0xFFFFFF6B),
        Color(0xFF66FF99),
        Color(0xFF62E0FF),
        Color(0xFF8C86FF),
        Color(0xFFFF8CFF),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      tileMode: TileMode.mirror,
      transform: _TileSlidingGradientTransform(progress),
    ).createShader(rect);

    final paint = Paint()
      ..shader = shader
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant _TileRainbowPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.borderWidth != borderWidth ||
        oldDelegate.borderRadius != borderRadius;
  }
}

class _TileSlidingGradientTransform extends GradientTransform {
  final double slidePercent;

  const _TileSlidingGradientTransform(this.slidePercent);

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    final dx = bounds.width * slidePercent * 2;
    final dy = bounds.height * slidePercent * 2;
    return Matrix4.translationValues(dx, dy, 0);
  }
}