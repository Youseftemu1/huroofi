import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class AssetResolver {
  static bool _initialized = false;
  static final List<String> _assets = [];
  static final Set<String> _assetSet = {};

  static const List<String> _audioExtensions = [
    '.mp3',
    '.m4a',
    '.wav',
    '.aac',
  ];

  static const List<String> _imageExtensions = [
    '.webp',  // Preferred format (better compression)
    '.jfif',  // Also check jfif
    '.png',   // Then png
    '.jpg',   // Then jpg
    '.jpeg',  // Then jpeg
    '.bmp',   // Last resort
  ];

  static Future<void> init() async {
    if (_initialized) return;
    
    try {
      // Use the new AssetManifest API (Flutter deprecated AssetManifest.json)
      final assetManifest = await AssetManifest.loadFromAssetBundle(rootBundle);
      final assetList = assetManifest.listAssets();
      
      _assets
        ..clear()
        ..addAll(assetList);
      _assetSet
        ..clear()
        ..addAll(_assets);
      _initialized = true;
      
      // Log image format counts to verify files are in manifest
      final imageCount = _assets.where((a) => a.contains('/images/')).length;
      final jpgCount = _assets.where((a) => a.contains('/images/') && a.toLowerCase().endsWith('.jpg')).length;
      final jfifCount = _assets.where((a) => a.contains('/images/') && a.toLowerCase().endsWith('.jfif')).length;
      final webpCount = _assets.where((a) => a.contains('/images/') && a.toLowerCase().endsWith('.webp')).length;
      
      debugPrint('AssetResolver: ✅ Initialized! Loaded ${_assets.length} total assets ($imageCount images)');
      debugPrint('AssetResolver: Image formats - JPG: $jpgCount, JFIF: $jfifCount, WEBP: $webpCount');
      
      // Show sample nature folder files to verify they're included
      final natureFiles = _assets
          .where((a) => a.contains('/images/nature/'))
          .take(5)
          .toList();
      if (natureFiles.isNotEmpty) {
        debugPrint('AssetResolver: Sample nature images: $natureFiles');
      }
    } catch (e) {
      debugPrint('AssetResolver: ❌ Error loading AssetManifest: $e');
      // Initialize with empty list to prevent crashes
      _assets.clear();
      _assetSet.clear();
      _initialized = true; // Mark as initialized to prevent retry loops
    }
  }

  static String? resolveLetterSoundPath(String letter) {
    _ensureInitialized();
    return _resolveFromFolder(
      'assets/sounds/letters/$letter/',
      preferredNames: const ['letter'],
      extensions: _audioExtensions,
    );
  }

  static String? resolveImageFromFolder(String folder, String letter) {
    _ensureInitialized();
    final prefix = 'assets/images/$folder/$letter/';
    
    // If manifest loaded successfully, use it
    if (_assets.isNotEmpty) {
      // First, check what files actually exist in this folder
      final availableFiles = _assets
          .where((asset) => asset.startsWith(prefix))
          .toList();
      
      if (availableFiles.isEmpty) {
        debugPrint('AssetResolver: ❌ No files found in $prefix at all!');
        debugPrint('AssetResolver: Available folders: ${_assets.where((a) => a.startsWith("assets/images/$folder/")).take(5).toList()}');
      } else {
        debugPrint('AssetResolver: 📁 Files in $prefix: $availableFiles');
      }
      
      final result = _resolveFromFolder(
        prefix,
        preferredNames: const ['image'],
        extensions: _imageExtensions,
      );
      
      if (result != null) {
        debugPrint('AssetResolver: ✅ Found image for $folder/$letter: $result');
        // Verify it exists
        if (_assetSet.contains(result)) {
          debugPrint('AssetResolver: ✅ Verified $result exists in manifest');
          return result;
        } else {
          debugPrint('AssetResolver: ❌ $result NOT in manifest!');
        }
      } else {
        debugPrint('AssetResolver: ⚠️ No "image.*" found in $prefix');
      }
    }
    
    // Fallback: if manifest failed or empty, return path with preferred extension
    // The widget will try multiple formats
    debugPrint('AssetResolver: ⚠️ Using fallback path for $folder/$letter: ${prefix}image');
    return '${prefix}image'; // No extension - widget will try all formats
  }

  static String? resolveWordSoundFromFolder(String folder, String letter) {
    _ensureInitialized();
    return _resolveFromFolder(
      'assets/sounds/$folder/$letter/',
      preferredNames: const ['word'],
      extensions: _audioExtensions,
    );
  }

  static String? resolveEffectSoundFromFolder(String folder, String letter) {
    _ensureInitialized();
    return _resolveFromFolder(
      'assets/sounds/$folder/$letter/',
      preferredNames: const ['effect'],
      extensions: _audioExtensions,
    );
  }

  static String? _resolveFromFolder(
    String prefix, {
    List<String>? preferredNames,
    required List<String> extensions,
  }) {
    // preferred exact filenames first
    if (preferredNames != null) {
      for (final name in preferredNames) {
        for (final ext in extensions) {
          final candidate = '$prefix$name$ext';
          if (_assetSet.contains(candidate)) {
            return candidate;
          }
        }
      }
    }

    // Fallback: find any file in the folder with matching extension
    // Check extensions in priority order
    for (final ext in extensions) {
      final lowerExt = ext.toLowerCase();
      for (final asset in _assets) {
        if (!asset.startsWith(prefix)) continue;
        final lowerAsset = asset.toLowerCase();
        if (lowerAsset.endsWith(lowerExt)) {
          return asset;
        }
      }
    }
    return null;
  }

  static bool assetExists(String path) {
    _ensureInitialized();
    return _assetSet.contains(path);
  }

  static List<String> getAssetsInFolder(String prefix) {
    _ensureInitialized();
    return _assets.where((asset) => asset.startsWith(prefix)).toList();
  }

  static void _ensureInitialized() {
    if (!_initialized) {
      throw StateError(
        'AssetResolver not initialized. Call await AssetResolver.init() before use.',
      );
    }
  }
}

