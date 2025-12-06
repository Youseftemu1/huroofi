# How to Add Images and Sounds 🎨🔊

## 📸 About the Images

**Important:** The app is currently showing **emojis** (🦁🐄🐐) because the image files haven't been added yet. The app is set up to display images, but you need to add them!

## 🖼️ How to Add Images

### Step 1: Prepare Your Images

1. **Image Requirements:**
   - Format: `.jpg` or `.png` (`.jpg` is recommended for smaller file size)
   - **Resolution:**
     - **Minimum:** 120x120 pixels (for basic screens)
     - **Recommended:** 240x240 pixels (for most phones - 2x density)
     - **Best Quality:** 360x360 pixels (for high-end phones - 3x density)
   - **Shape:** Square images work best (the app uses `BoxFit.cover` which crops to fit)
   - **Aspect Ratio:** 1:1 (square) - images will be cropped if not square
   - **File Size:** Try to keep under 200KB per image for faster loading
   - **Quality:** Clear, colorful images that kids will love!

### Step 2: Find Images

**Free Image Sources:**
- **Pexels** (https://www.pexels.com) - Free high-quality photos
- **Unsplash** (https://unsplash.com) - Beautiful free images
- **Pixabay** (https://pixabay.com) - Free images and illustrations
- **Google Images** - Search with "Usage Rights: Labeled for reuse"

**Search Tips:**
- Search in English: "lion", "cow", "donkey", "orange", "rose", etc.
- Or search in Arabic: "أسد", "بقرة", "برتقال", etc.

### Step 3: Name Your Images Correctly

The file names must match exactly what's in the code. Here's the naming:

**Animals (`assets/images/animals/`):**
- `asd.jpg` - أسد (Lion)
- `baqara.jpg` - بقرة (Cow)
- `tees.jpg` - تيس (Goat)
- `thalab.jpg` - ثعلب (Fox)
- `jamal.jpg` - جمل (Camel)
- `himar.jpg` - حمار (Donkey)
- `kharoof.jpg` - خروف (Sheep)
- `dub.jpg` - دب (Bear)
- `dhib.jpg` - ذئب (Wolf)
- `rana.jpg` - رنة (Reindeer)
- `zarafa.jpg` - زرافة (Giraffe)
- `samaka.jpg` - سمكة (Fish)
- `shaa.jpg` - شاة (Ram)
- `saqr.jpg` - صقر (Eagle)
- `difda.jpg` - ضفدع (Frog)
- `tawus.jpg` - طاووس (Peacock)
- `zabi.jpg` - ظبي (Gazelle)
- `asfour.jpg` - عصفور (Bird)
- `ghazal.jpg` - غزال (Gazelle)
- `feel.jpg` - فيل (Elephant)
- `qird.jpg` - قرد (Monkey)
- `kalb.jpg` - كلب (Dog)
- `labua.jpg` - لبؤة (Lioness)
- `maaz.jpg` - ماعز (Goat)
- `nimr.jpg` - نمر (Tiger)
- `hudhud.jpg` - هدهد (Hoopoe)
- `wahid.jpg` - وحيد القرن (Rhino)
- `yaasub.jpg` - يعسوب (Dragonfly)

**Objects (`assets/images/objects/`):**
- `arika.jpg` - أريكة (Sofa)
- `burtuqal.jpg` - برتقال (Orange)
- `tuffaha.jpg` - تفاحة (Apple)
- `thawb.jpg` - ثوب (Shirt)
- `jidar.jpg` - جدار (Wall)
- `haqiba.jpg` - حقيبة (Bag)
- `khazana.jpg` - خزانة (Cabinet)
- `daraja.jpg` - دراجة (Bicycle)
- `dhura.jpg` - ذرة (Corn)
- `radio.jpg` - راديو (Radio)
- `zujaja.jpg` - زجاجة (Bottle)
- `sayyara.jpg` - سيارة (Car)
- `shamsiya.jpg` - شمسية (Umbrella)
- `sunduq.jpg` - صندوق (Box)
- `dirs.jpg` - ضرس (Tooth)
- `taira.jpg` - طائرة (Airplane)
- `zarf.jpg` - ظرف (Envelope)
- `ajala.jpg` - عجلة (Wheel)
- `ghurfa.jpg` - غرفة (Room)
- `fustan.jpg` - فستان (Dress)
- `qalam.jpg` - قلم (Pen)
- `kitab.jpg` - كتاب (Book)
- `luaba.jpg` - لعبة (Toy)
- `miftah.jpg` - مفتاح (Key)
- `nafidha.jpg` - نافذة (Window)
- `hatif.jpg` - هاتف (Phone)
- `waraqa.jpg` - ورقة (Paper)
- `yakht.jpg` - يخت (Yacht)

**Nature (`assets/images/nature/`):**
- `ashjar.jpg` - أشجار (Trees)
- `bahr.jpg` - بحر (Sea)
- `turab.jpg` - تراب (Soil)
- `thamra.jpg` - ثمرة (Fruit)
- `jabal.jpg` - جبل (Mountain)
- `haql.jpg` - حقل (Field)
- `khudar.jpg` - خضار (Vegetables)
- `dawlab.jpg` - دولاب (Tornado)
- `dhura.jpg` - ذرة (Corn)
- `raml.jpg` - رمل (Sand)
- `zahra.jpg` - زهرة (Flower)
- `sama.jpg` - سماء (Sky)
- `shams.jpg` - شمس (Sun)
- `sahra.jpg` - صحراء (Desert)
- `dabab.jpg` - ضباب (Fog)
- `taqs.jpg` - طقس (Weather)
- `zill.jpg` - ظل (Shadow)
- `ushb.jpg` - عشب (Grass)
- `ghaba.jpg` - غابة (Forest)
- `fakiha.jpg` - فاكهة (Fruit)
- `qamar.jpg` - قمر (Moon)
- `kawkab.jpg` - كوكب (Planet)
- `layl.jpg` - ليل (Night)
- `matar.jpg` - مطر (Rain)
- `najma.jpg` - نجمة (Star)
- `hawa.jpg` - هواء (Air)
- `warda.jpg` - وردة (Rose)
- `yasmin.jpg` - ياسمين (Jasmine)

### Step 4: Copy Images to Folders

1. Copy your image files to:
   ```
   D:\arabic_letters_app\assets\images\animals\
   D:\arabic_letters_app\assets\images\objects\
   D:\arabic_letters_app\assets\images\nature\
   ```

2. Make sure file names match exactly (case-sensitive!)

### Step 5: Restart the App

After adding images, restart the Flutter app:
```bash
flutter run -d android
```

The app will automatically use the images instead of emojis!

---

## 🔊 How to Add/Change Sounds

### Step 1: Get Better Pronunciation Sounds

**Option A: Record Your Own (Best Quality)**
- Use a microphone to record clear Arabic pronunciation
- Record each word clearly: "أسد", "بقرة", "برتقال", etc.
- Use a quiet room for best quality

**Option B: Use Text-to-Speech (TTS)**
- The app already uses TTS as fallback if sound files are missing
- For better TTS, you can:
  - Use Google Translate's voice feature
  - Use online TTS services (like https://ttsmaker.com)
  - Use Arabic TTS apps on your phone

**Option C: Download Free Sounds**
- **Freesound.org** (https://freesound.org) - Free sound effects
- **Zapsplat** (https://www.zapsplat.com) - Free sound library
- **YouTube Audio Library** - Free music and sounds

### Step 2: Convert to MP3 Format

Sounds must be in `.mp3` format:
- Use **Audacity** (free) to convert: https://www.audacityteam.org
- Or use online converters: https://cloudconvert.com

### Step 3: Name Your Sound Files

**Animals (`assets/sounds/animals/`):**
- `lion.mp3` - أسد
- `cow.mp3` - بقرة
- `goat.mp3` - تيس
- `fox.mp3` - ثعلب
- `camel.mp3` - جمل
- `donkey.mp3` - حمار
- `sheep.mp3` - خروف
- `bear.mp3` - دب
- `wolf.mp3` - ذئب
- `frog.mp3` - ضفدع
- `peacock.mp3` - طاووس
- `elephant.mp3` - فيل
- `dog.mp3` - كلب
- `tiger.mp3` - نمر
- `rhino.mp3` - وحيد القرن

**Note:** Not all letters have sound files yet. You can add more!

### Step 4: Copy Sounds to Folder

1. Copy your `.mp3` files to:
   ```
   D:\arabic_letters_app\assets\sounds\animals\
   ```

2. Make sure file names match exactly!

### Step 5: Update Code (If Needed)

If you add sounds for objects or nature, update `lib/data/letter_data.dart`:

```dart
'ب': LetterItem(
  name: 'برتقال', 
  emoji: '🍊', 
  imagePath: 'assets/images/objects/burtuqal.jpg',
  soundPath: 'assets/sounds/objects/orange.mp3'  // Add this!
),
```

### Step 6: Restart the App

After adding sounds, restart the app. The sounds will play automatically!

---

## 🎯 Quick Checklist

- [ ] Download images for animals (28 images)
- [ ] Download images for objects (28 images)  
- [ ] Download images for nature (28 images)
- [ ] Name files correctly (check list above)
- [ ] Copy to correct folders
- [ ] Add sound files (optional, TTS works as fallback)
- [ ] Restart app to see changes

---

## 💡 Tips

1. **Image Quality:** Use clear, colorful images. Kids love bright colors!
2. **Sound Quality:** Keep sound files short (1-3 seconds) for best experience
3. **File Size:** Compress images if they're too large (>500KB each)
4. **Testing:** Test one image/sound first before adding all 84!

---

## 🆘 Troubleshooting

**Images not showing?**
- Check file names match exactly (case-sensitive)
- Check files are in correct folders
- Restart the app completely

**Sounds not playing?**
- Check file format is `.mp3`
- Check file names match
- App will use TTS as fallback if sound file missing

**Need help?** Check the file names in `lib/data/letter_data.dart` to see exact names needed!

