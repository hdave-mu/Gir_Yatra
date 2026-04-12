import 'package:flutter_test/flutter_test.dart';

import 'package:gir_yatra/main.dart';

void main() {
  testWidgets('App boots to splash', (WidgetTester tester) async {
    await tester.pumpWidget(const GirYatraApp());
    await tester.pump();
    expect(find.text('Gir Yatra'), findsWidgets);
  });
}
