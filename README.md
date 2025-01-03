# DataVista

DataVista is a modern Flutter application designed to fetch, display, and interact with data seamlessly. It features a beautiful user interface, detailed item views, a dynamic form with validation, and an integrated audio player. Built using the Bloc state management pattern, the app ensures a clean architecture and efficient state handling.

---

## Features

1. **API Integration**:
   - Fetches data from an API and displays it in a visually appealing UI.
   
2. **Detailed Item View**:
   - Presents detailed information about individual items/products upon selection.

3. **Dynamic Form**:
   - A form with fields like Name, Email, Phone, Gender, Country, State, and City.
   - Includes proper validation for each field to ensure data integrity.

4. **Audio Player**:
   - Plays audio files stored in assets using a clean and simple player interface.

5. **State Management**:
   - Implements Bloc for state management to maintain a modular and scalable codebase.

---

## Tech Stack

- **Framework**: Flutter
- **Programming Language**: Dart
- **State Management**: Bloc
- **API Calls**: `http` package
- **Audio Playback**: `just_audio` package

---

## Directory Structure

```
lib/
├── bloc/
│   ├── product_bloc.dart
│   └── form_bloc.dart
├── models/
│   └── product.dart
├── screens/
│   ├── product_list_screen.dart
│   ├── product_detail_screen.dart
│   ├── registration_form.dart
│   └── audio_player_screen.dart
└── main.dart

assets/
└── audio/
    └── sample.mp3

test/
└── bloc_test/
    └── product_bloc_test.dart
```

---

## How to Run the App

1. Clone the repository:
   ```bash
   git clone <repository_url>
   ```

2. Navigate to the project directory:
   ```bash
   cd DataVista
   ```

3. Get the dependencies:
   ```bash
   flutter pub get
   ```

4. Run the application:
   ```bash
   flutter run
   ```

---

## Dependencies

Below are the major dependencies used in this project:

- **flutter_bloc**: For Bloc state management.
- **http**: For making API calls.
- **just_audio**: For implementing the audio player.

Install all dependencies using:
```bash
flutter pub get
```

---

## License

This project is licensed under the MIT License. See the LICENSE file for details.

---

## Acknowledgements

- [Flutter Documentation](https://flutter.dev/docs)
- [Bloc Documentation](https://bloclibrary.dev/)
- [just_audio Package](https://pub.dev/packages/just_audio)
- [http Package](https://pub.dev/packages/http)

