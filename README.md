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
