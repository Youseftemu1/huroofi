# GitHub Workflow Guide - Huroofi App

This guide explains how to push changes to GitHub and update your repository.

## 📋 Table of Contents
1. [Initial Setup](#initial-setup)
2. [Pushing Changes to GitHub](#pushing-changes-to-github)
3. [Updating Files Next Time](#updating-files-next-time)
4. [Common Commands](#common-commands)
5. [Troubleshooting](#troubleshooting)

---

## 🚀 Initial Setup

Your repository is already configured:
- **Repository URL**: `https://github.com/Youseftemu1/huroofi.git`
- **Branch**: `main`
- **Username**: `Youseftemu1`

If you need to reconfigure, use:
```bash
git remote set-url origin https://github.com/Youseftemu1/huroofi.git
```

---

## 📤 Pushing Changes to GitHub

### Step 1: Check What Changed
```bash
git status
```
This shows:
- **Modified files** (M): Files you've changed
- **New files** (A): Files you've added
- **Untracked files** (??): Files not yet added to git

### Step 2: Add Your Changes
Add specific files:
```bash
git add lib/main.dart
git add lib/widgets/drop_zone.dart
```

Or add all changes at once:
```bash
git add .
```

**⚠️ Important**: Don't add these files (they're in `.gitignore`):
- `build/` folder
- `.dart_tool/` folder
- `local.properties`
- `olderbuild(working)/` folder

### Step 3: Commit Your Changes
```bash
git commit -m "Description of what you changed"
```

**Good commit messages:**
- `"Fix: Move fastlane to root for F-Droid"`
- `"Add: New feature for letter animations"`
- `"Update: Improve image loading performance"`
- `"Fix: Correct letter positioning in drop zone"`

### Step 4: Pull Latest Changes (if needed)
If someone else pushed changes, pull first:
```bash
git pull origin main
```

### Step 5: Push to GitHub
```bash
git push origin main
```

**✅ Success!** Your changes are now on GitHub.

---

## 🔄 Updating Files Next Time

### Quick Update Workflow

1. **Make your changes** to files in your project

2. **Check what changed:**
   ```bash
   git status
   ```

3. **Add your changes:**
   ```bash
   git add .
   ```
   Or add specific files:
   ```bash
   git add lib/main.dart lib/widgets/drop_zone.dart
   ```

4. **Commit with a message:**
   ```bash
   git commit -m "Your commit message here"
   ```

5. **Pull latest changes** (to avoid conflicts):
   ```bash
   git pull origin main
   ```

6. **Push to GitHub:**
   ```bash
   git push origin main
   ```

---

## 📝 Common Commands

### View Changes
```bash
# See what files changed
git status

# See what changed in a file
git diff lib/main.dart

# See commit history
git log --oneline
```

### Undo Changes
```bash
# Discard changes to a file (before committing)
git restore lib/main.dart

# Unstage a file (remove from git add)
git restore --staged lib/main.dart

# Undo last commit (keep changes)
git reset --soft HEAD~1
```

### Branch Management
```bash
# Create a new branch
git checkout -b feature-name

# Switch branches
git checkout main

# See all branches
git branch
```

### Update from GitHub
```bash
# Get latest changes from GitHub
git pull origin main
```

---

## 🐛 Troubleshooting

### Problem: "Updates were rejected because the remote contains work"
**Solution:**
```bash
git pull origin main
git push origin main
```

### Problem: "Merge conflicts"
**Solution:**
1. Open the conflicted file
2. Look for `<<<<<<<`, `=======`, `>>>>>>>` markers
3. Choose which version to keep
4. Remove the conflict markers
5. Save the file
6. Run:
   ```bash
   git add .
   git commit -m "Resolve merge conflict"
   git push origin main
   ```

### Problem: "Authentication failed"
**Solution:**
You may need to set up authentication:
- Use GitHub Personal Access Token (recommended)
- Or use SSH keys

### Problem: "Fastlane not found by F-Droid"
**Solution:**
Make sure `fastlane/` is at the **root** of your project, not in `android/fastlane/`:
```bash
# Check location
ls fastlane/

# Should show: Appfile, Fastfile, metadata/
```

---

## 📦 Creating Releases (for F-Droid)

When you want to create a new version:

1. **Update version in `pubspec.yaml`:**
   ```yaml
   version: 1.0.1+2
   ```

2. **Commit and push:**
   ```bash
   git add pubspec.yaml
   git commit -m "Bump version to 1.0.1"
   git push origin main
   ```

3. **Create a git tag:**
   ```bash
   git tag -a v1.0.1 -m "Release version 1.0.1"
   git push origin v1.0.1
   ```

4. **Update fastlane metadata:**
   - Edit `fastlane/metadata/android/en-US/changelogs/1.0.1.txt`
   - Add your changelog

5. **Commit fastlane changes:**
   ```bash
   git add fastlane/
   git commit -m "Update changelog for v1.0.1"
   git push origin main
   ```

---

## ✅ Checklist Before Pushing

- [ ] All changes are saved
- [ ] Ran `git status` to review changes
- [ ] Added files with `git add`
- [ ] Committed with a clear message
- [ ] Pulled latest changes (`git pull`)
- [ ] Pushed to GitHub (`git push`)

---

## 🔗 Useful Links

- **Your Repository**: https://github.com/Youseftemu1/huroofi
- **GitHub Docs**: https://docs.github.com
- **Git Cheat Sheet**: https://education.github.com/git-cheat-sheet-education.pdf

---

## 💡 Tips

1. **Commit often**: Small, frequent commits are better than large ones
2. **Write clear messages**: Describe what changed and why
3. **Pull before push**: Always pull latest changes before pushing
4. **Test before push**: Make sure your app works before committing
5. **Review changes**: Use `git diff` to see what you're committing

---

**Last Updated**: 2025-01-07
**Repository**: https://github.com/Youseftemu1/huroofi

