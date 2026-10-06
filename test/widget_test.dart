import 'dart:convert';
import 'dart:ffi' show Abi;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';

import 'package:medclock/main.dart';
import 'package:medclock/medclock_record.dart';

void main() {
  late Directory databaseDirectory;
  late Isar isar;

  setUpAll(() async {
    final packageConfigFile = File(
      '${Directory.current.path}${Platform.pathSeparator}'
      '.dart_tool${Platform.pathSeparator}package_config.json',
    );
    final packageConfig = jsonDecode(
      await packageConfigFile.readAsString(),
    ) as Map<String, dynamic>;
    final packages = packageConfig['packages'] as List<dynamic>;
    final isarFlutterLibs = packages.cast<Map<String, dynamic>>().firstWhere(
      (package) => package['name'] == 'isar_flutter_libs',
    );
    final rootUri = packageConfigFile.uri.resolve(
      isarFlutterLibs['rootUri'] as String,
    );
    final packageRoot = rootUri.path.endsWith('/')
        ? rootUri
        : rootUri.replace(path: '${rootUri.path}/');
    final libraryPath = packageRoot
        .resolve(
          Platform.isWindows
              ? 'windows/isar.dll'
              : Platform.isMacOS
              ? 'macos/libisar.dylib'
              : 'linux/libisar.so',
        )
        .toFilePath();
    await Isar.initializeIsarCore(libraries: {Abi.current(): libraryPath});
  });

  setUp(() async {
    databaseDirectory = await Directory.systemTemp.createTemp('medclock_test_');
    isar = await Isar.open([
      MedicationRecordSchema,
      DoseRecordSchema,
      AppStateRecordSchema,
    ], directory: databaseDirectory.path);
  });

  tearDown(() async {
    await isar.close(deleteFromDisk: true);
    await databaseDirectory.delete(recursive: true);
  });

  testWidgets('shows the daily schedule and medication list', (tester) async {
    await tester.pumpWidget(MedclockApp(isar: isar));

    final theme = tester.widget<MaterialApp>(find.byType(MaterialApp)).theme!;
    expect(theme.textTheme.titleLarge?.fontFamily, 'Inter');
    expect(theme.textTheme.bodyMedium?.fontFamily, 'Figtree');
    final logo = tester.widget<Image>(find.byType(Image));
    expect(logo.image, isA<AssetImage>());
    expect((logo.image as AssetImage).assetName, 'assets/images/Medclock.png');
    expect(find.text("Today's schedule"), findsOneWidget);
    expect(find.text('Vitamin D'), findsOneWidget);

    await tester.tap(find.text('MEDICATIONS'));
    await tester.pumpAndSettle();

    expect(find.text('My medications'), findsOneWidget);
    expect(find.text('Vitamin C'), findsOneWidget);
  });

  testWidgets('adds a medication from the editor', (tester) async {
    await tester.pumpWidget(MedclockApp(isar: isar));
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
    await tester.pumpWidget(MedclockApp(isar: isar));
    await tester.tap(find.byTooltip('Open reminder for Vitamin D'));
    await tester.pumpAndSettle();

    expect(find.text('MEDICATION REMINDER'), findsOneWidget);
    await tester.tap(find.text('MARK AS TAKEN'));
    await tester.pumpAndSettle();

    expect(find.text('1 of 3 taken'), findsOneWidget);
  });

  testWidgets('starting a medicine timer is separate and persists', (
    tester,
  ) async {
    await tester.pumpWidget(MedclockApp(isar: isar));
    await tester.pumpAndSettle();
    await tester.tap(find.text('TIMERS'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('I took medicine'));
    await tester.pumpAndSettle();

    expect(find.text('I took medicine'), findsOneWidget);
    await tester.enterText(find.byType(TextField).last, 'Pain relief');
    await tester.tap(find.text('START TIMER'));
    await tester.pumpAndSettle();
    expect(find.text('Pain relief'), findsOneWidget);
    expect(find.textContaining('Available again at'), findsOneWidget);
    final records = await isar.doseRecords.where().findAll();
    expect(records, hasLength(1));
    expect(records.single.name, 'Pain relief');
  });

  testWidgets('restores an active medicine timer from storage', (tester) async {
    final record = DoseRecord()
      ..name = 'Stored medication'
      ..takenAt = DateTime.now()
      ..repeatHours = 6;
    await isar.writeTxn(() => isar.doseRecords.put(record));

    await tester.pumpWidget(MedclockApp(isar: isar));
    await tester.pumpAndSettle();
    await tester.tap(find.text('TIMERS'));
    await tester.pumpAndSettle();

    expect(find.text('Stored medication'), findsOneWidget);
    expect(find.text('Medicine timers'), findsOneWidget);
  });

  testWidgets('display settings update the schedule time format', (
    tester,
  ) async {
    await tester.pumpWidget(MedclockApp(isar: isar));
    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(Switch).at(1));
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();

    expect(find.text('08:00'), findsOneWidget);
  });

  testWidgets('deleting a medication removes it from the list', (tester) async {
    await tester.pumpWidget(MedclockApp(isar: isar));
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
