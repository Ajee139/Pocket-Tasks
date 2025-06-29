# Pocket Tasks

**Pocket Tasks** is a simple and efficient task manager app developed using Flutter. It allows users to create, edit, and manage their tasks in a clean interface with support for both light and dark themes.

---

## Features

- Add new tasks with optional notes and due dates
- Edit or remove existing tasks
- Mark tasks as completed or active
- Filter tasks by status: All, Active, Completed
- Sort tasks by creation time or due date
- Switch between dark and light modes
- Local storage with Hive for persistent task data
- Smooth animations for task interactions
- Tested with unit and widget tests for reliability

---

## Tools & Libraries Used

| Purpose              | Technology         |
|----------------------|--------------------|
| UI & Framework       | Flutter            |
| State Management     | Provider           |
| Local Database       | Hive               |
| Theming              | Material 3         |
| Animation            | Flutter built-ins  |
| Testing              | flutter_test, hive_test |

---

## How to Run the App

### 1. Install dependencies:
In terminal: 
  flutter pub get

### 2. Launch the app:
In project directory terminal, run: 
  flutter run


### 3. Run tests:
In project directory terminal, run:
  flutter test


### 4. Build APK:
```
flutter build spk or flutter build apk --split-per-abi if you want smaller, architecture specific files.
```

---

## Theme Handling

The app uses light and dark themes that respond to the state provided by the user.
```dart
theme: lightTheme,
darkTheme: darkTheme,
themeMode: provider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
```
Colors and text styles are defined to match the chosen mode.

---

## Project Structure

/lib
  ├── models        // Task model with Hive annotations
  ├── providers     // TaskProvider for state logic
  ├── screens       // Main and Add/Edit task pages
  ├── theme         // Light and dark themes
  ├── widgets       // Reusable UI components
/test
  ├── task_model_test.dart
  ├── task_provider_test.dart
  ├── sort_filter_logic_test.dart
  ├── task_tile_widget_test.dart
```

---

## Credits

- Flutter & Dart teams
- Google Stitch
- Contributors to Hive and Provider
- Material Design guidelines

---

Developed by **Adesoji Ajijolaoluwa David** (ajeeflutterdev@gmail.com)
