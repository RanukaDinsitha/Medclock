import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:medclock/main.dart';

void main() {
  testWidgets('shows the daily schedule and medication list', (tester) async {
    await tester.pumpWidget(const MedclockApp());

    expect(find.text('medclock'), findsOneWidget);
    expect(find.text("Today's schedule"), findsOneWidget);
    expect(find.text('Vitamin D'), findsOneWidget);

    await tester.tap(find.text('MEDICATIONS'));
    await tester.pumpAndSettle();

    expect(find.text('My medications'), findsOneWidget);
    expect(find.text('Vitamin C'), findsOneWidget);
  });

  testWidgets('adds a medication from the editor', (tester) async {
    await tester.pumpWidget(const MedclockApp());
    await tester.tap(find.byTooltip('Add medication'));
    await tester.pumpAndSettle();

    expect(find.text('Add medication'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField), 'Iron');
    await tester.tap(find.text('SAVE REMINDER'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('MEDICATIONS'));
    await tester.pumpAndSettle();
    expect(find.text('Iron'), findsOneWidget);
  });

  testWidgets('marking a reminder as taken updates today progress', (
    tester,
  ) async {
    await tester.pumpWidget(const MedclockApp());
    await tester.tap(find.byTooltip('Open reminder for Vitamin D'));
    await tester.pumpAndSettle();

    expect(find.text('MEDICATION REMINDER'), findsOneWidget);
    await tester.tap(find.text('MARK AS TAKEN'));
    await tester.pumpAndSettle();

    expect(find.text('1 of 3 taken'), findsOneWidget);
  });

  testWidgets('display settings update the schedule time format', (
    tester,
  ) async {
    await tester.pumpWidget(const MedclockApp());
    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(Switch).at(1));
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();

    expect(find.text('08:00'), findsOneWidget);
  });

  testWidgets('deleting a medication removes it from the list', (tester) async {
    await tester.pumpWidget(const MedclockApp());
    await tester.tap(find.text('MEDICATIONS'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Vitamin B12'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Delete medication'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('DELETE'));
    await tester.pumpAndSettle();

    expect(find.text('Vitamin B12'), findsNothing);
    expect(find.text('My medications'), findsOneWidget);
  });
}
