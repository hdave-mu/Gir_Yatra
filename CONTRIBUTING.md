# Contributing to Gir Yatra

Thank you for your interest in contributing to Gir Yatra! This document provides guidelines and instructions for contributing to the project.

## Code of Conduct

Be respectful, inclusive, and professional in all interactions.

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK
- Git
- An IDE (VS Code, Android Studio, or IntelliJ)

### Setup Development Environment

```bash
# Clone the repository
git clone https://github.com/hdave-mu/Gir_Yatra.git

# Navigate to project
cd Gir_Yatra

# Get dependencies
flutter pub get

# Run the app
flutter run
```

## Making Changes

### Branch Naming Convention

```
feature/description           # New feature
bugfix/description           # Bug fix
hotfix/description           # Urgent fix
docs/description             # Documentation
```

Example: `feature/add-location-filter`

### Commit Messages

Follow conventional commits:

```
type(scope): subject

feat(screens): add new location details screen
fix(widgets): resolve shimmer animation bug
docs(README): update setup instructions
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

### Code Style

#### Dart/Flutter Guidelines

- Follow [Dart Style Guide](https://dart.dev/guides/language/effective-dart)
- Use meaningful variable and function names
- Add comments for complex logic
- Maximum line length: 80 characters
- Use `const` for constant values

#### File Organization

```dart
// Imports
import 'package:flutter/material.dart';

// Constants
const Duration kAnimationDuration = Duration(milliseconds: 300);

// Classes/Widgets
class MyWidget extends StatelessWidget {
  // Constructor
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

### Performance Considerations

- Check [Performance Guide](lib/utils/PERFORMANCE_GUIDE.md)
- Use `const` constructors when possible
- Avoid rebuilds with proper widget structure
- Optimize images before committing

## Testing

### Running Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/widget_test.dart
```

### Writing Tests

- Add tests for new features
- Use descriptive test names
- Test edge cases and error scenarios
- Keep tests focused and independent

Example:

```dart
testWidgets('CustomCard displays title correctly', (WidgetTester tester) async {
  await tester.pumpWidget(
    const MaterialApp(
      home: Scaffold(
        body: CustomCard(title: 'Test Title'),
      ),
    ),
  );

  expect(find.text('Test Title'), findsOneWidget);
});
```

## Pull Request Process

### Before Submitting

1. Update your branch with latest main: `git pull origin main`
2. Run all tests: `flutter test`
3. Check code formatting: `dart format .`
4. Fix linting issues: `dart analyze`
5. Build successfully: `flutter build apk` (or web/windows)

### PR Description Template

```markdown
## Description

Brief description of changes

## Type of Change

- [ ] New feature
- [ ] Bug fix
- [ ] Breaking change
- [ ] Documentation update

## Related Issues

Closes #(issue number)

## Testing Done

Description of testing performed

## Screenshots (if applicable)

Add relevant screenshots

## Checklist

- [ ] Code follows project style guidelines
- [ ] Tests added/updated
- [ ] Documentation updated
- [ ] No new warnings generated
- [ ] All tests passing
```

## Directory Structure Guidelines

### Adding a New Screen

```
lib/screens/
├── new_feature_screen.dart    # Screen widget
└── [optional] new_feature_provider.dart  # State management
```

### Adding New Widgets

```
lib/widgets/
├── new_widget.dart
└── new_widget_constants.dart  # If needed
```

### Adding Data/Models

```
lib/data/
├── new_data.dart
└── new_models.dart
```

## Common Tasks

### Running Specific Configurations

```bash
# Debug mode
flutter run

# Release mode
flutter run --release

# Profile mode (performance testing)
flutter run --profile

# Web
flutter run -d web-server

# Windows
flutter run -d windows
```

### Updating Dependencies

```bash
# Check for updates
flutter pub outdated

# Upgrade dependencies
flutter pub upgrade

# Add new dependency
flutter pub add package_name
```

## Reporting Issues

### Bug Reports

Include:

- Detailed description
- Steps to reproduce
- Expected vs actual behavior
- Flutter/Dart versions
- Device/platform information
- Screenshots/logs if applicable

### Feature Requests

Include:

- Clear description of feature
- Use cases and benefits
- Possible implementation approach
- Mockups/designs if available

## Documentation

### Code Documentation

- Add comments for complex logic
- Use documentation comments (///) for public APIs
- Keep README.md updated

Example:

```dart
/// Builds a custom card widget with optional filtering.
///
/// The [title] parameter is required and displays at the top.
/// [onTap] callback is triggered when card is tapped.
class CustomCard extends StatelessWidget {
  const CustomCard({
    required this.title,
    this.onTap,
  });

  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    // Implementation
  }
}
```

## Questions or Need Help?

- Check existing issues and discussions
- Review [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md)
- Check [Performance Guide](lib/utils/PERFORMANCE_GUIDE.md)
- Open an issue with detailed questions

## License

By contributing to Gir Yatra, you agree that your contributions will be licensed under the same license as the project.

---

Thank you for contributing to Gir Yatra! 🚀
