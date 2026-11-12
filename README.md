# Mobile Development Lab 4 – Round 3

A Flutter application with four tabs: a BMI calculator, a Morse code translator,
an alcohol purchasing-age calculator, and a multiple-choice quiz. The project
includes web and Windows desktop targets.

## Setup

### 1. Install Flutter and a browser

Install the stable Flutter SDK for your operating system using the
[official Flutter installation guide](https://docs.flutter.dev/install).
Flutter includes the Dart SDK. Add Flutter's `bin` directory to your `PATH`,
then reopen your terminal and IDE.

For example, a Windows installation might use `C:\src\flutter\bin`.
On macOS, use the `bin` directory inside your Flutter SDK installation.

Verify the installation:

```sh
flutter --version
flutter doctor -v
```

For the web version, install Google Chrome and confirm that it appears in
`flutter devices`. See Flutter's [web setup guide](https://docs.flutter.dev/platform-integration/web/setup).
Android SDK and Xcode/CocoaPods warnings do not block running this project in Chrome;
those tools apply to other platform targets.

### 2. Open the project root

Clone or download this repository, then open the folder containing `pubspec.yaml`.
Run the following commands from that folder, not from `lib/`, `web/`, or `windows/`.

If your terminal is currently in this project's `windows` folder:

```sh
cd ..
```

Install the project dependencies and list available devices:

```sh
flutter pub get
flutter devices
```

The project requires a Dart SDK compatible with `^3.5.0`, as specified in
`pubspec.yaml`. The latest local validation used Flutter 3.50.0 and Dart 3.14.0.
No API keys, environment files, or backend services are required.

### 3. Run the application

On macOS or Windows, launch the web version in Chrome:

```sh
flutter run -d chrome
```

Flutter opens a browser window and prints the local development URL. Keep the
terminal process running while using the app. In that terminal, press `r` to
hot reload changes, `R` to hot restart, or `q` to stop the application.

On Windows, you can also use Edge if it appears in `flutter devices`:

```sh
flutter run -d edge
```

For the native Windows desktop version, install Visual Studio with the
**Desktop development with C++** workload, resolve Windows toolchain issues
reported by `flutter doctor -v`, and run:

```sh
flutter run -d windows
```

Native Windows builds require Windows. Follow the
[Windows setup guide](https://docs.flutter.dev/platform-integration/windows/setup)
for the required tools; Visual Studio and Visual Studio Code are separate products.

This repository does not currently include Android, iOS, or macOS native target
folders. Running in Chrome on a Mac uses the existing web target.

## Application features

| Tab | Source file | Functionality |
| --- | --- | --- |
| BMI | `lib/bmi_tab.dart` | Calculates BMI from height in feet/inches and weight in pounds, and displays a BMI category. |
| Morse | `lib/morse_tab.dart` | Converts text to Morse code as you type. Words are separated by ` / `; unsupported characters appear as `?`. |
| Alcohol | `lib/alcohol_tab.dart` | Uses a date of birth and jurisdiction to calculate the purchasing-age date and remaining days. |
| Quiz | `lib/quiz_tab.dart` | Provides five multiple-choice questions, question navigation, swiping, score tracking, answer review, and restart. |

### Using the quiz

1. Open the **Quiz** tab and select one answer per question.
2. Move between questions using **Previous**, **Next**, or the numbered buttons.
   Swipe left or right on the question area; mouse dragging also works on desktop.
3. Review or change answers before finishing. The score updates from the current
   answers, so revisiting a question does not add duplicate points.
4. Answer all five questions to enable **Finish quiz**.
5. Finish to see the total correct answers and percentage. Browse the questions
   to review the correct answers; selections are locked after finishing.
6. Select **Restart quiz** to clear answers and return to the first question.

The progress bar shows how many questions have been answered. Switching tabs
preserves the current question and answers. Progress is stored in memory only;
restarting the app or reloading the browser resets it.

To customize the questions, edit `_questions` in `lib/quiz_tab.dart`. Each entry
contains the question text, answer options, and the zero-based index of the
correct option.

## What changed

The earlier app provided BMI, Morse, and Alcohol tabs. This update adds the quiz
and preserves tab state during navigation.

| File | Modification |
| --- | --- |
| `lib/quiz_tab.dart` | Added the quiz question data and interface, a `PageView` for swiping, navigation buttons, answer selection, score/progress tracking, results, review, and restart. Question content scrolls vertically on smaller screens. |
| `lib/main.dart` | Added the fourth navigation destination and Quiz page. Replaced direct page switching with an `IndexedStack` so tab state survives switching tabs. |
| `test/widget_test.dart` | Updated the navigation test to check all four tabs. |
| `test/quiz_tab_test.dart` | Added tests for scoring after answer changes, button and swipe navigation, tab persistence, completion, locked answers, restart, and a small-phone layout. |
| `README.md` | Replaced the outdated Hello World description and documented installation, launch commands, features, implementation changes, and validation. |

The quiz uses Flutter's existing widgets and does not add third-party packages.
The BMI, Morse, and Alcohol calculations were not modified in this update.

## Tests and build checks

Run these commands from the project root:

```sh
flutter analyze
flutter test --concurrency=1
flutter build web
```

The test command runs widget tests sequentially. A successful web build writes
its output to `build/web/`.

Latest local validation on macOS with Flutter 3.50.0 / Dart 3.14.0:

- All three widget tests passed.
- The web build completed successfully.
- Static analysis reported six informational deprecation notices for
  `package:flutter/material.dart`, which is used throughout the app. No analyzer
  errors were reported. The import migration remains separate work; the analyzer
  command may return a nonzero exit status while these notices remain.

These checks validate the quiz behavior and web compilation. Native Windows and
mobile builds were not validated during this update.

## Troubleshooting

| Problem | What to check |
| --- | --- |
| `flutter` is not found | Add the Flutter SDK's `bin` folder to `PATH`, then reopen the terminal and IDE. |
| `pubspec.yaml` cannot be found | Change to the repository root. If you are in `windows/`, run `cd ..`. |
| Chrome is not listed | Install Chrome, then rerun `flutter devices`. |
| Android or Xcode warnings appear | For Chrome, check the Flutter and Chrome entries in `flutter doctor`; configure other toolchains when you need those targets. |
| The first launch reports a shader compiler failure | Retry the launch. A retry resolved the initial failure in this setup. If it persists, use `flutter run -d chrome -v` and `flutter doctor -v` to collect diagnostics. |
| Tests close before loading | Retry with `flutter test --concurrency=1`. This completed successfully in the local setup. |

## Project structure

```text
lib/
├── main.dart           # App entry point and four-tab navigation
├── bmi_tab.dart        # BMI calculator
├── morse_tab.dart      # Morse code translator
├── alcohol_tab.dart    # Purchasing-age calculator
└── quiz_tab.dart       # Quiz data, navigation, scoring, and results
test/
├── widget_test.dart    # Four-tab navigation test
└── quiz_tab_test.dart  # Quiz interaction and small-screen tests
web/                   # Web platform files
windows/               # Windows desktop platform files
pubspec.yaml           # SDK constraints and dependencies
pubspec.lock           # Locked dependency versions
```
