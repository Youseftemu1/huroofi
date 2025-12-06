import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/letter_item.dart';
import 'data/letter_data.dart';
import 'services/audio_service.dart';
import 'services/asset_resolver.dart';
import 'widgets/letter_tile.dart';
import 'widgets/drop_zone.dart';
import 'widgets/category_selector.dart';
import 'widgets/animated_rainbow_background.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AssetResolver.init();
  await AudioService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Huroofi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
        fontFamily: 'ArialKids',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  Category _selectedCategory = Category.animals;
  String? _droppedLetter;
  String? _selectedLetter; // For tap-to-select on mobile
  bool _showCelebration = false;
  late AnimationController _celebrationController;
  int _playbackSession = 0;

  @override
  void initState() {
    super.initState();
    _celebrationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Lock orientation on phones (portrait only), allow rotation on tablets
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final mediaQuery = MediaQuery.maybeOf(context);
      if (mediaQuery == null) return;
      final shortestSide = mediaQuery.size.shortestSide;

      if (shortestSide < 600) {
        // Phone: portrait only
        SystemChrome.setPreferredOrientations(const [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
      } else {
        // Tablet: allow all orientations
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      }
    });
  }

  @override
  void dispose() {
    _celebrationController.dispose();
    AudioService.dispose();
    super.dispose();
  }

  void _onCategoryChanged(Category category) {
    _cancelPlayback();
    
    // Keep the current letter if it exists and has an item in the new category
    final currentLetter = _droppedLetter;
    final items = LetterData.getLetterItems()[category] ?? {};
    final hasItemForCurrentLetter = currentLetter != null && items.containsKey(currentLetter);
    
    setState(() {
      _selectedCategory = category;
      // Only clear the letter if there's no item for it in the new category
      if (!hasItemForCurrentLetter) {
        _droppedLetter = null;
        _selectedLetter = null;
      }
      _showCelebration = false;
    });
    
    // If we kept the letter, play the sounds for the new category
    if (currentLetter != null && hasItemForCurrentLetter) {
      final session = _playbackSession;
      unawaited(_playAllSoundsInSequence(currentLetter, session));
    }
  }

  void _onLetterSelected(String letter) {
    // Immediately drop the letter when selected (no need to click drop zone)
    _onLetterDropped(letter);
  }

  void _onLetterDropped(String letter) {
    _cancelPlayback();
    setState(() {
      _droppedLetter = letter;
      _selectedLetter = letter;
      _showCelebration = true;
    });
    
    final session = _playbackSession;
    unawaited(_playAllSoundsInSequence(letter, session));

    // Celebration animation
    _celebrationController.forward().then((_) {
      _celebrationController.reset();
      if (mounted) {
        setState(() {
          _showCelebration = false;
        });
      }
    });
  }

  Future<void> _playAllSoundsInSequence(String letter, int sessionId) async {
    await _playLetterAudio(letter);
    if (!_isSessionActive(sessionId)) return;

    final items = LetterData.getLetterItems()[_selectedCategory] ?? {};
    final item = items[letter];
    if (item == null) return;

    await Future.delayed(const Duration(milliseconds: 400));
    if (!_isSessionActive(sessionId)) return;

    await _playItemAudio(item);
    if (!_isSessionActive(sessionId)) return;
  }

  void _onDropZoneTapped() {
    if (_selectedLetter != null) {
      _onLetterDropped(_selectedLetter!);
    }
  }

  void _onReset() {
    _cancelPlayback();
    setState(() {
      _droppedLetter = null;
      _selectedLetter = null;
      _showCelebration = false;
    });
    _celebrationController.reset();
  }

  String? _getLetterSoundPath([String? letter]) {
    final targetLetter = letter ?? _droppedLetter;
    if (targetLetter == null) return null;
    return AssetResolver.resolveLetterSoundPath(targetLetter);
  }

  void _playLetterSound() {
    final letter = _droppedLetter;
    if (letter == null) return;
    _cancelPlayback();
    unawaited(_playLetterAudio(letter));
  }

  void _playItemSound() {
    final letter = _droppedLetter;
    if (letter == null) return;
    final items = LetterData.getLetterItems()[_selectedCategory];
    final item = items?[letter];
    if (item == null) return;
    _cancelPlayback();
    unawaited(_playItemAudio(item));
  }

  Future<void> _playLetterAudio(String letter) async {
    final path = _getLetterSoundPath(letter);
    final name = _letterName(letter) ?? '';
    if (path != null && path.isNotEmpty) {
      try {
        await AudioService.playSoundFile(path, name);
        return;
      } catch (_) {}
    }
    if (name.isNotEmpty) {
      await AudioService.speakLetter(name);
    }
  }

  Future<void> _playItemAudio(LetterItem item) async {
    final path = item.soundPath;
    if (path != null && path.isNotEmpty) {
      try {
        await AudioService.playSoundFile(path, item.name);
        return;
      } catch (_) {}
    }
    await AudioService.speakItem(item.name);
  }

  void _cancelPlayback() {
    _playbackSession++;
    AudioService.stopAll();
  }

  bool _isSessionActive(int sessionId) => sessionId == _playbackSession;

  String? _letterName(String letter) {
    final index = LetterData.letters.indexOf(letter);
    if (index >= 0 && index < LetterData.letterNames.length) {
      return LetterData.letterNames[index];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isLandscape = size.width > size.height;
    final double dropZoneHeight =
        isLandscape ? size.height * 0.6 : 500; // a bit shorter in landscape

    return Scaffold(
      body: AnimatedRainbowBackground(
        child: SafeArea(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: [
                // Header (hidden in landscape to free vertical space)
                if (!isLandscape)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          ' تعلم الحروف العربية ',
                          style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.width > 600 ? 40 : 40,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()
                              ..shader = LinearGradient(
                                colors: [
                                  Colors.purple.shade600,
                                  Colors.pink.shade600
                                ],
                              ).createShader(
                                const Rect.fromLTWH(0, 0, 200, 70),
                              ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'انقر على أي حرف لرؤية الصورة والاستماع',
                          style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.width > 600 ? 20 : 20,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                // Category Selector (Fixed)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CategorySelector(
                    selectedCategory: _selectedCategory,
                    onCategoryChanged: _onCategoryChanged,
                  ),
                ),
                
                SizedBox(height: isLandscape ? 8 : 16),
                
                // Letters Row (Horizontal Scrollable - Always Visible)
                Container(
                  height: 100,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    itemCount: LetterData.letters.length,
                        itemBuilder: (context, index) {
                          final letter = LetterData.letters[index];
                          final isSelected = _selectedLetter == letter;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: LetterTile(
                              letter: letter,
                              color: LetterData.letterColors[index],
                              onTap: () => _onLetterSelected(letter),
                              isSelected: isSelected,
                              onDragStart: () {},
                              isDragging: _droppedLetter == letter,
                            ),
                          );
                        },
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Drop Zone (responsive height so it fits on phones & tablets)
                SizedBox(
                  height: dropZoneHeight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: DropZone(
                      droppedLetter: _droppedLetter,
                      selectedLetter: _selectedLetter,
                      selectedCategory: _selectedCategory,
                      showCelebration: _showCelebration,
                      onLetterDropped: _onLetterDropped,
                      onDropZoneTapped: _onDropZoneTapped,
                      onReset: _onReset,
                      onPlayLetterSound: _playLetterSound,
                      onPlayItemSound: _playItemSound,
                      onPlaySoundEffect: null, // disable effect on picture tap
                      onPlayAllSounds: () {
                        if (_droppedLetter != null) {
                          _cancelPlayback();
                          final session = _playbackSession;
                          unawaited(
                            _playAllSoundsInSequence(_droppedLetter!, session),
                          );
                        }
                      },
                    ),
                  ),
                ),
          ],
        ),
      ),
        ),
      ),
    );
  }

}
