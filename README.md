```markdown
# WealthAppTest

Minimal Flutter To‑Do app to demonstrate a CI build that produces a debug APK you can download and install quickly.

What's included
- lib/main.dart — simple todo app using shared_preferences
- pubspec.yaml — dependencies
- .github/workflows/flutter-android-build.yml — GitHub Actions workflow that installs Android SDK (API 28) and builds a debug APK

Quick start — create repo and push
1. Locally initialize and push the repo (replace <your-username>):
   git init
   git add .
   git commit -m "Initial commit - WealthAppTest"
   git branch -M main
   git remote add origin git@github.com:<your-username>/WealthAppTest.git
   git push -u origin main

2. Trigger CI
- Push to main (or open a PR against main). GitHub Actions will run the "Build Flutter Debug APK" workflow and produce an artifact named `app-debug-apk`.

3. Download the debug APK
- In the Actions run, open the job and download the artifact `app-debug-apk`.
- The APK path in the artifact will be: build/app/outputs/flutter-apk/app-debug.apk

4. Install on a real device (Android 9 / API 28)
- Connect your Android 9 device with USB debugging enabled.
- adb install -r path/to/app-debug.apk

5. (Optional) Run an Android 9 emulator locally (commands)
- Ensure Android SDK & emulator are installed.
- sdkmanager "system-images;android-28;google_apis;x86_64"
- avdmanager create avd -n test_api_28 -k "system-images;android-28;google_apis;x86_64" --device "pixel"
- emulator -avd test_api_28 -no-window -no-audio &

Then:
- flutter install
or
- adb install -r build/app/outputs/flutter-apk/app-debug.apk

Notes & next steps
- Debug APK is unsigned for release and intended for testing. It installs quickly and is debuggable (useful for debugging).
- When you're ready to produce a signed release APK/AAB for Play Store or distribution, you can:
  - Generate a keystore with keytool
  - Base64-encode the keystore and add repository secrets (KEYSTORE_BASE64, KEYSTORE_PASSWORD, KEY_ALIAS, KEY_PASSWORD)
  - Switch to the release workflow (or re-enable the signed steps)
- If you want, I can restore the signed-release workflow and provide exact instructions for adding the secrets via the GitHub CLI.

License: MIT
```