// This is a basic Flutter widget test.
import 'package:flutter_test/flutter_test.dart';
import 'package:gir_yatra/main.dart';

void main() {
  testWidgets('App builds without crashing', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const GirYatraApp());
    expect(find.byType(GirYatraApp), findsOneWidget);
  });
}
