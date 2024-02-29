# Flutter Installation and App Run Guide

This guide provides step-by-step instructions to install Flutter and run a Flutter app on an Android emulator.

## Prerequisites

Before you begin, make sure you have the following installed on your system:

- **Flutter SDK**: [Install Flutter](https://flutter.dev/docs/get-started/install)
- **Android Studio**: [Install Android Studio](https://developer.android.com/studio)
- **Flutter and Dart plugins for your preferred IDE**: Install plugins for [VS Code](https://flutter.dev/docs/get-started/editor) or [IntelliJ/Android Studio](https://flutter.dev/docs/get-started/editor-intellij)

## Steps

### 1. Install Flutter

Follow the instructions on the [official Flutter installation page](https://flutter.dev/docs/get-started/install) to download and install the Flutter SDK on your machine.

### 2. Set up your IDE

- **VS Code**: Install the Flutter and Dart extensions.
- **IntelliJ/Android Studio**: Install the Flutter and Dart plugins.

### 3. Configure Flutter

Run the following command in your terminal to ensure Flutter is properly configured:

```bash
flutter doctor
```
Fix any issues reported by flutter doctor before proceeding.

### 4.  Install dependencies

Navigate to your Flutter project directory and run:

```bash
flutter pub get
```
This command installs the dependencies specified in your pubspec.yaml file.

### 5. Launch Android Emulator

Open Android Studio and launch the Android Virtual Device (AVD) manager. Create a new virtual device if you haven't already.

### 6. Run your Flutter app

Use the following command to run your Flutter app on the Android emulator or alternatively, use the specific run buttons on Flutter supported IDE.

```bash
flutter run
```

That's it, it will build and run the Flutter app on the Android Emulator.