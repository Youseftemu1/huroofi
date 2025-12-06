# New Folder Structure - Organized by Letter 📁

## Structure Overview

Each letter now has its own folder in each category. This makes it much easier to organize!

## Folder Structure

```
assets/sounds/
├── letters/                    (Letter pronunciations)
│   ├── ا/
│   │   └── ألف.mp3
│   ├── ب/
│   │   └── باء.mp3
│   ├── ت/
│   │   └── تاء.mp3
│   ├── ...
│   ├── ح/
│   │   └── حاء.mp3 ✅ (Your file goes here)
│   └── ي/
│       └── ياء.mp3
│
├── animals/                    (Animal word pronunciations)
│   ├── ا/
│   │   └── lion.mp3 (or أسد.mp3)
│   ├── ب/
│   │   └── cow.mp3 (or بقرة.mp3)
│   ├── ...
│   ├── ح/
│   │   └── donkey.mp3 ✅ (Your file goes here)
│   └── ي/
│       └── [animal].mp3
│
└── animal_sound_effect/         (Animal sound effects)
    ├── ا/
    │   └── lion.mp3
    ├── ب/
    │   └── cow.mp3
    ├── ...
    ├── ح/
    │   └── donkey.mp3 ✅ (Your file goes here)
    └── ي/
        └── [animal].mp3
```

## Complete Mapping for All 28 Letters

| Letter | Letter Folder | Letter File | Animal Folder | Animal File | Sound Effect Folder | Sound Effect File |
|--------|---------------|-------------|---------------|-------------|---------------------|-------------------|
| ا | `letters/ا/` | `ألف.mp3` | `animals/ا/` | `lion.mp3` | `animal_sound_effect/ا/` | `lion.mp3` |
| ب | `letters/ب/` | `باء.mp3` | `animals/ب/` | `cow.mp3` | `animal_sound_effect/ب/` | `cow.mp3` |
| ت | `letters/ت/` | `تاء.mp3` | `animals/ت/` | `goat.mp3` | `animal_sound_effect/ت/` | `goat.mp3` |
| ث | `letters/ث/` | `ثاء.mp3` | `animals/ث/` | `fox.mp3` | `animal_sound_effect/ث/` | `fox.mp3` |
| ج | `letters/ج/` | `جيم.mp3` | `animals/ج/` | `camel.mp3` | `animal_sound_effect/ج/` | `camel.mp3` |
| ح | `letters/ح/` | `حاء.mp3` ✅ | `animals/ح/` | `donkey.mp3` ✅ | `animal_sound_effect/ح/` | `donkey.mp3` ✅ |
| خ | `letters/خ/` | `خاء.mp3` | `animals/خ/` | `sheep.mp3` | `animal_sound_effect/خ/` | `sheep.mp3` |
| د | `letters/د/` | `دال.mp3` | `animals/د/` | `bear.mp3` | `animal_sound_effect/د/` | `bear.mp3` |
| ذ | `letters/ذ/` | `ذال.mp3` | `animals/ذ/` | `wolf.mp3` | `animal_sound_effect/ذ/` | `wolf.mp3` |
| ر | `letters/ر/` | `راء.mp3` | `animals/ر/` | - | `animal_sound_effect/ر/` | - |
| ز | `letters/ز/` | `زاي.mp3` | `animals/ز/` | - | `animal_sound_effect/ز/` | - |
| س | `letters/س/` | `سين.mp3` | `animals/س/` | - | `animal_sound_effect/س/` | - |
| ش | `letters/ش/` | `شين.mp3` | `animals/ش/` | - | `animal_sound_effect/ش/` | - |
| ص | `letters/ص/` | `صاد.mp3` | `animals/ص/` | - | `animal_sound_effect/ص/` | - |
| ض | `letters/ض/` | `ضاد.mp3` | `animals/ض/` | `frog.mp3` | `animal_sound_effect/ض/` | `frog.mp3` |
| ط | `letters/ط/` | `طاء.mp3` | `animals/ط/` | `peacock.mp3` | `animal_sound_effect/ط/` | `peacock.mp3` |
| ظ | `letters/ظ/` | `ظاء.mp3` | `animals/ظ/` | - | `animal_sound_effect/ظ/` | - |
| ع | `letters/ع/` | `عين.mp3` | `animals/ع/` | - | `animal_sound_effect/ع/` | - |
| غ | `letters/غ/` | `غين.mp3` | `animals/غ/` | - | `animal_sound_effect/غ/` | - |
| ف | `letters/ف/` | `فاء.mp3` | `animals/ف/` | `elephant.mp3` | `animal_sound_effect/ف/` | `elephant.mp3` |
| ق | `letters/ق/` | `قاف.mp3` | `animals/ق/` | - | `animal_sound_effect/ق/` | - |
| ك | `letters/ك/` | `كاف.mp3` | `animals/ك/` | `dog.mp3` | `animal_sound_effect/ك/` | `dog.mp3` |
| ل | `letters/ل/` | `لام.mp3` | `animals/ل/` | `lion.mp3` | `animal_sound_effect/ل/` | `lion.mp3` |
| م | `letters/م/` | `ميم.mp3` | `animals/م/` | `goat.mp3` | `animal_sound_effect/م/` | `goat.mp3` |
| ن | `letters/ن/` | `نون.mp3` | `animals/ن/` | `tiger.mp3` | `animal_sound_effect/ن/` | `tiger.mp3` |
| ه | `letters/ه/` | `هاء.mp3` | `animals/ه/` | - | `animal_sound_effect/ه/` | - |
| و | `letters/و/` | `واو.mp3` | `animals/و/` | `rhino.mp3` | `animal_sound_effect/و/` | `rhino.mp3` |
| ي | `letters/ي/` | `ياء.mp3` | `animals/ي/` | - | `animal_sound_effect/ي/` | - |

## Example for Letter ح (حمار)

Your files should be organized like this:

```
assets/sounds/
├── letters/
│   └── ح/
│       └── حاء.mp3 ✅
├── animals/
│   └── ح/
│       └── donkey.mp3 ✅
└── animal_sound_effect/
    └── ح/
        └── donkey.mp3 ✅
```

## Benefits of This Structure

✅ **Easy to find files** - All files for letter ح are in the `ح/` folder  
✅ **No confusion** - Each letter has its own folder  
✅ **Easy to organize** - Just put files in the right letter folder  
✅ **Clear structure** - See at a glance which letters have files  

## File Naming

- **Letter sounds:** Use Arabic letter name: `حاء.mp3`, `ألف.mp3`
- **Animal words:** Use English or Arabic: `donkey.mp3` or `حمار.mp3` (your choice!)
- **Sound effects:** Same as animal words: `donkey.mp3`

## Quick Reference

For any letter, the pattern is:
- Letter sound: `assets/sounds/letters/[LETTER]/[letter_name].mp3`
- Animal word: `assets/sounds/animals/[LETTER]/[animal].mp3`
- Sound effect: `assets/sounds/animal_sound_effect/[LETTER]/[animal].mp3`

Example for letter ب:
- `assets/sounds/letters/ب/باء.mp3`
- `assets/sounds/animals/ب/cow.mp3`
- `assets/sounds/animal_sound_effect/ب/cow.mp3`

---

**All folders have been created!** Just put your files in the correct letter folder! 🎉

