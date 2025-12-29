# How to Take Screenshots for App Stores

## Method 1: Using Android Emulator
1. Run your app in an emulator:
   ```bash
   flutter run
   ```
2. Use the emulator's screenshot tool (camera icon in toolbar)
3. Or use: `Ctrl + S` in Android Studio emulator

## Method 2: Using Physical Device
1. Connect your Android device
2. Run: `flutter run`
3. Take screenshots using your device:
   - **Most Android phones**: Press Volume Down + Power button simultaneously
   - **Samsung**: Press Volume Down + Power, or swipe palm across screen
4. Screenshots are saved in your device's Gallery

## Method 3: Using ADB (Command Line)
```bash
adb shell screencap -p /sdcard/screenshot.png
adb pull /sdcard/screenshot.png
```

## Recommended Screenshots:
1. **Main screen** - Showing all Arabic letters
2. **Category selection** - Animals/Objects/Nature buttons
3. **Letter interaction** - Drag and drop in action
4. **Item display** - Showing an animal/object with the letter
5. **Audio playback** - If you can show the sound buttons

## Screenshot Requirements:
- **Size**: 1080x1920 (portrait) or 720x1280 minimum
- **Format**: PNG or JPG
- **Quality**: High resolution, clear text
- **Number**: 2-5 screenshots recommended

