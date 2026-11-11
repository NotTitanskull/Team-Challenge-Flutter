# app_dev_flutter

A small Flutter app that displays a “Hello, world!” screen.

## Install Flutter

1. Follow the [official Flutter installation guide](https://docs.flutter.dev/install) for your operating system. Flutter includes the Dart SDK.
2. On Windows, extract the Flutter SDK to a folder such as `C:\src\flutter`, add `C:\src\flutter\bin` to your `PATH`, and reopen your terminal.
3. Check your setup:

   ```powershell
   flutter --version
   flutter doctor -v
   ```

   Install any tools reported as missing by `flutter doctor`. To run the Windows desktop version, install Visual Studio with the **Desktop development with C++** workload.

## Set up and run this project

Open a terminal in the project folder and run:

```powershell
flutter pub get
flutter devices
```

Choose Windows or Edge from the devices shown by `flutter devices`:

```powershell
flutter run -d windows
flutter run -d edge
```

Run the widget tests with:

```powershell
flutter test
```

## Round 2 – New Features

The app now has a bottom navigation bar with three tabs:

| Tab | File | What it does |
|-----|------|--------------|
| BMI | `lib/bmi_tab.dart` | Enter height (ft/in) and weight (lbs). Calculates BMI and shows the category: Underweight (<18.5), Normal (18.5–24.9), Overweight (25–29.9), Obese (30+). |
| Morse | `lib/morse_tab.dart` | Converts text to Morse code as you type. Letters are separated by spaces, words by ` / `. Unsupported characters show as `?`. |
| Alcohol | `lib/alcohol_tab.dart` | Pick a date of birth and a jurisdiction. Shows the date you reach the legal purchasing age and how many days are left. |

### Tested with
- Flutter 3.50.0 (stable) / Dart 3.14.0
- Windows 11, running in Chrome (`flutter run -d chrome`)

### Project Structure
```
lib/
├── main.dart          # App entry + bottom tab navigation
├── bmi_tab.dart       # BMI Calculator
├── morse_tab.dart     # Morse Code Translator
└── alcohol_tab.dart   # When Can I Buy Alcohol?
test/
└── widget_test.dart   # Checks that the three tabs load
```

### Notes
- This project has no `android/` or `ios/` folder. To run it on a phone, run `flutter create --platforms=android .` first.
- If `flutter` isn't recognized after installing, make sure `C:\src\flutter\bin` is in your PATH, then restart your terminal or VS Code.
