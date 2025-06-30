	Building a simple To-Do list app with weather information using flutter.

The goal of this assignment is to evaluate the candidates ability to develop a basic flutter app. This app will allow users to create,view, edit and delete tasks in a to-do list along with displaying weather information.

### Requirements:
1.  Create a flutter project using dart.

2. Design a user-friendly interface for the to-do list app. Include following components:
- (i) A list to display tasks.
- (ii) Buttons to add, edit and delete tasks.
- (iii) Tasks input fields for adding and editing tasks.

3. Implement the following functionality:
   
- (i) Add a new task with a title and description.
- (ii) Display a list of tasks with their titles.
- (iii) Tap on a task to view its details (title and description).
- (iv) Edit the title and description of a task.
- (v) Delete a task
- (vi) Adding weather card on top of to-do list
- (vii) Create a free account in https://www.weatherapi.com/, get the API key using which integrates it to the app.
- (viii) Showcase the beautiful weather card on top of the the list on the homr page.
- (ix) The weather details should be fetched using the current device location.
- (x) The main screen should have a bottom nav bar with 2 options, one to list the items in to-do list and the second to list high priority which was marked from in Todo list view.
- (xi)To-do list items can be marked as high priority by long pressing an item and selecting high priority from the context menu.

4. Use room database or a data persistence method of your choice to store and retrieve tasks.

5. Ensures that the app handles diferent screen sizes and orientations gracefully (responsive design).

6. Add appropriate error handling and validation for user inputs.

7. Provide clear and concise comments on the code to explain its functionality.

---

## Development Challenges & Solutions 💡

Android NDK & SDK Issues

- **Problem**: Frequent build errors due to Android NDK versions mismatching (e.g., NDK 26.3.11579264 errors: *source.properties file missing*).
- **Solution**: Uninstalled conflicting NDK versions and installed only the required version (NDK 27.0.12077973) explicitly via SDK Manager.
- Updated """build.gradle.kts""" to include:
```kotlin
/*android {
    ndkVersion = "27.0.12077973"
} */ 
```

---

## Emulator & System UI Crashes
    Problem: Emulator frequently froze or showed System UI not responding.
    Solution:
            Upgraded PC RAM for smoother emulator performance.
            Used Pixel 7 API 33 as emulator device.
            Kept Android Emulator and platform tools up to date.

### SDK Configuration & local.properties Errors
    Problem: Errors like Windows file separators must be escaped in local.properties.

    Solution:  Using Corrected paths (directories).

### Gradle Plugin Conflicts
    Problem: Errors due to different Gradle plugin versions (e.g., The request for this plugin could not be satisfied because already on classpath with different version).

    Solution: Aligned all Gradle plugin versions in build.gradle.kts and used consistent plugin versions as recommended by Flutter.

### Additional Notes 📝
1. Make sure to use NDK 27.0.12077973 to avoid build errors.
2. Use an updated emulator image (API 33 or above).
3. Ensure correct SDK and Flutter paths in local.properties.

Credits
Developed by Tushar 🚀| Open to Learn | Aspiring Full Stack Developer.
