# Image Resolution Guide 📐

## Perfect Image Size for Your App

### Current Display Size
The images are displayed in a **120x120 pixel** container in the app.

### Recommended Resolutions

| Screen Type | Resolution | When to Use |
|-------------|------------|-------------|
| **Minimum** | 120x120 px | Basic phones (1x density) |
| **Recommended** | **240x240 px** | Most modern phones (2x density) ⭐ |
| **Best Quality** | 360x360 px | High-end phones (3x density) |

### ⭐ Best Choice: 240x240 pixels

**Why 240x240?**
- Works perfectly on most phones (iPhone, Android)
- Good balance between quality and file size
- Flutter automatically scales it down for smaller screens
- Looks sharp on high-DPI displays

### Image Specifications

```
Resolution: 240 x 240 pixels (square)
Format: JPG (recommended) or PNG
Aspect Ratio: 1:1 (must be square)
File Size: Under 200KB each (for fast loading)
Quality: High quality, clear images
```

### Important Notes

1. **Square Images Only**
   - The app uses `BoxFit.cover` which means:
   - Images will be cropped to fit if not square
   - Center of image will be shown
   - Best to use square images from the start

2. **Cropping Behavior**
   - If your image is 400x300 (rectangle), it will be cropped to 240x240
   - The center portion will be shown
   - Corners may be cut off

3. **File Size**
   - Keep images under 200KB each
   - Use JPG format for smaller files
   - Compress if needed (but maintain quality)

### How to Resize Images

**Option 1: Online Tools**
- https://www.iloveimg.com/resize-image
- https://imageresizer.com/
- Upload image → Set to 240x240 → Download

**Option 2: Photoshop/GIMP**
- Open image
- Image → Image Size
- Set to 240x240 pixels
- Save as JPG

**Option 3: Windows Paint**
- Open image
- Resize → Pixels → 240x240
- Save as JPG

### Example Workflow

1. Download image from Pexels (usually 1920x1080 or larger)
2. Resize to 240x240 pixels (square)
3. Save as JPG (quality 85-90%)
4. Check file size (should be <200KB)
5. Rename to match app (e.g., `asd.jpg`)
6. Copy to `assets/images/animals/`

### Testing Your Images

After adding images:
1. Restart the app
2. Check if image looks clear
3. Check if it fits properly (not stretched)
4. If blurry → use 360x360 instead
5. If too large file → compress more

### Quick Reference

```
✅ Good: 240x240 JPG, 150KB, square
✅ Good: 360x360 JPG, 180KB, square
❌ Bad: 1200x800 JPG (not square, too large)
❌ Bad: 50x50 PNG (too small, will be blurry)
❌ Bad: 2400x2400 JPG (too large file size)
```

### For Different Screen Sizes

The app displays images at 120x120 on screen, but:
- **Phone (small):** 120x120 source is fine
- **Phone (normal):** 240x240 source recommended
- **Tablet:** 240x240 or 360x360 source
- **High-DPI screens:** 360x360 source for best quality

**Recommendation:** Use **240x240 pixels** for all images - it works great on all devices! 🎯

