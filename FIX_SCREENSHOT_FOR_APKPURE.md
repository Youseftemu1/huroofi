# How to Fix Screenshot for APKPure

## APKPure Requirements:
- ✅ JPEG or 24-bit PNG (no alpha/transparency)
- ✅ Minimum dimension: 320px
- ✅ Maximum dimension: 3840px
- ✅ Maximum dimension ≤ 2x minimum dimension
- ✅ No performance/ranking/price info

## Common Issues:

### Issue 1: Alpha Channel (Transparency)
If your screenshot has transparency, APKPure will reject it.

**Fix:**
1. Open the image in any image editor (Paint, Photoshop, GIMP, etc.)
2. Make sure the background is solid (not transparent)
3. Save as JPEG (JPEG doesn't support transparency) OR
4. Save as PNG-24 without alpha channel

### Issue 2: Dimensions
Your screenshot must meet size requirements.

**Recommended sizes for Android screenshots:**
- **Portrait**: 1080x1920 (most common)
- **Landscape**: 1920x1080
- **Square**: 1080x1080

**Check your image:**
- Width: Should be between 320px and 3840px
- Height: Should be between 320px and 3840px
- Aspect ratio: Max dimension ÷ Min dimension ≤ 2

**Example:**
- ✅ 1080x1920: 1920 ÷ 1080 = 1.78 (OK, less than 2)
- ✅ 720x1280: 1280 ÷ 720 = 1.78 (OK)
- ❌ 500x2000: 2000 ÷ 500 = 4 (NOT OK, exceeds 2x)

### Issue 3: Format
Make sure it's JPEG or PNG-24 (not PNG-32 with alpha)

## How to Fix:

### Method 1: Using Windows Paint
1. Open your screenshot in Paint
2. Click "File" → "Save As"
3. Choose "JPEG picture" (this removes transparency automatically)
4. Save the file

### Method 2: Using Online Converter
1. Go to: https://convertio.co/png-jpg/ or https://ezgif.com/png-to-jpg
2. Upload your screenshot
3. Convert to JPEG
4. Download the converted image

### Method 3: Resize if Needed
If dimensions are wrong:
1. Open in Paint or any image editor
2. Resize to 1080x1920 (portrait) or 1920x1080 (landscape)
3. Save as JPEG

## Quick Checklist:
- [ ] Image is JPEG or PNG-24 (no alpha)
- [ ] Minimum dimension ≥ 320px
- [ ] Maximum dimension ≤ 3840px
- [ ] Max dimension ÷ Min dimension ≤ 2
- [ ] No transparent background
- [ ] No performance/ranking info visible

## Recommended Screenshot Specs:
- **Format**: JPEG
- **Size**: 1080x1920 pixels (portrait)
- **Quality**: High (80-90%)
- **Background**: Solid color (not transparent)

