# To-Do List App with Weather Information 🌤️✅

## Overview

This project is a Flutter-based **To-Do List App with integrated Weather Information**.  
It allows users to create, view, edit, and delete tasks, as well as see current weather details based on device location.

---

## Features

- 🗒️ **Add, edit, delete tasks** with title and description.
- ✅ Mark tasks as high priority (long press).
- 🌤️ Display weather card on top of task list using [WeatherAPI](https://www.weatherapi.com/).
- 📍 Fetch weather using device location.
- 📄 View task details by tapping.
- 🗂️ Bottom navigation bar to toggle between All Tasks and High Priority Tasks.
- 💾 Local data persistence (e.g., using SQLite or suitable local storage method).
- 🔥 Responsive design for different screen sizes.
- ⚡ Error handling and input validation.

---

## Requirements (As per assignment)

1️⃣ Create a Flutter project using Dart.  
2️⃣ Design a user-friendly interface with:
- Task list
- Add, edit, delete buttons
- Input fields for tasks

3️⃣ Functionalities:
- Add new task (title, description)
- View and edit tasks
- Delete tasks
- Weather card integration
- Fetch weather using current location
- Bottom nav bar with tasks and high priority
- Mark tasks as high priority via context menu

4️⃣ Use local database (e.g., Room or SQLite) for task persistence.  
5️⃣ Handle various screen sizes gracefully.  
6️⃣ Add proper input validation.  
7️⃣ Write clear code comments.

---

## Development Challenges & Solutions 💡

Android NDK & SDK Issues

- **Problem**: Frequent build errors due to Android NDK versions mismatching (e.g., NDK 26.3.11579264 errors: *source.properties file missing*).
- **Solution**: Uninstalled conflicting NDK versions and installed only the required version (NDK 27.0.12077973) explicitly via SDK Manager.
- Updated `build.gradle.kts` to include:
```kotlin
android {
    ndkVersion = "27.0.12077973"
}

## Emulator & System UI Crashes
Problem: Emulator frequently froze or showed System UI not responding.
Solution:
        Upgraded PC RAM for smoother emulator performance.
        Used Pixel 7 API 33 as emulator device.
        Kept Android Emulator and platform tools up to date.

SDK Configuration & local.properties Errors
Problem: Errors like Windows file separators must be escaped in local.properties.

Solution:  Using Corrected paths (directories).

Gradle Plugin Conflicts
Problem: Errors due to different Gradle plugin versions (e.g., The request for this plugin could not be satisfied because already on classpath with different version).

Solution: Aligned all Gradle plugin versions in build.gradle.kts and used consistent plugin versions as recommended by Flutter.

Additional Notes 📝
1. Make sure to use NDK 27.0.12077973 to avoid build errors.
2. Use an updated emulator image (API 33 or above).
3. Ensure correct SDK and Flutter paths in local.properties.

Credits
Developed by Tushar 🚀| Open to Learn | Aspiring Full Stack Developer.


