# flutter_ignite

🚀 **flutter_ignite** is a lightweight yet powerful package designed to streamline GetX development by reducing boilerplate code. It provides essential utilities such as theme management, caching, and various helper tools to accelerate your Flutter projects.

## ✨ Features
- **Built-in Theme Service** – Easily manage light/dark themes with GetX.
- **Cache Service** – Simple key-value storage powered by GetStorage.
- **Utility Tools** – Handy extensions and functions for common tasks.
- **Seamless GetX Integration** – Designed to fit naturally into GetX projects.

## 📦 Installation
Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_ignite: latest_version
```

Then, run:
```sh
dart pub get
```

## 🚀 Usage
### Initialize flutter_ignite
```dart
import 'package:flutter_ignite/flutter_ignite.dart';

void main() {
  Ignite.init();
  runApp(MyApp());
}
```

### Using Theme Service
```dart
Ignite.theme.toggleTheme(); // Switch between light and dark mode
```

### Using Cache Service
```dart
Ignite.cache.write("token", "12345");
var token = Ignite.cache.read("token");
```

## 🎯 Why Use flutter_ignite?
- Reduces repetitive code
- Makes GetX development smoother
- Provides essential tools for scalable apps

## 📄 License
This project is licensed under the MIT License.
