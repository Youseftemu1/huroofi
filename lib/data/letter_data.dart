import 'package:flutter/material.dart';
import '../models/letter_item.dart';
import '../services/asset_resolver.dart';

class LetterData {
  static const List<String> letters = [
    'أ', 'ب', 'ت', 'ث', 'ج', 'ح', 'خ', 'د', 'ذ', 'ر', 'ز', 'س', 'ش', 'ص',
    'ض', 'ط', 'ظ', 'ع', 'غ', 'ف', 'ق', 'ك', 'ل', 'م', 'ن', 'ه', 'و', 'ي'
  ];

  static const List<String> letterNames = [
    'ألف', 'باء', 'تاء', 'ثاء', 'جيم', 'حاء', 'خاء', 'دال', 'ذال', 'راء', 'زاي', 'سين', 'شين', 'صاد',
    'ضاد', 'طاء', 'ظاء', 'عين', 'غين', 'فاء', 'قاف', 'كاف', 'لام', 'ميم', 'نون', 'هاء', 'واو', 'ياء'
  ];

  static const List<Color> letterColors = [
    Color(0xFFF87171), // red-400
    Color(0xFFFB923C), // orange-400
    Color(0xFFFBBF24), // amber-400
    Color(0xFFFACC15), // yellow-400
    Color(0xFFA3E635), // lime-400
    Color(0xFF4ADE80), // green-400
    Color(0xFF34D399), // emerald-400
    Color(0xFF2DD4BF), // teal-400
    Color(0xFF22D3EE), // cyan-400
    Color(0xFF38BDF8), // sky-400
    Color(0xFF60A5FA), // blue-400
    Color(0xFF818CF8), // indigo-400
    Color(0xFFA78BFA), // violet-400
    Color(0xFFC084FC), // purple-400
    Color(0xFFE879F9), // fuchsia-400
    Color(0xFFF472B6), // pink-400
    Color(0xFFFB7185), // rose-400
    Color(0xFFEF4444), // red-500
    Color(0xFFF97316), // orange-500
    Color(0xFFF59E0B), // amber-500
    Color(0xFFEAB308), // yellow-500
    Color(0xFF84CC16), // lime-500
    Color(0xFF22C55E), // green-500
    Color(0xFF10B981), // emerald-500
    Color(0xFF14B8A6), // teal-500
    Color(0xFF06B6D4), // cyan-500
    Color(0xFF0EA5E9), // sky-500
    Color(0xFF3B82F6), // blue-500
  ];

  static Map<Category, Map<String, LetterItem>> getLetterItems() {
    return {
      Category.animals: _buildCategoryMap(Category.animals, _animalEntries),
      Category.objects: _buildCategoryMap(Category.objects, _objectEntries),
      Category.nature: _buildCategoryMap(Category.nature, _natureEntries),
    };
  }

  static Map<String, LetterItem> _buildCategoryMap(
    Category category,
    List<List<String>> entries,
  ) {
    return {
      for (final entry in entries)
        entry[0]: LetterItem(
          name: entry[1],
          emoji: entry[2],
          imagePath: _imagePath(category, entry[0]),
          soundPath: _wordSoundPath(category, entry[0]),
          soundEffectPath: _effectSoundPath(category, entry[0]),
        ),
    };
  }

  static String? _imagePath(Category category, String letter) {
    final folder = _imageFolders[category]!;
    final prefix = 'assets/images/$folder/$letter/';
    
    // First try the resolver (works if manifest loaded)
    final resolved = AssetResolver.resolveImageFromFolder(folder, letter);
    if (resolved != null && AssetResolver.assetExists(resolved)) {
      debugPrint('letter_data: ✅ Using resolved path: $resolved');
      return resolved;
    }
    
    // If resolver found a path but assetExists failed, still return it
    // (might be a timing issue or the widget will handle it)
    if (resolved != null) {
      debugPrint('letter_data: ⚠️ Resolver returned path but assetExists failed: $resolved');
      return resolved;
    }
    
    // If manifest didn't load, return a path WITHOUT extension
    // The _MultiFormatImage widget will try: .webp, .jfif, .png, .jpg, .jpeg, .bmp
    debugPrint('letter_data: ⚠️ No resolved path, using fallback: ${prefix}image');
    return '${prefix}image'; // Widget will try all formats automatically
  }

  static String? _wordSoundPath(Category category, String letter) {
    final folder = _wordSoundFolders[category]!;
    return AssetResolver.resolveWordSoundFromFolder(folder, letter) ??
        'assets/sounds/$folder/$letter/word.mp3';
  }

  static String? _effectSoundPath(Category category, String letter) {
    final folder = _effectSoundFolders[category];
    if (folder == null) return null;
    return AssetResolver.resolveEffectSoundFromFolder(folder, letter) ??
        'assets/sounds/$folder/$letter/effect.mp3';
  }

