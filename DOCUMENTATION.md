# Plasfora App

Plasfora is a Flutter application designed to provide a rich, interactive experience for users interested in medical tourism, healthy holidays, and related services in Tunisia. This documentation covers the project structure, setup, and key features.

## Table of Contents
- [Project Overview](#project-overview)
- [Features](#features)
- [Project Structure](#project-structure)
- [Setup & Installation](#setup--installation)
- [Dependencies](#dependencies)
- [Assets](#assets)
- [Development](#development)
- [Testing](#testing)
- [Contributing](#contributing)
- [License](#license)

---

## Project Overview
Plasfora connects users with medical, wellness, and travel services in Tunisia. It offers:
- Information on medical procedures
- Holiday packages
- Interactive maps
- Multimedia content (images, videos)

## Features
- **Medical Tourism:** Details on plastic surgery, IVF, hair transplant, dental care, and more.
- **Healthy Holidays:** Explore wellness retreats and holiday packages.
- **Interactive Map:** Locate clinics, hotels, and attractions.
- **Media Gallery:** Rich images and videos for each service.
- **Multi-language Support:** Internationalization via the `intl` package.
- **Modern UI:** Custom icons, fonts, and beautiful design.

## Project Structure
```
lib/
  main.dart           # App entry point
  pages/              # Screens and pages
  widgets/            # Reusable UI components
assets/
  images/             # General images
  videos/             # Video files
  plasticSurgery/     # Plastic surgery images
  HairTransplant/     # Hair transplant images
  IVF/                # IVF images
  healthy_holiday/    # Wellness images
  acceuil/            # Welcome images
  visit_tunisia/      # Tunisia travel images
android/, ios/, linux/, macos/, windows/, web/ # Platform-specific code
```

## Setup & Installation
1. **Prerequisites:**
   - [Flutter SDK](https://flutter.dev/docs/get-started/install)
   - Dart SDK (included with Flutter)
2. **Clone the repository:**
   ```powershell
   git clone https://github.com/Mimi88888/Plasfora.git
   cd Plasfora
   ```
3. **Install dependencies:**
   ```powershell
   flutter pub get
   ```
4. **Run the app:**
   ```powershell
   flutter run
   ```

## Dependencies
Key packages used:
- `flutter`, `cupertino_icons`: Core Flutter UI
- `url_launcher`, `image_picker`, `file_picker`: Device integration
- `chewie`, `video_player`: Video playback
- `google_fonts`, `font_awesome_flutter`, `lucide_icons`, `iconsax`, `flutter_svg`: UI/Icons
- `country_picker`, `intl`: Internationalization
- `flutter_map`, `latlong2`: Maps
- `http`, `provider`: Networking & state management
- `carousel_slider`, `path_drawing`: UI enhancements
- `build_runner`, `json_serializable`: Code generation

See `pubspec.yaml` for full list.

## Assets
All images and videos are stored in the `assets/` directory. Asset paths are declared in `pubspec.yaml` under the `flutter/assets` section.

## Development
- **Hot Reload:** Use `flutter run` and save files for instant updates.
- **Code Generation:**
  ```powershell
  flutter pub run build_runner build
  ```
- **Linting:**
  ```powershell
  flutter analyze
  ```

## Testing
- Unit and widget tests are in the `test/` directory.
- Run tests:
  ```powershell
  flutter test
  ```

## Contributing
Contributions are welcome! Please:
- Fork the repo
- Create a feature branch
- Submit a pull request
- Follow Dart/Flutter best practices

## License
This project is not published to pub.dev and is intended for private use. See repository for license details.

---

**Enjoy exploring Plasfora!**
