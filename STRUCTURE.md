# Project Structure Documentation: Plasfora App

This document explains the folder and file organization of the Plasfora Flutter project. Use it to quickly understand where to find code, assets, and platform-specific files.

---

## Root Directory

- `pubspec.yaml` / `pubspec.lock`: Flutter dependencies and asset declarations
- `README.md`: Project overview
- `DOCUMENTATION.md`: Main project documentation
- `analysis_options.yaml`: Linting and analysis rules

## Main Folders

### `lib/`

- `main.dart`: App entry point
- `pages/`: Screens and views (e.g., home, details, etc.)
- `widgets/`: Reusable UI components

### `assets/`

Organized by content type and feature:

- `images/`: General images (icons, banners, etc.)
- `videos/`: Video files for procedures and promotions
- `plasticSurgery/`: Images related to plastic surgery
- `HairTransplant/`: Hair transplant images
- `IVF/`: IVF procedure images
- `healthy_holiday/`: Wellness and holiday images
- `acceuil/`: Welcome and landing images
- `visit_tunisia/`: Tunisia travel images

### Platform Folders

- `android/`, `ios/`, `linux/`, `macos/`, `windows/`, `web/`: Platform-specific code and configuration
  - Each contains build scripts, platform runners, and settings

### `build/`

- Generated files and build artifacts

### `test/`

- Widget and unit tests for the app

---

## Example Structure

```
lib/
  main.dart
  pages/
  widgets/
assets/
  images/
  videos/
  plasticSurgery/
  HairTransplant/
  IVF/
  healthy_holiday/
  acceuil/
  visit_tunisia/
android/
  app/
  gradle/
ios/
macos/
windows/
web/
test/
```

---

## Notes

- All asset folders are referenced in `pubspec.yaml` for easy access in code.
- Platform folders allow building for Android, iOS, desktop, and web from a single codebase.
- The `lib/` folder contains all Dart source code.
- The `test/` folder is for automated testing.

For more details, see `DOCUMENTATION.md` or ask for specifics about any folder or file.
