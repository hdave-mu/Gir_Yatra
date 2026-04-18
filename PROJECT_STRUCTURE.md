# Gir Yatra - Project Structure

## Overview

Gir Yatra is a Flutter-based tourism guide application for Sasan Gir, Gujarat. This document describes the organization of the project.

## Directory Structure

```
gir_yatra/
├── android/              # Android native code and configuration
│   ├── app/             # Android app module
│   ├── gradle/          # Gradle configuration
│   └── build.gradle.kts # Build configuration
├── windows/             # Windows desktop platform code
│   ├── runner/          # Windows app runner
│   └── flutter/         # Flutter Windows integration
├── web/                 # Web platform code
│   └── index.html       # Web entry point
├── lib/                 # Main Dart source code
│   ├── main.dart        # Application entry point
│   ├── animations/      # Custom animations and painters
│   │   ├── firefly_painter.dart
│   │   ├── forest_light_painter.dart
│   │   └── page_transitions.dart
│   ├── screens/         # UI screens
│   │   ├── checklist_screen.dart
│   │   ├── emergency_screen.dart
│   │   ├── food_culture_screen.dart
│   │   ├── home_screen.dart
│   │   ├── itinerary_screen.dart
│   │   ├── nearby_places_screen.dart
│   │   ├── safari_screen.dart
│   │   ├── search_screen.dart
│   │   ├── seasonal_screen.dart
│   │   ├── splash_screen.dart
│   │   ├── stay_screen.dart
│   │   └── transport_screen.dart
│   ├── widgets/         # Reusable UI widgets
│   │   ├── contact_actions.dart
│   │   ├── custom_card.dart
│   │   ├── filter_bar.dart
│   │   └── shimmer_skeleton.dart
│   ├── data/            # Data models and static data
│   │   ├── static_data.dart
│   │   └── extra_data.dart
│   ├── state/           # State management
│   │   └── app_state.dart
│   ├── theme/           # Theme configuration
│   │   ├── app_theme.dart
│   │   └── design_tokens.dart
│   └── utils/           # Utility functions
│       ├── performance_utils.dart
│       └── PERFORMANCE_GUIDE.md
├── Image/               # Image assets (JPG, PNG)
│   └── [Various location images]
├── test/                # Unit and widget tests
│   └── widget_test.dart
├── .vscode/             # VS Code settings
├── .gitignore           # Git ignore configuration
├── pubspec.yaml         # Flutter dependencies and metadata
├── pubspec.lock         # Locked dependency versions (generated)
├── analysis_options.yaml # Dart analysis configuration
└── README.md            # Project documentation
```

## Key Directories

### `/lib` - Application Source Code

- **animations/**: Custom animation effects and painters for visual elements
- **screens/**: Complete pages and screens of the application
- **widgets/**: Reusable UI components
- **data/**: Static data and models
- **state/**: Application state management
- **theme/**: Design system and theming
- **utils/**: Utility functions and performance monitoring

### `/android` - Android Platform Code

Platform-specific code for Android devices:

- Native configuration and build setup
- Android app resources and manifests

### `/web` - Web Platform Code

Web deployment configuration:

- Web-specific HTML and assets
- Responsive design adaptations

### `/Image` - Assets

Image resources used throughout the application (approximately 9.47 MB)

## Configuration Files

- **pubspec.yaml**: Defines dependencies, app metadata, and build settings
- **analysis_options.yaml**: Dart linting and analysis rules
- **.gitignore**: Specifies files to ignore in version control

## File Size Summary

| Directory | Size          |
| --------- | ------------- |
| Image     | 9.47 MB       |
| android   | 7.61 MB       |
| lib       | 0.44 MB       |
| web       | 0.12 MB       |
| windows   | 0.07 MB       |
| Others    | 0.22 MB       |
| **Total** | **~17.93 MB** |

## Development Guidelines

### Adding New Screens

1. Create a new file in `/lib/screens/`
2. Follow the naming convention: `feature_screen.dart`
3. Use consistent widget structure and theming

### Creating New Widgets

1. Add reusable widgets to `/lib/widgets/`
2. Document widget parameters and usage
3. Keep widgets focused and composable

### Managing State

- Use `/lib/state/app_state.dart` for global state
- Consider performance implications (see `PERFORMANCE_GUIDE.md`)

### Styling

- Use design tokens from `/lib/theme/design_tokens.dart`
- Maintain consistency with `app_theme.dart`

## Performance Considerations

See [Performance Guide](lib/utils/PERFORMANCE_GUIDE.md) for:

- Optimization best practices
- Memory management
- Rendering optimization
- Image loading strategies

## Building and Running

```bash
# Get dependencies
flutter pub get

# Run on connected device
flutter run

# Build APK
flutter build apk

# Build web version
flutter build web

# Run tests
flutter test
```

## Git Workflow

- Main branch is production-ready
- All unnecessary generated files are in .gitignore
- Keep commits focused and well-documented

## License

[See LICENSE file for details]
