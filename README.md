# GreenMart — Grocery App Prototype

Flutter grocery app prototype with product browsing, local search, and login form UI.

**Built with:** Flutter and Dart · **Category:** UI prototype

## Preview

<img width="1920" height="1006" alt="GreenMart - Grocery App Prototype screenshot 1" src="https://github.com/user-attachments/assets/e0141c47-8eb0-4022-bf92-fb93e038c2ba" />

<img width="1882" height="992" alt="GreenMart - Grocery App Prototype screenshot 2" src="https://github.com/user-attachments/assets/2f804dee-5e59-4614-9dfa-641df6fdfada" />

## Features

- Splash screen followed by a home screen with exclusive offers and best-selling products.
- Product search that filters a local sample catalog by name.
- Bottom navigation with Home, Explore, Cart, Favorites, and Account tabs.
- Separate welcome and login screens, with email/password validation and password visibility control.
- SVG assets and bundled Poppins fonts.

## Current scope

Frontend prototype using local sample data. The default flow goes from the splash screen to Home after about six seconds, bypassing Welcome and Login. Explore, Cart, Favorites, and Account currently show placeholder text. Login only validates the form; real authentication, checkout, persistence, and cart actions are not implemented.

## Run locally

Use a Flutter SDK whose bundled Dart version satisfies `^3.10.7` (the constraint in `pubspec.yaml`). Configure a device or emulator for your target platform.

```bash
git clone https://github.com/Mohamed-Ahmed984/GreenMart.git
cd GreenMart
flutter pub get
flutter devices
flutter run
```

An internet connection is needed for the remote images used by this app. Image availability depends on their external hosts.

Platform scaffolding is included for `android`, `ios`, `linux`, `macos`, `web`, `windows`. These folders do not imply every platform has been tested.

## Code guide

| Path | Purpose |
| --- | --- |
| [`lib/main.dart`](lib/main.dart) | Application entry point and theme setup. |
| [`lib/Core/Features/intro/`](lib/Core/Features/intro/) | Splash and welcome screens. |
| [`lib/Core/Features/aut/page/`](lib/Core/Features/aut/page/) | Login form UI. |
| [`lib/Core/Features/home/`](lib/Core/Features/home/) | Product data, home screen, and search. |
| [`lib/Core/Features/main/`](lib/Core/Features/main/) | Bottom navigation shell. |
| [`Assets/`](Assets/) | Images, SVG icons, and fonts. |

## Explore more

[Browse my projects by category](https://github.com/Mohamed-Ahmed984/Github#project-directory).