  static const Map<Category, String> _imageFolders = {
    Category.animals: 'animals',
    Category.objects: 'objects',
    Category.nature: 'nature',
  };

  static const Map<Category, String> _wordSoundFolders = {
    Category.animals: 'animals',
    Category.objects: 'object',
    Category.nature: 'nature',
  };

  static const Map<Category, String> _effectSoundFolders = {
    Category.animals: 'animal_sound_effect',
    Category.objects: 'object_sound_effect',
    Category.nature: 'nature_sound_effect',
  };

  static const List<List<String>> _animalEntries = [
    ['أ', 'أسد', '🦁'],
    ['ب', 'بقرة', '🐄'],
    ['ت', 'تيس', '🐐'],
    ['ث', 'ثعلب', '🦊'],
    ['ج', 'جمل', '🐪'],
    ['ح', 'حصان', '🐴'],
    ['خ', 'خنزير', '🐷'],
    ['د', 'دب', '🐻'],
    ['ذ', 'ذبابة', '🪰'],
    ['ر', 'راكون', '🦝'],
    ['ز', 'زرافة', '🦒'],
    ['س', 'سمكة', '🐟'],
    ['ش', 'شاهين', '🦅'],
    ['ص', 'صوص', '🐤'],
    ['ض', 'ضفدع', '🐸'],
    ['ط', 'طاووس', '🦚'],
    ['ظ', 'ظربان', '🦨'],
    ['ع', 'عصفور', '🐦'],
    ['غ', 'غزال', '🦌'],
    ['ف', 'فيل', '🐘'],
    ['ق', 'قرد', '🐵'],
    ['ك', 'كلب', '🐶'],
    ['ل', 'لبؤة', '🦁'],
    ['م', 'ماعز', '🐐'],
    ['ن', 'نمر', '🐅'],
    ['ه', 'هدهد', '🪶'],
    ['و', 'وحيد القرن', '🦏'],
    ['ي', 'يمامة', '🕊️'],
  ];

  static const List<List<String>> _objectEntries = [
    ['أ', 'ألوان', '🎨'],
    ['ب', 'بيت', '🏠'],
    ['ت', 'تلفاز', '📺'],
    ['ث', 'ثوب', '👕'],
    ['ج', 'جدار', '🧱'],
    ['ح', 'حقيبة', '🎒'],
    ['خ', 'خزانة', '🗄️'],
    ['د', 'دواء', '💊'],
    ['ذ', 'ذهب', '💰'],
    ['ر', 'راية', '🚩'],
    ['ز', 'زجاجة', '🍼'],
    ['س', 'ساعة', '⌚'],
    ['ش', 'شمعة', '🕯️'],
    ['ص', 'صندوق', '📦'],
    ['ض', 'ضرس', '🦷'],
    ['ط', 'طبل', '🥁'],
    ['ظ', 'ظرف', '✉️'],
    ['ع', 'عسل', '🍯'],
    ['غ', 'غسيل', '🧺'],
    ['ف', 'فستان', '👗'],
    ['ق', 'قلم', '✏️'],
    ['ك', 'كتاب', '📚'],
    ['ل', 'لعبة', '🧸'],
    ['م', 'مفتاح', '🗝️'],
    ['ن', 'نظارة', '👓'],
    ['ه', 'هاتف', '📱'],
    ['و', 'ورقة', '📄'],
    ['ي', 'ياقوت', '💎'],
  ];

  static const List<List<String>> _natureEntries = [
    ['أ', 'أرز', '🍚'],
    ['ب', 'بحر', '🌊'],
    ['ت', 'تمر', '🌴'],
    ['ث', 'ثمرة', '🍎'],
    ['ج', 'جبل', '⛰️'],
    ['ح', 'حقل', '🌾'],
    ['خ', 'خريف', '🍂'],
    ['د', 'ديناصور', '🦖'],
    ['ذ', 'ذرة', '🌽'],
    ['ر', 'رعد', '⚡'],
    ['ز', 'زيتون', '🫒'],
    ['س', 'سحاب', '☁️'],
    ['ش', 'شمس', '☀️'],
    ['ص', 'صحراء', '🏜️'],
    ['ض', 'ضباب', '🌫️'],
    ['ط', 'طقس', '🌤️'],
    ['ظ', 'ظلام', '🌃'],
    ['ع', 'عشب', '🌱'],
    ['غ', 'غابة', '🌲'],
    ['ف', 'فاكهة', '🍓'],
    ['ق', 'قمر', '🌙'],
    ['ك', 'كوكب', '🪐'],
    ['ل', 'لؤلؤ', '🦪'],
    ['م', 'مطر', '🌧️'],
    ['ن', 'نجمة', '⭐'],
    ['ه', 'هواء', '💨'],
    ['و', 'ورقة', '🍃'],
    ['ي', 'ياسمين', '🌼'],
  ];
}

