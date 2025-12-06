import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../models/letter_item.dart';
import '../theme/ui_scale.dart';

class CategorySelector extends StatelessWidget {
  final Category selectedCategory;
  final Function(Category) onCategoryChanged;

  const CategorySelector({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    final ui = UiScale.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: Category.values.map((category) {
        final isSelected = category == selectedCategory;
        final categoryColor = _categoryColor(category);

        Widget button = ElevatedButton(
          onPressed: () => onCategoryChanged(category),
          style: ElevatedButton.styleFrom(
            backgroundColor:
                isSelected ? categoryColor : Colors.white,
            foregroundColor:
                isSelected ? Colors.white : Colors.grey.shade700,
            padding: EdgeInsets.symmetric(
              horizontal: ui.spacing(20),
              vertical: ui.spacing(12),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: isSelected
                  ? BorderSide.none
                  : BorderSide(
                      color: Colors.grey.shade300,
                      width: 2,
                    ),
            ),
            elevation: isSelected ? 6 : 0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                category.emoji,
                style: TextStyle(fontSize: ui.font(20)),
              ),
              SizedBox(width: ui.spacing(8)),
              Text(
                category.displayName,
                style: TextStyle(
                  fontSize: ui.font(16),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        );

        if (isSelected) {
          button = AnimatedRainbowOutline(
            borderRadius: BorderRadius.circular(20),
            child: button,
          );
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: ui.spacing(4)),
          child: button,
        );
      }).toList(),
    );
  }

}

Color _categoryColor(Category category) {
  switch (category) {
    case Category.animals:
      return Colors.green.shade500;
    case Category.objects:
      return Colors.blue.shade500;
    case Category.nature:
      return Colors.purple.shade500;
  }
}

class AnimatedRainbowOutline extends StatefulWidget {
  final Widget child;
  final double borderWidth;
  final BorderRadius borderRadius;
  final Duration duration;

  const AnimatedRainbowOutline({
    super.key,
    required this.child,
    this.borderWidth = 3,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.duration = const Duration(seconds: 8),
  });

  @override
  State<AnimatedRainbowOutline> createState() => _AnimatedRainbowOutlineState();
}

class _AnimatedRainbowOutlineState extends State<AnimatedRainbowOutline>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
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
          painter: _ButtonRainbowPainter(
            progress: _controller.value,
            borderWidth: widget.borderWidth,
            borderRadius: widget.borderRadius,
          ),
          child: Padding(
            padding: EdgeInsets.all(widget.borderWidth + 2),
            child: ClipRRect(
              borderRadius: widget.borderRadius.subtract(
                BorderRadius.circular(widget.borderWidth),
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

class _ButtonRainbowPainter extends CustomPainter {
  final double progress;
  final double borderWidth;
  final BorderRadius borderRadius;

  _ButtonRainbowPainter({
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
      transform: GradientRotation(progress * 2 * math.pi),
    ).createShader(rect);

    final paint = Paint()
      ..shader = shader
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant _ButtonRainbowPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.borderWidth != borderWidth ||
        oldDelegate.borderRadius != borderRadius;
  }
}

