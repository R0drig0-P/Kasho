import 'package:flutter_test/flutter_test.dart';

import 'package:kasho/main.dart';

void main() {
  testWidgets('Kasho app launches', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const KashoApp());

    // Verify that the dashboard loads
    expect(find.text('Kasho'), findsWidgets);
  });
}
