class LetterItem {
  final String name;
  final String emoji;
  final String? imagePath;
  final String? soundPath; // For pronunciation (word)
  final String? soundEffectPath; // For sound effects (animal sounds, etc.)

  LetterItem({
    required this.name,
    required this.emoji,
    this.imagePath,
    this.soundPath,
    this.soundEffectPath,
  });
}

enum Category { animals, objects, nature }

extension CategoryExtension on Category {
  String get displayName {
    switch (this) {
      case Category.animals:
        return 'حيوانات';
      case Category.objects:
        return 'أشياء';
      case Category.nature:
        return 'طبيعة';
    }
  }

  String get emoji {
    switch (this) {
      case Category.animals:
        return '🦁';
      case Category.objects:
        return '🍊';
      case Category.nature:
        return '🌹';
    }
  }
}

