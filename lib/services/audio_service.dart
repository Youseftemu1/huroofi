import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static final FlutterTts _tts = FlutterTts();
  static final AudioPlayer _audioPlayer = AudioPlayer();
  
  static Future<void> initialize() async {
    try {
      // Try to set Arabic language, fallback to default if not available
      final languages = await _tts.getLanguages;
      if (languages.contains("ar-SA")) {
        await _tts.setLanguage("ar-SA");
      } else if (languages.contains("ar")) {
        await _tts.setLanguage("ar");
      } else {
        // Use default language if Arabic is not available
        debugPrint('Arabic TTS not available, using default language');
      }
      await _tts.setSpeechRate(0.8);
      await _tts.setPitch(1.0);
      await _tts.setVolume(1.0);
    } catch (e) {
      debugPrint('Error initializing TTS: $e');
      // Continue anyway - TTS might still work with defaults
    }
  }

  static Future<void> speakLetter(String letterName) async {
    await _tts.stop();
    await _tts.speak(letterName);
  }

  static Future<void> speakItem(String itemName) async {
    await _tts.stop();
    await _tts.speak(itemName);
  }

  static Future<void> playSoundFile(String soundPath, String fallbackName) async {
    try {
      await _audioPlayer.stop();
      // Remove 'assets/' prefix for AssetSource
      final assetPath = soundPath.startsWith('assets/')
          ? soundPath.substring(7)
          : soundPath;
      
      // Play and wait for completion
      final completer = Completer<void>();
      late StreamSubscription subscription;
      
      subscription = _audioPlayer.onPlayerComplete.listen((_) {
        if (!completer.isCompleted) {
          subscription.cancel();
          completer.complete();
        }
      });
      
      await _audioPlayer.play(AssetSource(assetPath));
      
      // Wait for sound to finish (with timeout)
      try {
        await completer.future.timeout(
          const Duration(seconds: 10),
          onTimeout: () {
            subscription.cancel();
            // If timeout, just continue
          },
        );
      } catch (e) {
        subscription.cancel();
      }
    } catch (e) {
      // If sound file doesn't exist, fallback to TTS
      print('Sound file not found: $soundPath, falling back to TTS. Error: $e');
      if (fallbackName.isNotEmpty) {
        await speakItem(fallbackName);
      }
    }
  }

  // Keep old method name for backward compatibility
  static Future<void> playAnimalSound(String soundPath, String fallbackName) async {
    return playSoundFile(soundPath, fallbackName);
  }

  static Future<void> stopAll() async {
    try {
      await _audioPlayer.stop();
    } catch (_) {}
    try {
      await _tts.stop();
    } catch (_) {}
  }

  static void dispose() {
    stopAll();
  }
}

