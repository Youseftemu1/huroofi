import 'dart:convert';

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
    '.png',
    '.jpg',
    '.jpeg',
    '.webp',
    '.bmp',
    '.jfif',
  ];

  static Future<void> init() async {
    if (_initialized) return;
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    _assets
      ..clear()
      ..addAll(manifestMap.keys.cast<String>());
    _assetSet
      ..clear()
      ..addAll(_assets);
    _initialized = true;
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
    final result = _resolveFromFolder(
      prefix,
      preferredNames: const ['image'],
      extensions: _imageExtensions,
    );
    
    // Debug: show what files are available in this folder
    if (result == null) {
      final availableFiles = _assets
          .where((asset) => asset.startsWith(prefix))
          .toList();
      if (availableFiles.isNotEmpty) {
        debugPrint(
          'AssetResolver: No image found with preferred name "image" in $prefix, '
          'but found these files: $availableFiles',
        );
      }
    }
    
    return result;
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

    for (final asset in _assets) {
      if (!asset.startsWith(prefix)) continue;
      for (final ext in extensions) {
        if (asset.toLowerCase().endsWith(ext)) {
          return asset;
        }
      }
    }
    return null;
  }

  static void _ensureInitialized() {
    if (!_initialized) {
      throw StateError(
        'AssetResolver not initialized. Call await AssetResolver.init() before use.',
      );
    }
  }
}

