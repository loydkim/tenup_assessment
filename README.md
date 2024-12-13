# Tenup project - Restaurant tour

* Key Features
1. Networking Integration
- GraphQL: Integrated using the Dio package for efficient API communication.
- Yelp Developers API: Provides restaurant data, including details like reviews, ratings, and locations.

2. UI Composition
- Built with Flutter Widgets, ensuring a clean and reusable user interface.

3. State Management
- Utilized the Provider package for simple yet effective state management.

4. Data Persistence
- Implemented Hive for local database storage, ensuring fast and reliable offline access to data.

5. Testing
- Unit Tests
Comprehensive unit tests for:
packages/yelp_api: Testing API-related functionalities.
packages/local_db: Ensuring the reliability of data persistence.

- Unit and Widget Tests
Unit and widget tests are located in:
test/unit_test: Covers logic and functionality tests.
test/widget_test: Ensures UI components behave as expected.

6. Animations
- Hero Animation: Smooth transitions between pages for an engaging user experience.
- Automatic Drag PageView: Enables effortless page swiping.
- SliverAppBar: Dynamic collapsible app bar for the Restaurant Details Page.

I attached the demo videos in the file.
- iOS: ios_demo.mov
- Android: android_demo.mov

* How to build
run "flutter pub get" in the top directory and run.

* Contact information

- LinkedIn: https://www.linkedin.com/public-profile/settings?trk=d_flagship3_profile_self_view_public_profile
- Email: kimloydmail@gmail.com
- Github: https://github.com/loydkim

* Develop Environment ( Flutter doctor -v) 

[✓] Flutter (Channel stable, 3.24.5, on macOS 15.1.1 24B2091 darwin-arm64,
    locale en-CA)
    • Flutter version 3.24.5 on channel stable
    • Dart version 3.5.4
    • DevTools version 2.37.3

[✓] Android toolchain - develop for Android devices (Android SDK version 34.0.0)
    • Platform android-34, build-tools 34.0.0
    • Java version OpenJDK Runtime Environment (build 21.0.3+-79915917-b509.11)

[✓] Xcode - develop for iOS and macOS (Xcode 16.1)
    • Build 16B40
    • CocoaPods version 1.16.2

[✓] Android Studio (version 2024.2)
    • Android Studio at /Applications/Android Studio.app/Contents
    • Java version OpenJDK Runtime Environment (build 21.0.3+-79915917-b509.11)

[✓] VS Code (version 1.96.0)
    • Flutter extension version 3.102.0