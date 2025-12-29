import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../models/letter_item.dart';
import '../data/letter_data.dart';
import '../theme/ui_scale.dart';

enum _BurstTarget { letter, image }

class DropZone extends StatefulWidget {
  final String? droppedLetter;
  final String? selectedLetter;
  final Category selectedCategory;
  final bool showCelebration;
  final Function(String) onLetterDropped;
  final VoidCallback? onDropZoneTapped;
  final VoidCallback onReset;
  final VoidCallback onPlayLetterSound;
  final VoidCallback onPlayItemSound;
  final VoidCallback? onPlaySoundEffect;
  final VoidCallback? onPlayAllSounds;

  const DropZone({
    super.key,
    required this.droppedLetter,
    this.selectedLetter,
    required this.selectedCategory,
    required this.showCelebration,
    required this.onLetterDropped,
    this.onDropZoneTapped,
    required this.onReset,
    required this.onPlayLetterSound,
    required this.onPlayItemSound,
    this.onPlaySoundEffect,
    this.onPlayAllSounds,
  });

  @override
  State<DropZone> createState() => _DropZoneState();
}

class _DropZoneState extends State<DropZone> {
  bool _isOverDropZone = false;
  bool _showEmojiBurst = false;
  int _burstVersion = 0;
  Timer? _emojiTimer;
  _BurstTarget? _burstTarget;
  String? _burstLetter;
  List<Color> _letterColors = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emojiTimer?.cancel();
    super.dispose();
  }

  void _triggerEmojiBurst(
    _BurstTarget target, {
    String? letter,
  }) {
    _emojiTimer?.cancel();
    
    // Generate random colors for spiral letters
    final random = math.Random();
    final colorPalette = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.pink,
      Colors.teal,
      Colors.amber,
      Colors.indigo,
      Colors.cyan,
      Colors.deepPurple,
      Colors.lime,
    ];
    _letterColors = List.generate(16, (index) {
      return colorPalette[random.nextInt(colorPalette.length)];
    });

    // Update state immediately and force visual update
    setState(() {
      _burstTarget = target;
      _burstLetter = letter;
      _burstVersion++; // Increment version to force animation restart
      _showEmojiBurst = true;
    });
    
    // Force immediate frame to ensure animation starts right away
    SchedulerBinding.instance.ensureVisualUpdate();

    _emojiTimer = Timer(const Duration(milliseconds: 1600), () {
      if (!mounted) return;
      setState(() {
        _showEmojiBurst = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final items = LetterData.getLetterItems()[widget.selectedCategory] ?? {};
    final item = widget.droppedLetter != null
        ? items[widget.droppedLetter]
        : null;

    final hasSelectedLetter = widget.selectedLetter != null;
    final showDropHint = widget.droppedLetter == null && hasSelectedLetter;

    return GestureDetector(
      onTap: widget.onDropZoneTapped,
      child: DragTarget<String>(
        onWillAcceptWithDetails: (details) {
          setState(() {
            _isOverDropZone = true;
          });
          return true;
        },
        onLeave: (data) {
          setState(() {
            _isOverDropZone = false;
          });
        },
        onAcceptWithDetails: (details) {
          setState(() {
            _isOverDropZone = false;
          });
          widget.onLetterDropped(details.data);
        },
        builder: (context, candidateData, rejectedData) {
          final backgroundColor = _isOverDropZone
                  ? Colors.green.shade100
                  : showDropHint
                      ? Colors.blue.shade50
                  : Colors.white.withValues(alpha: 0.5);

          return Padding(
            padding: const EdgeInsets.only(top: 12),
            child: AnimatedRainbowBorder(
              borderRadius: BorderRadius.circular(24),
              borderWidth: 8,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(1, 1, 1, 1),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: widget.droppedLetter != null
                    ? _buildDroppedContent(item, widget.droppedLetter!)
                    : _buildPlaceholder(showDropHint, widget.selectedLetter),
              ),
            ),
          )
              .animate(target: widget.showCelebration ? 1 : 0)
              .shake(duration: 2000.ms, hz: 4);
        },
      ),
    );
  }

  Widget _buildPlaceholder(bool showHint, String? selectedLetter) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (showHint && selectedLetter != null) ...[
          Text(
            selectedLetter,
            style: TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade600,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '👆',
            style: TextStyle(fontSize: 60),
          ),
          const SizedBox(height: 16),
          Text(
            'انقر هنا لوضع الحرف!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
        ] else ...[
          const Text(
            '👇',
            style: TextStyle(fontSize: 60),
          ),
          const SizedBox(height: 16),
          Text(
            'انقر على حرف أعلاه!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDroppedContent(LetterItem? item, String letter) {

    final showLetterBurst =
        _showEmojiBurst && _burstTarget == _BurstTarget.letter;
    final showImageBurst =
        _showEmojiBurst && _burstTarget == _BurstTarget.image;

    return LayoutBuilder(
      builder: (context, constraints) {
        final ui = UiScale.of(context);
        final LetterItem? letterItem = item;
        final bool hasItem = letterItem != null;
        final double height = constraints.maxHeight;

        // Better scaling based on available height
        // Use a smaller percentage of height to prevent content from being too large
        final double letterFont =
            math.min(ui.font(104), (height * 0.25).clamp(70.0, 110.0));
        final double imageSize = hasItem
            ? math.min(ui.size(150), (height * 0.28).clamp(100.0, 150.0))
            : 0.0;

        Widget letterSection = SizedBox(
          height: letterFont + ui.spacing(16),
          child: Stack(
            clipBehavior: Clip.none,
      children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    widget.onPlayLetterSound();
                    _triggerEmojiBurst(_BurstTarget.letter, letter: letter);
                  },
          child: Text(
            letter,
                    textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: letterFont,
                      fontFamily: 'ArialKids',
              fontWeight: FontWeight.bold,
                      color: Colors.red,
            ),
          )
              .animate()
                      .scale(duration: 320.ms, curve: Curves.easeOutBack)
              .then()
                      .fadeIn(duration: 160.ms),
                ),
              ),
              if (showLetterBurst && _burstLetter != null)
                KeyedSubtree(
                  key: ValueKey('letter-burst-$_burstVersion'),
                  child: _buildLetterBurst(_burstLetter!),
                ),
            ],
          ),
        );

        if (!hasItem) {
          return Column(
            children: [
              letterSection,
              const Spacer(),
            ],
          );
        }

        final double imageBorderWidth = ui.spacing(3);

        Widget imageSection = SizedBox(
          height: imageSize + ui.spacing(18),
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
          GestureDetector(
                onTap: () {
                  if (widget.onPlaySoundEffect != null) {
                    widget.onPlaySoundEffect!();
                  } else {
                    widget.onPlayItemSound();
                  }
                  _triggerEmojiBurst(_BurstTarget.image);
                },
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.12),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: SizedBox(
                    width: imageSize,
                    height: imageSize,
                    child: AnimatedRainbowBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderWidth: imageBorderWidth,
                      duration: const Duration(seconds: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            24 - imageBorderWidth,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            24 - imageBorderWidth * 1.2,
                          ),
                          child: letterItem.imagePath != null
                              ? _MultiFormatImage(
                                  basePath: letterItem.imagePath!,
                                  emoji: letterItem.emoji,
                                  fontSize: ui.font(78),
                                )
                              : Center(
                                  child: Text(
                                    letterItem.emoji,
                                    style: TextStyle(fontSize: ui.font(78)),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                )
                .animate()
                    .scale(delay: 200.ms, duration: 320.ms)
                .then()
                    .shimmer(duration: 900.ms),
              ),
              if (showImageBurst)
                KeyedSubtree(
                  key: ValueKey('image-burst-$_burstVersion'),
                  child: _buildEmojiBurst(letterItem.emoji),
                ),
            ],
          ),
        );

        Widget textSection = Padding(
          padding: EdgeInsets.symmetric(horizontal: ui.spacing(4)),
          child: GestureDetector(
            onTap: () {
              widget.onPlayItemSound();
            },
            child: Text(
              '$letter - ${letterItem.name}',
            style: TextStyle(
                fontSize: math.min(ui.font(54), (height * 0.12).clamp(32.0, 48.0)),
                fontWeight: FontWeight.w900,
              color: Colors.grey.shade800,
                letterSpacing: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          ),
        );

        return Column(
          children: [
            letterSection,
            SizedBox(height: ui.spacing(12)),
            imageSection,
            SizedBox(height: ui.spacing(10)),
            textSection,
            const Spacer(),
          ],
        );
      },
    );
  }

  Widget _buildEmojiBurst([String? specialEmoji]) {
    const emojiStyle = TextStyle(
      fontSize: 32, // Reduced from 46 to make emojis smaller
      shadows: [
        Shadow(
          blurRadius: 10,
          color: Color.fromARGB(45, 0, 0, 0),
        ),
      ],
    );

    final baseEmojis = ['🎉', '🎊', '✨', '🥳', '💥', '🌟', '🎈', '💫'];
    final emojiSet = specialEmoji != null
        ? List<String>.filled(12, specialEmoji)
        : baseEmojis;

    final count = emojiSet.length;
    final particles = List<_BurstParticle>.generate(count, (index) {
      final angle = (2 * math.pi / count) * index;
      final radius = 80 + (index % 3) * 18;
      return _BurstParticle(
        emojiSet[index % emojiSet.length],
        Offset(math.cos(angle) * radius, math.sin(angle) * radius),
        angle / 2,
      );
    });

    return IgnorePointer(
      child: SizedBox(
        width: 220,
        height: 220,
        child: Stack(
          alignment: Alignment.center,
            children: [
            for (final entry in particles.asMap().entries)
              Animate(
                key: ValueKey('emoji-${_burstVersion}-${entry.key}'),
                effects: [
                  FadeEffect(
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeOut,
                  ),
                  ScaleEffect(
                    begin: const Offset(0.25, 0.25),
                    end: const Offset(1.15, 1.15),
                    duration: 550.ms,
                    curve: Curves.easeOutBack,
                  ),
                  MoveEffect(
                    begin: Offset.zero,
                    end: entry.value.offset,
                    duration: 750.ms,
                    curve: Curves.easeOutCirc,
                  ),
                  FadeEffect(
                    begin: 1,
                    end: 0,
                    delay: 650.ms,
                    duration: 450.ms,
                    curve: Curves.easeIn,
                  ),
                  ScaleEffect(
                    begin: const Offset(1, 1),
                    end: const Offset(1.45, 1.45),
                    delay: 650.ms,
                    duration: 450.ms,
                    curve: Curves.easeInQuad,
                  ),
                ],
                child: Transform.rotate(
                  angle: entry.value.rotation,
                  child: Text(
                    entry.value.emoji,
                    style: emojiStyle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLetterBurst(String letter) {
    // Spiral pattern with more letters now that background animation is removed
    const int numLetters = 16;
    const double maxAngle = 3.5 * math.pi; // Total spiral turns
    const double spiralConstant = 25.0; // Controls how tight the spiral is
    const double startRadius = 8.0; // Starting radius from center

    return IgnorePointer(
      child: RepaintBoundary(
        child: SizedBox(
          width: 280,
          height: 280,
          child: Stack(
            alignment: Alignment.center,
            children: [
              for (var i = 0; i < numLetters; i++)
                RepaintBoundary(
                  child: Animate(
                    key: ValueKey('letter-${_burstVersion}-$i'),
                    effects: [
                      // Simplified: Only fade and move, no scale or complex transforms
                      FadeEffect(
                        duration: 200.ms,
                        delay: (i * 35).ms, // Adjusted delay for more letters
                        curve: Curves.easeOut,
                      ),
                      CustomEffect(
                        duration: 900.ms,
                        delay: (i * 35).ms,
                        curve: Curves.easeOutCubic,
                        builder: (context, value, child) {
                          // Calculate position along spiral
                          final progress = (i / (numLetters - 1)) * value;
                          final angle = progress * maxAngle;
                          final radius = startRadius + (spiralConstant * angle);
                          
                          // Calculate position
                          final x = math.cos(angle) * radius;
                          final y = math.sin(angle) * radius;
                          
                          // Simple rotation to align with spiral
                          final tangentAngle = angle + math.pi / 2;
                          
                          return Transform.translate(
                            offset: Offset(x, y),
                            child: Transform.rotate(
                              angle: tangentAngle,
                              child: child,
                            ),
                          );
                        },
                      ),
                      FadeEffect(
                        begin: 1,
                        end: 0,
                        delay: 700.ms,
                        duration: 400.ms,
                        curve: Curves.easeIn,
                      ),
                    ],
                    child: Text(
                      letter,
                      style: TextStyle(
                        fontFamily: 'ArialKids',
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        color: _letterColors.isNotEmpty && i < _letterColors.length
                            ? _letterColors[i]
                            : Colors.purple.shade600,
                        shadows: [
                          Shadow(
                            blurRadius: 8,
                            color: Colors.black.withValues(alpha: 0.15),
                          ),
                        ],
                      ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BurstParticle {
  final String emoji;
  final Offset offset;
  final double rotation;

  const _BurstParticle(this.emoji, this.offset, this.rotation);
}

/// Widget that tries multiple image formats if the first one fails
class _MultiFormatImage extends StatefulWidget {
  final String basePath;
  final String emoji;
  final double fontSize;

  const _MultiFormatImage({
    required this.basePath,
    required this.emoji,
    required this.fontSize,
  });

  @override
  State<_MultiFormatImage> createState() => _MultiFormatImageState();
}

class _MultiFormatImageState extends State<_MultiFormatImage> {
  static const List<String> _extensions = ['.webp', '.jfif', '.png', '.jpg', '.jpeg', '.bmp'];
  int _currentIndex = 0; // Start with first extension

  String _getCurrentPath() {
    // Extract base path without extension
    final basePath = widget.basePath;
    
    // If path already has an extension and we're on index 0, try it first
    // (AssetResolver might have found the correct file)
    final lastDot = basePath.lastIndexOf('.');
    final lastSlash = basePath.lastIndexOf('/');
    final hasExtension = lastDot > lastSlash; // Extension exists after the last slash
    
    if (hasExtension && _currentIndex == 0) {
      // First try the exact path that AssetResolver returned
      debugPrint('_MultiFormatImage: Trying exact resolved path first: $basePath');
      return basePath;
    }
    
    // Extract path without extension for trying other formats
    final pathWithoutExt = hasExtension && lastDot > 0 
        ? basePath.substring(0, lastDot)
        : basePath;
    
    // Try extensions in order (skip index 0 if we already tried the exact path)
    final effectiveIndex = hasExtension ? _currentIndex - 1 : _currentIndex;
    if (effectiveIndex >= 0 && effectiveIndex < _extensions.length) {
      return '$pathWithoutExt${_extensions[effectiveIndex]}';
    }
    return basePath; // Return original if all tried
  }

  @override
  Widget build(BuildContext context) {
    final currentPath = _getCurrentPath();
    
    // Debug: log what we're trying (only first time)
    if (_currentIndex == 0) {
      debugPrint('_MultiFormatImage: Trying path: $currentPath (base: ${widget.basePath})');
    }
    
    return Image.asset(
      currentPath,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        debugPrint('_MultiFormatImage: Failed to load $currentPath (index $_currentIndex/${_extensions.length - 1})');
        
        // Try next format
        // Calculate max index: if basePath has extension, we need to try all extensions + 1
        final basePath = widget.basePath;
        final lastDot = basePath.lastIndexOf('.');
        final lastSlash = basePath.lastIndexOf('/');
        final hasExtension = lastDot > lastSlash;
        final maxIndex = hasExtension ? _extensions.length : _extensions.length - 1;
        
        if (_currentIndex < maxIndex) {
          // Schedule state update for next format
          Future.microtask(() {
            if (mounted) {
              setState(() {
                _currentIndex++;
                final nextPath = _getCurrentPath();
                debugPrint('_MultiFormatImage: Now trying index $_currentIndex: $nextPath');
              });
            }
          });
          // Show emoji while trying next format
          return Center(
            child: Text(
              widget.emoji,
              style: TextStyle(fontSize: widget.fontSize),
            ),
          );
        }
        
        // All formats failed, show emoji
        debugPrint('_MultiFormatImage: All formats failed for base path: ${widget.basePath}');
        return Center(
          child: Text(
            widget.emoji,
            style: TextStyle(fontSize: widget.fontSize),
          ),
        );
      },
    );
  }
}

class AnimatedRainbowBorder extends StatefulWidget {
  final Widget child;
  final double borderWidth;
  final BorderRadius borderRadius;
  final Duration duration;

  const AnimatedRainbowBorder({
    super.key,
    required this.child,
    this.borderWidth = 8,
    this.borderRadius = const BorderRadius.all(Radius.circular(24)),
    this.duration = const Duration(seconds: 14),
  });

  @override
  State<AnimatedRainbowBorder> createState() => _AnimatedRainbowBorderState();
}

class _AnimatedRainbowBorderState extends State<AnimatedRainbowBorder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  BorderRadius _shrinkRadius(BorderRadius radius, double inset) {
    Radius shrink(Radius r) =>
        Radius.circular(math.max(0, r.x - inset));
    return BorderRadius.only(
      topLeft: shrink(radius.topLeft),
      topRight: shrink(radius.topRight),
      bottomLeft: shrink(radius.bottomLeft),
      bottomRight: shrink(radius.bottomRight),
    );
  }

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

  List<Color> _gradientColors() => const [
        Color(0xFFFF5F6D),
        Color(0xFFFFC371),
        Color(0xFFFFFF6B),
        Color(0xFF66FF99),
        Color(0xFF62E0FF),
        Color(0xFF8C86FF),
        Color(0xFFFF8CFF),
      ];

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        return ClipRRect(
          borderRadius: widget.borderRadius,
          child: CustomPaint(
            painter: _RainbowBorderPainter(
              progress: _controller.value,
              borderWidth: widget.borderWidth,
              borderRadius: widget.borderRadius,
              colors: _gradientColors(),
            ),
            child: Padding(
              padding: EdgeInsets.all(widget.borderWidth),
              child: ClipRRect(
                borderRadius: _shrinkRadius(
                  widget.borderRadius,
                  widget.borderWidth,
                ),
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _RainbowBorderPainter extends CustomPainter {
  final double progress;
  final double borderWidth;
  final BorderRadius borderRadius;
  final List<Color> colors;

  _RainbowBorderPainter({
    required this.progress,
    required this.borderWidth,
    required this.borderRadius,
    required this.colors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final double inset = borderWidth / 2;

    Radius shrink(Radius radius) =>
        Radius.circular(math.max(0, radius.x - inset));

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
      colors: colors,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      tileMode: TileMode.mirror,
      transform: _SlidingGradientTransform(progress),
    ).createShader(rect);

    final paint = Paint()
      ..shader = shader
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..strokeCap = StrokeCap.butt;

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant _RainbowBorderPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.borderWidth != borderWidth ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.colors != colors;
  }
}

class _SlidingGradientTransform extends GradientTransform {
  final double slidePercent;
  const _SlidingGradientTransform(this.slidePercent);

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    final dx = bounds.width * slidePercent * 2;
    final dy = bounds.height * slidePercent * 2;
    return Matrix4.translationValues(dx, dy, 0);
  }
}


