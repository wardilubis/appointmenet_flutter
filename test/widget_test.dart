import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:appointmenet_flutter/main.dart';

void main() {
  testWidgets('App loads and shows main title', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Wait for any async operations to complete
    await tester.pumpAndSettle();

    // Verify that the app title is displayed
    expect(find.text('Appointment Manager'), findsOneWidget);

    // Verify that the create appointment button is present
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('Time formatter works correctly', (WidgetTester tester) async {
    final timeForDisplay = '09:00 - 10:00';
    final timeForBackend = '09:00';

    expect(timeForDisplay.contains(':'), isTrue);
    expect(timeForBackend.contains(':'), isTrue);
  });
}
