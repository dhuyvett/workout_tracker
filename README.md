# Workout Tracker

A privacy-first fitness monitoring application that tracks workouts without compromising personal data.

## Overview

Workout Tracker is an offline-first, local-only workout tracking application designed for privacy-conscious athletes and fitness enthusiasts. Unlike traditional fitness apps that upload data to cloud servers, this application stores all data locally on your device with zero network transmission.

**Core Principles:**
- **Privacy-First Architecture:** All data stored locally with encrypted database
- **Offline-Only Operation:** Full functionality without network connection
- **Simplicity Over Features:** Clean, focused tracking without social features or complexity
- **Zero PII Collection:** No accounts, emails, or personally identifiable information required
- **Minimal Permissions:** Only essential permissions for core functionality

**Current Features:**
- Bluetooth heart rate monitor integration (in development)
- Real-time heart rate display with color-coded zones
- Continuous data recording to encrypted local database
- Basic session statistics (duration, avg/min/max HR)

**Planned Features:**
- GPS-based speed and distance tracking
- Enhanced analytics and historical visualization
- CSV data export

## Repository Layout

```
workout_tracker/
├── lib/                          # Application source code
│   └── main.dart                 # Application entry point
├── test/                         # Widget and unit tests
├── agent-os/                     # Development planning and specifications
│   ├── product/                  # Product documentation
│   │   ├── mission.md            # Product vision and strategy
│   │   ├── roadmap.md            # Development roadmap
│   │   └── tech-stack.md         # Technical architecture decisions
│   └── specs/                    # Feature specifications
│       └── 2025-11-20-bluetooth-hr-monitoring/
│           ├── spec.md           # Detailed feature specification
│           ├── tasks.md          # Implementation task breakdown
│           └── planning/         # Requirements and research
├── android/                      # Android-specific configuration
├── ios/                          # iOS-specific configuration
├── linux/                        # Linux desktop configuration
├── macos/                        # macOS desktop configuration
├── windows/                      # Windows desktop configuration
├── web/                          # Web-specific configuration
├── pubspec.yaml                  # Flutter dependencies and configuration
├── analysis_options.yaml         # Dart analyzer configuration
└── CLAUDE.md                     # Development guidance for Claude Code
```

## Development

### Prerequisites
- Flutter SDK ^3.10.0
- Dart SDK (included with Flutter)
- Platform-specific development tools (Android Studio, Xcode, etc.)

### Running the Application
```bash
flutter run                    # Run on connected device/emulator
flutter run -d chrome          # Run on Chrome (web)
flutter run -d linux           # Run on Linux desktop
```

### Testing
```bash
flutter test                   # Run all tests
flutter test --coverage        # Run tests with coverage
```

### Code Quality
```bash
flutter analyze                # Run static analysis
```

## Platform Support

- Android
- iOS
- Web
- Linux Desktop
- macOS Desktop
- Windows Desktop

## License

See LICENSE file for details.
