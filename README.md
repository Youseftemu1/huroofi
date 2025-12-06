# Huroofi - Arabic Letters Learning App 🎨

**Huroofi** (حروفي) is a beautiful, interactive Flutter app for teaching Arabic letters to children with drag-and-drop functionality, categories (Animals, Objects, Nature), and audio support.

## Features

✅ **28 Arabic Letters** - Complete alphabet from ا to ي  
✅ **3 Categories** - Animals (حيوانات), Objects (أشياء), Nature (طبيعة)  
✅ **Drag & Drop** - Interactive letter dragging  
✅ **Text-to-Speech** - Arabic pronunciation  
✅ **Animal Sounds** - Real animal sounds (when added)  
✅ **Beautiful Animations** - Smooth transitions and celebrations  
✅ **Responsive Design** - Works on phones and tablets  
✅ **RTL Support** - Right-to-left Arabic layout  

## Getting Started

### Prerequisites

- Flutter SDK (3.6.2 or higher)
- Android Studio / Xcode (for mobile development)
- VS Code or Android Studio (for editing)

### Installation

1. **Navigate to the project:**
   ```bash
   cd arabic_letters_app
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   flutter run
   ```

   Or run on a specific device:
   ```bash
   flutter run -d chrome        # Web
   flutter run -d android       # Android
   flutter run -d ios           # iOS
   ```

## Project Structure

```
lib/
├── main.dart                 # Main app entry point
├── models/
│   └── letter_item.dart     # Data models
├── data/
│   └── letter_data.dart     # Letter and item data
├── services/
│   └── audio_service.dart   # TTS and audio playback
└── widgets/
    ├── letter_tile.dart     # Draggable letter tiles
    ├── drop_zone.dart       # Drop zone widget
    └── category_selector.dart # Category buttons
```

## Adding Assets

### Images
Place images in:
- `assets/images/animals/` - Animal images
- `assets/images/objects/` - Object images  
- `assets/images/nature/` - Nature images

### Sounds
Place animal sounds in:
- `assets/sounds/animals/` - Animal sound files (MP3)

The app will automatically use them when available!

## Features in Detail

### Categories
- **🦁 حيوانات (Animals)**: Shows animals for each letter
- **🍊 أشياء (Objects)**: Shows everyday objects
- **🌹 طبيعة (Nature)**: Shows nature items

### Interactions
- **Drag & Drop**: Drag any letter to the drop zone
- **Click Item**: Click the animal/object to hear its name
- **Buttons**: Use buttons to replay sounds

## Testing on Different Screen Sizes

The app is responsive and adapts to:
- **Phones**: 4-7 columns of letters
- **Tablets**: 7+ columns of letters
- **Landscape/Portrait**: Both orientations supported

## Next Steps

1. Add animal images to `assets/images/animals/`
2. Add animal sounds to `assets/sounds/animals/`
3. Add object/nature images
4. Customize colors and animations
5. Test on real devices!

## Building for Production

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## Troubleshooting

- **Audio not working?** Make sure you've added sound files to `assets/sounds/animals/`
- **Images not showing?** Check that images are in the correct `assets/images/` folders
- **Build errors?** Run `flutter clean` then `flutter pub get`

Enjoy teaching Arabic letters! 🎉

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## F-Droid

This app is available on F-Droid. To build from source, follow the installation instructions above.
