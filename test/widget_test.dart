import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aavaz/main.dart';

void main() {
  testWidgets('NFC Screen displays read and write buttons', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const MyApp());

    // Verify the AppBar title
    expect(find.text('NFC Reader & Writer'), findsOneWidget);

    // Check for Read and Write buttons
    expect(find.text('READ NFC TAG'), findsOneWidget);
    expect(find.text("WRITE 'Hello NFC!' TO TAG"), findsOneWidget);

    // Tap the Read button and check if the scanning dialog appears
    await tester.tap(find.text('READ NFC TAG'));
    await tester.pump(); // showDialog is async; wait for frame

    expect(find.text('Scanning...'), findsOneWidget);
    expect(find.text('Please hold your device near the NFC tag.'), findsOneWidget);
  });
}
