# Push to GitHub - Quick Guide

## Step 1: Create GitHub Repository

1. Go to: https://github.com/new
2. Repository name: `huroofi`
3. Description: "Huroofi - Arabic Letters Learning App for children"
4. Make it **Public** ✅
5. **DO NOT** check any boxes (no README, .gitignore, or license)
6. Click "Create repository"

## Step 2: Push Your Code

After creating the repository, run these commands:

```bash
git remote add origin https://github.com/Youseftemu1/huroofi.git
git branch -M main
git push -u origin main
```

Or if you want to use SSH:
```bash
git remote add origin git@github.com:Youseftemu1/huroofi.git
git branch -M main
git push -u origin main
```

## Step 3: Create Release Tag (for F-Droid)

After pushing, create a release tag:

```bash
git tag -a v1.0.0 -m "Release version 1.0.0"
git push origin v1.0.0
```

## Done! 🎉

Your repository is now on GitHub and ready for F-Droid submission!

