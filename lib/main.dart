import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'medclock_record.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  final isar = await Isar.open([
    MedicationRecordSchema,
    DoseRecordSchema,
    AppStateRecordSchema,
  ], directory: directory.path);
  runApp(MedclockApp(isar: isar));
}

const _green = Color(0xFF3C9A62);
const _darkGreen = Color(0xFF246B45);
const _lightGreen = Color(0xFFE7F3EA);
const _muted = Color(0xFF6D7971);
const _canvas = Color(0xFFF4F7F3);
const _ink = Color(0xFF202A23);

class MedclockApp extends StatelessWidget {
  const MedclockApp({required this.isar, super.key});

  final Isar isar;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'medclock',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Figtree',
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontFamily: 'Inter'),
          displayMedium: TextStyle(fontFamily: 'Inter'),
          displaySmall: TextStyle(fontFamily: 'Inter'),
          headlineLarge: TextStyle(fontFamily: 'Inter'),
          headlineMedium: TextStyle(fontFamily: 'Inter'),
          headlineSmall: TextStyle(fontFamily: 'Inter'),
          titleLarge: TextStyle(fontFamily: 'Inter'),
          titleMedium: TextStyle(fontFamily: 'Inter'),
          titleSmall: TextStyle(fontFamily: 'Inter'),
        ),
        primaryColor: _green,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _green,
          primary: _green,
          secondary: _darkGreen,
          surface: Colors.white,
        ),
        scaffoldBackgroundColor: _canvas,
        appBarTheme: const AppBarTheme(
          backgroundColor: _darkGreen,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          toolbarHeight: 64,
          titleTextStyle: TextStyle(
            fontFamily: 'Inter',
            fontSize: 19,
            color: Colors.white,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: _green,
          foregroundColor: Colors.white,
          elevation: 3,
          shape: CircleBorder(),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 13,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE1E8E2)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE1E8E2)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: _green, width: 1.5),
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      home: MedclockHome(isar: isar),
    );
  }
}

class _MedclockLogo extends StatelessWidget {
  const _MedclockLogo();

  @override
  Widget build(BuildContext context) => ClipRect(
    child: SizedBox(
      width: 128,
      height: 42,
      child: OverflowBox(
        alignment: const Alignment(0, -0.08),
        minWidth: 260,
        maxWidth: 260,
        minHeight: 260,
        maxHeight: 260,
        child: Image.asset(
          'assets/images/Medclock.png',
          width: 260,
          height: 260,
          semanticLabel: 'Medclock',
        ),
      ),
    ),
  );
}

class Medication {
  Medication({
    this.id,
    required this.name,
    required this.strength,
    required this.amount,
    required this.time,
    this.repeat = 'Every day',
    this.notes = '',
    this.enabled = true,
  });

  int? id;
  String name;
  String strength;
  String amount;
  TimeOfDay time;
  String repeat;
  String notes;
  bool enabled;

  String get schedule =>
      [amount, strength].where((value) => value.isNotEmpty).join(' · ');
}

class MedicationSettings {
  const MedicationSettings({
    this.reminderSound = 'Gentle bell',
    this.snoozeMinutes = 10,
    this.vibrate = true,
    this.twentyFourHour = false,
    this.showAnalogClock = true,
  });

  final String reminderSound;
  final int snoozeMinutes;
  final bool vibrate;
  final bool twentyFourHour;
  final bool showAnalogClock;
}

class DoseLog {
  DoseLog({
    this.id,
    required this.name,
    required this.takenAt,
    required this.repeatHours,
  });

  int? id;
  final String name;
  final DateTime takenAt;
  final int repeatHours;

  DateTime get nextDoseAt => takenAt.add(Duration(hours: repeatHours));
}

enum ReminderAction { taken, snoozed, skipped }

String formatTime(TimeOfDay time, {bool twentyFourHour = false}) {
  final hour = twentyFourHour
      ? time.hour.toString().padLeft(2, '0')
      : (time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod).toString();
  final minute = time.minute.toString().padLeft(2, '0');
  if (twentyFourHour) return '$hour:$minute';
  final period = time.period == DayPeriod.am ? 'AM' : 'PM';
  return '$hour:$minute $period';
}

MedicationRecord _recordFromMedication(Medication medication) =>
    MedicationRecord()
      ..id = medication.id ?? Isar.autoIncrement
      ..name = medication.name
      ..strength = medication.strength
      ..amount = medication.amount
      ..minuteOfDay = medication.time.hour * 60 + medication.time.minute
      ..repeat = medication.repeat
      ..notes = medication.notes
      ..enabled = medication.enabled;

Medication _medicationFromRecord(MedicationRecord record) => Medication(
  id: record.id,
  name: record.name,
  strength: record.strength,
  amount: record.amount,
  time: TimeOfDay(
    hour: record.minuteOfDay ~/ 60,
    minute: record.minuteOfDay % 60,
  ),
  repeat: record.repeat,
  notes: record.notes,
  enabled: record.enabled,
);

class MedclockHome extends StatefulWidget {
  const MedclockHome({required this.isar, super.key});

  final Isar isar;

  @override
  State<MedclockHome> createState() => _MedclockHomeState();
}

class _MedclockHomeState extends State<MedclockHome> {
  MedicationSettings _settings = const MedicationSettings();
  final Set<Medication> _takenToday = {};
  final List<DoseLog> _doseLogs = [];
  final List<Medication> _medications = [];
  Timer? _countdownTicker;
  Timer? _doseExpiryTimer;
  bool _loading = true;
  bool _expiringDoseLogs = false;

  List<Medication> _starterMedications() => [
    Medication(
      name: 'Vitamin D',
      strength: '1,000 IU',
      amount: '1 softgel',
      time: const TimeOfDay(hour: 8, minute: 0),
    ),
    Medication(
      name: 'Vitamin C',
      strength: '500 mg',
      amount: '1 tablet',
      time: const TimeOfDay(hour: 12, minute: 0),
    ),
    Medication(
      name: 'Magnesium',
      strength: '200 mg',
      amount: '1 tablet',
      time: const TimeOfDay(hour: 20, minute: 0),
    ),
    Medication(
      name: 'Vitamin B12',
      strength: '1,000 mcg',
      amount: '1 tablet',
      time: const TimeOfDay(hour: 9, minute: 0),
      repeat: 'Mon, Wed, Fri',
      enabled: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    unawaited(_loadData());
  }

  @override
  void dispose() {
    _countdownTicker?.cancel();
    _doseExpiryTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadData() async {
    final isar = widget.isar;
    final appState = await isar.appStateRecords.get(0);
    var medicationRecords = await isar.medicationRecords.where().findAll();
    if (appState == null) {
      final starterMedications = medicationRecords.isEmpty
          ? _starterMedications()
          : <Medication>[];
      final starterRecords = starterMedications
          .map(_recordFromMedication)
          .toList();
      await isar.writeTxn(() async {
        if (starterRecords.isNotEmpty) {
          await isar.medicationRecords.putAll(starterRecords);
        }
        await isar.appStateRecords.put(
          AppStateRecord()
            ..starterMedicationsLoaded = true
            ..reminderSound = 'Gentle bell'
            ..snoozeMinutes = 10
            ..vibrate = true
            ..twentyFourHour = false
            ..showAnalogClock = true,
        );
      });
      medicationRecords = await isar.medicationRecords.where().findAll();
    }
    final savedSettings = await isar.appStateRecords.get(0);
    if (savedSettings == null) {
      throw StateError('Medclock settings were not initialized.');
    }

    final doseRecords = await isar.doseRecords.where().findAll();
    final now = DateTime.now();
    final activeDoseRecords = doseRecords
        .where((record) => record.nextDoseAt.isAfter(now))
        .toList();
    final expiredIds = doseRecords
        .where((record) => !record.nextDoseAt.isAfter(now))
        .map((record) => record.id)
        .toList();
    if (expiredIds.isNotEmpty) {
      await isar.writeTxn(() => isar.doseRecords.deleteAll(expiredIds));
    }

    if (!mounted) return;
    setState(() {
      _medications
        ..clear()
        ..addAll(medicationRecords.map(_medicationFromRecord));
      _doseLogs
        ..clear()
        ..addAll(
          activeDoseRecords.map(
            (record) => DoseLog(
              id: record.id,
              name: record.name,
              takenAt: record.takenAt,
              repeatHours: record.repeatHours,
            ),
          ),
        );
      _settings = MedicationSettings(
        reminderSound: savedSettings.reminderSound,
        snoozeMinutes: savedSettings.snoozeMinutes,
        vibrate: savedSettings.vibrate,
        twentyFourHour: savedSettings.twentyFourHour,
        showAnalogClock: savedSettings.showAnalogClock,
      );
      _loading = false;
    });
    _syncCountdownTicker();
  }

  Future<void> _editMedication({Medication? medication}) async {
    final result = await Navigator.of(context).push<Medication>(
      MaterialPageRoute(
        builder: (_) => MedicationFormPage(
          medication: medication,
          onDelete: medication == null
              ? null
              : () => _deleteMedication(medication),
        ),
      ),
    );
    if (result == null || !mounted) return;
    result.id = medication?.id;
    final record = _recordFromMedication(result);
    await widget.isar.writeTxn(() => widget.isar.medicationRecords.put(record));
    result.id = record.id;
    if (!mounted) return;
    setState(() {
      if (medication == null) {
        _medications.add(result);
      } else {
        final index = _medications.indexOf(medication);
        if (index != -1) _medications[index] = result;
      }
    });
  }

  Future<void> _deleteMedication(Medication medication) async {
    final id = medication.id;
    if (id != null) {
      await widget.isar.writeTxn(
        () => widget.isar.medicationRecords.delete(id),
      );
    }
    if (!mounted) return;
    setState(() {
      _medications.remove(medication);
      _takenToday.remove(medication);
    });
  }

  Future<void> _persistMedicationChanges() async {
    final records = _medications.map(_recordFromMedication).toList();
    await widget.isar.writeTxn(
      () => widget.isar.medicationRecords.putAll(records),
    );
    if (!mounted) return;
    for (var index = 0; index < _medications.length; index++) {
      _medications[index].id = records[index].id;
    }
    setState(() {});
  }

  Future<void> _openReminder(Medication medication) async {
    final action = await Navigator.of(context).push<ReminderAction>(
      MaterialPageRoute(
        builder: (_) =>
            ReminderPage(medication: medication, settings: _settings),
      ),
    );
    if (action == null || !mounted) return;
    if (action == ReminderAction.taken) {
      setState(() => _takenToday.add(medication));
    }
    final message = switch (action) {
      ReminderAction.taken => '${medication.name} marked as taken',
      ReminderAction.snoozed =>
        'Reminder snoozed for ${_settings.snoozeMinutes} minutes',
      ReminderAction.skipped => 'Dose skipped',
    };
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  Future<void> _openSettings() async {
    final settings = await Navigator.of(context).push<MedicationSettings>(
      MaterialPageRoute(builder: (_) => SettingsPage(settings: _settings)),
    );
    if (settings == null || !mounted) return;
    final savedSettings = await widget.isar.appStateRecords.get(0);
    if (savedSettings == null) {
      throw StateError('Medclock settings were not initialized.');
    }
    savedSettings
      ..reminderSound = settings.reminderSound
      ..snoozeMinutes = settings.snoozeMinutes
      ..vibrate = settings.vibrate
      ..twentyFourHour = settings.twentyFourHour
      ..showAnalogClock = settings.showAnalogClock;
    await widget.isar.writeTxn(
      () => widget.isar.appStateRecords.put(savedSettings),
    );
    if (mounted) setState(() => _settings = settings);
  }

  Future<void> _logDose(DoseLog log) async {
    final record = DoseRecord()
      ..name = log.name
      ..takenAt = log.takenAt
      ..repeatHours = log.repeatHours;
    await widget.isar.writeTxn(() => widget.isar.doseRecords.put(record));
    log.id = record.id;
    if (!mounted) return;
    setState(() {
      _doseLogs.insert(0, log);
    });
    _syncCountdownTicker();
  }

  Future<void> _startDoseTimer() async {
    await _showDoseLogDialog(context, _logDose);
  }

  void _syncCountdownTicker() {
    _countdownTicker?.cancel();
    _doseExpiryTimer?.cancel();
    if (_doseLogs.isEmpty) {
      _countdownTicker = null;
      _doseExpiryTimer = null;
    } else {
      _countdownTicker = Timer.periodic(
        const Duration(minutes: 1),
        (_) => _refreshDoseTimers(),
      );
      final nextExpiry = _doseLogs
          .map((log) => log.nextDoseAt)
          .reduce((first, second) => first.isBefore(second) ? first : second);
      final untilExpiry = nextExpiry.difference(DateTime.now());
      _doseExpiryTimer = Timer(
        untilExpiry.isNegative ? Duration.zero : untilExpiry,
        _refreshDoseTimers,
      );
    }
  }

  Future<void> _refreshDoseTimers() async {
    if (_expiringDoseLogs) return;
    final now = DateTime.now();
    final expired = _doseLogs
        .where((log) => !log.nextDoseAt.isAfter(now))
        .toList();
    if (expired.isEmpty) {
      if (mounted) {
        setState(() {});
        _syncCountdownTicker();
      }
      return;
    }

    _expiringDoseLogs = true;
    try {
      final ids = expired.map((log) => log.id).whereType<int>().toList();
      if (ids.isNotEmpty) {
        await widget.isar.writeTxn(
          () => widget.isar.doseRecords.deleteAll(ids),
        );
      }
      if (!mounted) return;
      setState(() {
        _doseLogs.removeWhere(expired.contains);
      });
      _syncCountdownTicker();
    } finally {
      _expiringDoseLogs = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return DefaultTabController(
      length: 3,
      child: Builder(
        builder: (context) {
          final tabs = DefaultTabController.of(context);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                tooltip: 'Settings',
                icon: const Icon(Icons.settings, size: 20),
                onPressed: _openSettings,
              ),
              title: const _MedclockLogo(),
              actions: [
                if (tabs.index == 1)
                  IconButton(
                    tooltip: 'Search medications',
                    icon: const Icon(Icons.search, size: 21),
                    onPressed: () => showSearch<void>(
                      context: context,
                      delegate: MedicationSearchDelegate(_medications),
                    ),
                  )
                else
                  IconButton(
                    tooltip: 'More options',
                    icon: const Icon(Icons.volunteer_activism, size: 20),
                    onPressed: _openSettings,
                  ),
              ],
              bottom: TabBar(
                onTap: (_) => setState(() {}),
                indicatorColor: Colors.white,
                indicatorWeight: 3,
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.7,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 12,
                  letterSpacing: 0.7,
                ),
                tabs: const [
                  Tab(text: 'TODAY'),
                  Tab(text: 'MEDICATIONS'),
                  Tab(text: 'TIMERS'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                TodayPage(
                  medications: _medications,
                  takenToday: _takenToday,
                  twentyFourHour: _settings.twentyFourHour,
                  showAnalogClock: _settings.showAnalogClock,
                  onReminder: _openReminder,
                ),
                MedicationListPage(
                  medications: _medications,
                  twentyFourHour: _settings.twentyFourHour,
                  onEdit: (medication) =>
                      _editMedication(medication: medication),
                  onChanged: _persistMedicationChanges,
                ),
                MedicineTimersPage(doseLogs: _doseLogs, onLogDose: _logDose),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              tooltip: tabs.index == 2
                  ? 'Start medicine timer'
                  : 'Add medication',
              mini: true,
              onPressed: tabs.index == 2
                  ? _startDoseTimer
                  : () => _editMedication(),
              child: Icon(tabs.index == 2 ? Icons.timer_outlined : Icons.add),
            ),
          );
        },
      ),
    );
  }
}

class MedicineTimersPage extends StatelessWidget {
  const MedicineTimersPage({
    required this.doseLogs,
    required this.onLogDose,
    super.key,
  });

  final List<DoseLog> doseLogs;
  final Future<void> Function(DoseLog) onLogDose;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final nextDose = _nextDoseSummary(doseLogs, now);
    final sorted = doseLogs.toList()
      ..sort((a, b) => a.nextDoseAt.compareTo(b.nextDoseAt));

    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 100),
      children: [
        const Text(
          'Medicine timers',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 21,
            color: _ink,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Track when you can take each medicine again.',
          style: TextStyle(fontSize: 13, color: _muted),
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _lightGreen,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Next timer ends in',
                style: TextStyle(
                  fontSize: 12,
                  color: _darkGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                nextDose.label,
                style: const TextStyle(
                  fontSize: 26,
                  color: _ink,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.6,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        if (sorted.isEmpty)
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Column(
              children: [
                Icon(Icons.timer_outlined, size: 34, color: _muted),
                SizedBox(height: 8),
                Text(
                  'No active medicine timers',
                  style: TextStyle(color: _muted),
                ),
              ],
            ),
          )
        else
          for (var index = 0; index < sorted.length; index++) ...[
            if (index > 0) const SizedBox(height: 10),
            _DoseTimerCard(log: sorted[index], now: now),
          ],
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: () => _showDoseLogDialog(context, onLogDose),
          icon: const Icon(Icons.add_circle_outline, size: 18),
          label: const Text('I took medicine'),
          style: ElevatedButton.styleFrom(
            backgroundColor: _darkGreen,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'This timer is separate from scheduled reminders. Follow your '
          'prescription or your healthcare professional’s instructions.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 11, color: _muted),
        ),
      ],
    );
  }
}

class TodayPage extends StatelessWidget {
  const TodayPage({
    required this.medications,
    required this.takenToday,
    required this.twentyFourHour,
    required this.showAnalogClock,
    required this.onReminder,
    super.key,
  });

  final List<Medication> medications;
  final Set<Medication> takenToday;
  final bool twentyFourHour;
  final bool showAnalogClock;
  final ValueChanged<Medication> onReminder;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final date = '${_weekday(now.weekday)}, ${_month(now.month)} ${now.day}';
    final sorted = medications.where((med) => med.enabled).toList()
      ..sort((a, b) => _minutes(a.time).compareTo(_minutes(b.time)));

    final takenCount = takenToday.intersection(sorted.toSet()).length;
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 100),
      children: [
        Text(date, style: const TextStyle(fontSize: 13, color: _muted)),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _lightGreen,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              if (showAnalogClock) ...[
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: CustomPaint(painter: _ClockPainter(now: now)),
                ),
                const SizedBox(height: 8),
              ],
              Text(
                formatTime(
                  TimeOfDay.fromDateTime(now),
                  twentyFourHour: twentyFourHour,
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 33,
                  color: _ink,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1.0,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '$takenCount of ${sorted.length} taken',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11,
                  color: _darkGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Expanded(
              child: Text(
                "Today's schedule",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18,
                  color: _ink,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3,
                ),
              ),
            ),
            Text(
              '${sorted.length} ${sorted.length == 1 ? 'reminder' : 'reminders'}',
              style: const TextStyle(fontSize: 12, color: _muted),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (sorted.isEmpty)
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Text(
              'No medications scheduled',
              style: TextStyle(color: _muted),
            ),
          )
        else
          for (var index = 0; index < sorted.length; index++) ...[
            if (index > 0) const SizedBox(height: 10),
            _ScheduleCard(
              medication: sorted[index],
              time: formatTime(
                sorted[index].time,
                twentyFourHour: twentyFourHour,
              ),
              taken: takenToday.contains(sorted[index]),
              onTap: () => onReminder(sorted[index]),
            ),
          ],
      ],
    );
  }
}

Future<void> _showDoseLogDialog(
  BuildContext context,
  Future<void> Function(DoseLog) onLogDose,
) async {
  final controller = TextEditingController();
  var intervalHours = 6;
  final result = await showDialog<DoseLog>(
    context: context,
    builder: (dialogContext) => StatefulBuilder(
      builder: (innerContext, setDialogState) => AlertDialog(
        title: const Text('I took medicine'),
        content: SizedBox(
          width: 320,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Medicine name',
                  labelText: 'Medicine name',
                ),
              ),
              const SizedBox(height: 14),
              DropdownButtonFormField<int>(
                initialValue: intervalHours,
                decoration: const InputDecoration(labelText: 'Remind me after'),
                items: const [
                  DropdownMenuItem(value: 4, child: Text('4 hours')),
                  DropdownMenuItem(value: 6, child: Text('6 hours')),
                  DropdownMenuItem(value: 8, child: Text('8 hours')),
                  DropdownMenuItem(value: 12, child: Text('12 hours')),
                  DropdownMenuItem(value: 24, child: Text('24 hours')),
                ],
                onChanged: (value) => setDialogState(() {
                  intervalHours = value ?? 6;
                }),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () {
              final name = controller.text.trim();
              if (name.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Enter a medicine name')),
                );
                return;
              }
              Navigator.of(dialogContext).pop(
                DoseLog(
                  name: name,
                  takenAt: DateTime.now(),
                  repeatHours: intervalHours,
                ),
              );
            },
            child: const Text('START TIMER'),
          ),
        ],
      ),
    ),
  );
  controller.dispose();
  if (result != null) await onLogDose(result);
}

class _DoseSummary {
  const _DoseSummary({required this.label, required this.remaining});

  final String label;
  final Duration remaining;
}

_DoseSummary _nextDoseSummary(List<DoseLog> doseLogs, DateTime now) {
  if (doseLogs.isEmpty) {
    return const _DoseSummary(
      label: 'No timer running',
      remaining: Duration.zero,
    );
  }

  final upcoming = doseLogs
      .map((log) => log.nextDoseAt.difference(now))
      .where((remaining) => !remaining.isNegative)
      .toList();

  if (upcoming.isEmpty) {
    final next = doseLogs.reduce(
      (a, b) => a.nextDoseAt.isBefore(b.nextDoseAt) ? a : b,
    );
    final remaining = next.nextDoseAt.difference(now);
    return _DoseSummary(label: 'Ready now', remaining: remaining);
  }

  final next = upcoming.reduce((a, b) => a < b ? a : b);
  return _DoseSummary(label: _formatCountdown(next), remaining: next);
}

String _formatCountdown(Duration remaining) {
  if (remaining.isNegative || remaining == Duration.zero) return 'Ready now';

  final totalMinutes = (remaining.inSeconds + 59) ~/ 60;
  final hours = totalMinutes ~/ 60;
  final minutes = totalMinutes % 60;
  if (hours > 0) {
    return '${hours}h ${minutes}m';
  }
  return '${minutes}m';
}

class _DoseTimerCard extends StatelessWidget {
  const _DoseTimerCard({required this.log, required this.now});

  final DoseLog log;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final remaining = log.nextDoseAt.difference(now);
    final availableAt = formatTime(TimeOfDay.fromDateTime(log.nextDoseAt));
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.timer_outlined, color: _darkGreen),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  log.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: _ink,
                  ),
                ),
                Text(
                  'Available again at $availableAt',
                  style: const TextStyle(fontSize: 11, color: _muted),
                ),
              ],
            ),
          ),
          Text(
            _formatCountdown(remaining),
            style: const TextStyle(
              color: _darkGreen,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScheduleCard extends StatelessWidget {
  const _ScheduleCard({
    required this.medication,
    required this.time,
    required this.taken,
    required this.onTap,
  });

  final Medication medication;
  final String time;
  final bool taken;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.white,
    borderRadius: BorderRadius.circular(18),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        child: Row(
          children: [
            SizedBox(
              width: 67,
              child: Text(
                time,
                style: const TextStyle(
                  fontSize: 12,
                  color: _darkGreen,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: taken ? _lightGreen : const Color(0xFFF2F5F1),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(
                taken ? Icons.check_rounded : Icons.medication_outlined,
                color: _darkGreen,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    medication.name,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      color: _ink,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${medication.schedule} · ${medication.repeat}',
                    style: const TextStyle(fontSize: 11, color: _muted),
                  ),
                ],
              ),
            ),
            if (taken)
              const Icon(Icons.check_circle, color: _green, size: 21)
            else
              IconButton(
                tooltip: 'Open reminder for ${medication.name}',
                visualDensity: VisualDensity.compact,
                onPressed: onTap,
                icon: const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFFA8B2AA),
                ),
              ),
          ],
        ),
      ),
    ),
  );
}

class _ClockPainter extends CustomPainter {
  const _ClockPainter({required this.now});

  final DateTime now;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.shortestSide / 2 - 5;
    final outline = Paint()
      ..color = const Color(0xFFBDBDBD)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    canvas.drawCircle(center, radius, outline);

    final tick = Paint()
      ..color = const Color(0xFF757575)
      ..strokeWidth = 0.7;
    for (var i = 0; i < 60; i++) {
      final angle = i * 3.141592653589793 / 30;
      final length = i % 5 == 0 ? 5.0 : 2.0;
      final start = Offset(
        center.dx + (radius - length) * math.sin(angle),
        center.dy - (radius - length) * math.cos(angle),
      );
      final end = Offset(
        center.dx + radius * math.sin(angle),
        center.dy - radius * math.cos(angle),
      );
      canvas.drawLine(start, end, tick);
    }

    final hour = now.hour % 12 + now.minute / 60;
    final minute = now.minute + now.second / 60;
    final hourAngle = hour * 3.141592653589793 / 6;
    final minuteAngle = minute * 3.141592653589793 / 30;
    final hand = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.6;
    hand.color = const Color(0xFF424242);
    canvas.drawLine(
      center,
      Offset(
        center.dx + radius * 0.43 * math.sin(hourAngle),
        center.dy - radius * 0.43 * math.cos(hourAngle),
      ),
      hand,
    );
    hand.color = _darkGreen;
    hand.strokeWidth = 1.3;
    canvas.drawLine(
      center,
      Offset(
        center.dx + radius * 0.68 * math.sin(minuteAngle),
        center.dy - radius * 0.68 * math.cos(minuteAngle),
      ),
      hand,
    );
    canvas.drawCircle(center, 2.2, Paint()..color = _darkGreen);
  }

  @override
  bool shouldRepaint(covariant _ClockPainter oldDelegate) =>
      oldDelegate.now.minute != now.minute || oldDelegate.now.hour != now.hour;
}

class MedicationListPage extends StatelessWidget {
  const MedicationListPage({
    required this.medications,
    required this.twentyFourHour,
    required this.onEdit,
    required this.onChanged,
    super.key,
  });

  final List<Medication> medications;
  final bool twentyFourHour;
  final ValueChanged<Medication> onEdit;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final active = medications.where((med) => med.enabled).length;
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 24),
      children: [
        const Text(
          'My medications',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 21,
            color: _ink,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '$active active · ${medications.length - active} paused',
          style: const TextStyle(fontSize: 13, color: _muted),
        ),
        const SizedBox(height: 16),
        if (medications.isEmpty)
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Text(
              'Your medication list is empty. Add one to get started.',
              style: TextStyle(color: _muted),
            ),
          ),
        for (var index = 0; index < medications.length; index++) ...[
          if (index > 0) const SizedBox(height: 10),
          _MedicationCard(
            medication: medications[index],
            twentyFourHour: twentyFourHour,
            onChanged: onChanged,
            onTap: () => onEdit(medications[index]),
          ),
        ],
        const SizedBox(height: 16),
        Row(
          children: [
            const Icon(Icons.info_outline, size: 17, color: _muted),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Tap a medication to edit its reminder. Switch it off to pause alerts.',
                style: TextStyle(fontSize: 12, color: Colors.grey[700]),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MedicationCard extends StatelessWidget {
  const _MedicationCard({
    required this.medication,
    required this.twentyFourHour,
    required this.onChanged,
    required this.onTap,
  });

  final Medication medication;
  final bool twentyFourHour;
  final VoidCallback onChanged;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.white,
    borderRadius: BorderRadius.circular(18),
    child: InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 12, 8, 12),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: medication.enabled ? _lightGreen : _canvas,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                Icons.medication_outlined,
                color: medication.enabled ? _darkGreen : _muted,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    medication.name,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      color: _ink,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    medication.schedule,
                    style: const TextStyle(fontSize: 12, color: _muted),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${formatTime(medication.time, twentyFourHour: twentyFourHour)} · ${medication.repeat}',
                    style: const TextStyle(
                      fontSize: 11,
                      color: _darkGreen,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: medication.enabled,
              activeThumbColor: _green,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: (value) {
                medication.enabled = value;
                onChanged();
              },
            ),
          ],
        ),
      ),
    ),
  );
}

class MedicationSearchDelegate extends SearchDelegate<void> {
  MedicationSearchDelegate(this.medications);

  final List<Medication> medications;

  @override
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(
      tooltip: 'Clear search',
      onPressed: () => query = '',
      icon: const Icon(Icons.clear),
    ),
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    tooltip: 'Back',
    onPressed: () => close(context, null),
    icon: const Icon(Icons.arrow_back),
  );

  @override
  Widget buildResults(BuildContext context) => _results();

  @override
  Widget buildSuggestions(BuildContext context) => _results();

  Widget _results() {
    final matches = medications
        .where(
          (medication) =>
              medication.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
    return ListView(
      children: [
        for (final medication in matches)
          ListTile(
            leading: const Icon(Icons.medication_outlined, color: _darkGreen),
            title: Text(medication.name),
            subtitle: Text(medication.schedule),
          ),
      ],
    );
  }
}

class MedicationFormPage extends StatefulWidget {
  const MedicationFormPage({this.medication, this.onDelete, super.key});

  final Medication? medication;
  final Future<void> Function()? onDelete;

  @override
  State<MedicationFormPage> createState() => _MedicationFormPageState();
}

class _MedicationFormPageState extends State<MedicationFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _strengthController;
  late final TextEditingController _amountController;
  late final TextEditingController _notesController;
  late TimeOfDay _time;
  late String _repeat;
  late bool _enabled;

  bool get _editing => widget.medication != null;

  @override
  void initState() {
    super.initState();
    final medication = widget.medication;
    _nameController = TextEditingController(text: medication?.name ?? '');
    _strengthController = TextEditingController(
      text: medication?.strength ?? '',
    );
    _amountController = TextEditingController(text: medication?.amount ?? '');
    _notesController = TextEditingController(text: medication?.notes ?? '');
    _time = medication?.time ?? const TimeOfDay(hour: 8, minute: 0);
    _repeat = medication?.repeat ?? 'Every day';
    _enabled = medication?.enabled ?? true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _strengthController.dispose();
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _chooseTime() async {
    final time = await showTimePicker(context: context, initialTime: _time);
    if (time != null) setState(() => _time = time);
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context).pop(
      Medication(
        name: _nameController.text.trim(),
        strength: _strengthController.text.trim(),
        amount: _amountController.text.trim(),
        time: _time,
        repeat: _repeat,
        notes: _notesController.text.trim(),
        enabled: _enabled,
      ),
    );
  }

  Future<void> _confirmDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete medication?'),
        content: Text('Remove ${widget.medication!.name} from your list?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('DELETE'),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      await widget.onDelete?.call();
      if (mounted) Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Back',
          icon: const Icon(Icons.arrow_back, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(_editing ? 'Edit medication' : 'Add medication'),
        actions: [
          if (_editing)
            IconButton(
              tooltip: 'Delete medication',
              icon: const Icon(Icons.delete_outline, size: 20),
              onPressed: _confirmDelete,
            )
          else
            IconButton(
              tooltip: 'Save medication',
              icon: const Icon(Icons.check, size: 20),
              onPressed: _save,
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
          children: [
            _FormLabel('Medication name'),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'Enter medication name',
                isDense: true,
              ),
              validator: (value) =>
                  value == null || value.trim().isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _formInput(
                    label: 'Strength (optional)',
                    controller: _strengthController,
                    hint: 'e.g. 500 mg',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _formInput(
                    label: 'Amount',
                    controller: _amountController,
                    hint: '1 tablet',
                  ),
                ),
              ],
            ),
            const Divider(height: 25),
            _optionTile(
              icon: Icons.access_time,
              title: 'Reminder time',
              value: formatTime(_time),
              onTap: _chooseTime,
            ),
            _optionTile(
              icon: Icons.repeat,
              title: 'Repeat',
              value: _repeat,
              onTap: () async {
                final repeat = await showDialog<String>(
                  context: context,
                  builder: (context) => SimpleDialog(
                    title: const Text('Repeat'),
                    children: [
                      for (final choice in [
                        'Every day',
                        'Weekdays',
                        'Weekends',
                        'Mon, Wed, Fri',
                        'Once',
                      ])
                        SimpleDialogOption(
                          onPressed: () => Navigator.pop(context, choice),
                          child: Text(choice),
                        ),
                    ],
                  ),
                );
                if (repeat != null) setState(() => _repeat = repeat);
              },
            ),
            _optionTile(
              icon: Icons.notifications_none,
              title: 'Reminder enabled',
              trailing: Switch(
                value: _enabled,
                activeThumbColor: _green,
                onChanged: (value) => setState(() => _enabled = value),
              ),
            ),
            const SizedBox(height: 4),
            _FormLabel('Notes (optional)'),
            TextField(
              controller: _notesController,
              decoration: const InputDecoration(
                hintText: 'Add a personal note',
                isDense: true,
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 12),
            Text(
              'For your own schedule. Follow the instructions provided by your healthcare professional.',
              style: TextStyle(fontSize: 10, color: Colors.grey[600]),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Color(0xFFE7ECE7))),
          ),
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: _green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                _editing ? 'SAVE CHANGES' : 'SAVE REMINDER',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _formInput({
    required String label,
    required TextEditingController controller,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FormLabel(label),
        TextField(
          controller: controller,
          decoration: InputDecoration(hintText: hint, isDense: true),
        ),
      ],
    );
  }

  Widget _optionTile({
    required IconData icon,
    required String title,
    String? value,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, size: 19, color: _darkGreen),
      title: Text(
        title,
        style: const TextStyle(fontFamily: 'Inter', fontSize: 12),
      ),
      subtitle: value == null
          ? null
          : Text(value, style: const TextStyle(fontSize: 10, color: _muted)),
      trailing:
          trailing ??
          const Icon(Icons.keyboard_arrow_down, size: 20, color: _muted),
      onTap: onTap,
    );
  }
}

class _FormLabel extends StatelessWidget {
  const _FormLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) =>
      Text(label, style: const TextStyle(fontSize: 10, color: _muted));
}

class ReminderPage extends StatelessWidget {
  const ReminderPage({
    required this.medication,
    required this.settings,
    super.key,
  });

  final Medication medication;
  final MedicationSettings settings;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Back',
          icon: const Icon(Icons.arrow_back, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const _MedclockLogo(),
        actions: [
          IconButton(
            tooltip: 'More options',
            icon: const Icon(Icons.volunteer_activism, size: 20),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 8),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    const Text(
                      'MEDICATION REMINDER',
                      style: TextStyle(
                        fontSize: 10,
                        color: _darkGreen,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      formatTime(
                        medication.time,
                        twentyFourHour: settings.twentyFourHour,
                      ),
                      style: const TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.w600,
                        color: _ink,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${_month(DateTime.now().month)} ${DateTime.now().day}',
                      style: const TextStyle(fontSize: 12, color: _muted),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: _lightGreen,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.medication_outlined,
                        color: _darkGreen,
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      medication.name,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20,
                        color: _ink,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      medication.schedule,
                      style: const TextStyle(fontSize: 13, color: _muted),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        color: _canvas,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        medication.notes.isEmpty
                            ? 'My lunchtime reminder'
                            : medication.notes,
                        style: const TextStyle(fontSize: 12, color: _muted),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, ReminderAction.taken),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'MARK AS TAKEN',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _darkGreen,
                    side: const BorderSide(color: Color(0xFFDCE5DD)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () =>
                      Navigator.pop(context, ReminderAction.snoozed),
                  child: Text(
                    'SNOOZE ${settings.snoozeMinutes} MINUTES',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, ReminderAction.skipped),
                child: const Text(
                  'SKIP THIS DOSE',
                  style: TextStyle(fontSize: 11, color: _muted),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({required this.settings, super.key});

  final MedicationSettings settings;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late String _reminderSound;
  late int _snoozeMinutes;
  late bool _vibrate;
  late bool _twentyFourHour;
  late bool _showClock;

  @override
  void initState() {
    super.initState();
    _reminderSound = widget.settings.reminderSound;
    _snoozeMinutes = widget.settings.snoozeMinutes;
    _vibrate = widget.settings.vibrate;
    _twentyFourHour = widget.settings.twentyFourHour;
    _showClock = widget.settings.showAnalogClock;
  }

  MedicationSettings get _result => MedicationSettings(
    reminderSound: _reminderSound,
    snoozeMinutes: _snoozeMinutes,
    vibrate: _vibrate,
    twentyFourHour: _twentyFourHour,
    showAnalogClock: _showClock,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Back',
          icon: const Icon(Icons.arrow_back, size: 20),
          onPressed: () => Navigator.pop(context, _result),
        ),
        title: const Text('Settings'),
        actions: [
          IconButton(
            tooltip: 'More options',
            icon: const Icon(Icons.volunteer_activism, size: 20),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 20),
        children: [
          _SettingsHeading('Reminders'),
          _SettingsItem(
            icon: Icons.notifications_none,
            title: 'Reminder sound',
            subtitle: _reminderSound,
            onTap: () => _chooseSound(context),
          ),
          _SettingsItem(
            icon: Icons.vibration,
            title: 'Vibrate',
            subtitle: 'Vibrate when a reminder is due',
            trailing: Switch(
              value: _vibrate,
              activeThumbColor: _green,
              onChanged: (value) => setState(() => _vibrate = value),
            ),
          ),
          _SettingsItem(
            icon: Icons.alarm,
            title: 'Default snooze',
            subtitle: '$_snoozeMinutes minutes',
            onTap: () => _chooseSnooze(context),
          ),
          _SettingsHeading('Clock & display'),
          _SettingsItem(
            icon: Icons.access_time,
            title: '24-hour time',
            subtitle: 'Use 13:00 instead of 1:00 PM',
            trailing: Switch(
              value: _twentyFourHour,
              activeThumbColor: _green,
              onChanged: (value) => setState(() => _twentyFourHour = value),
            ),
          ),
          _SettingsItem(
            icon: Icons.watch_later_outlined,
            title: 'Show analog clock',
            trailing: Switch(
              value: _showClock,
              activeThumbColor: _green,
              onChanged: (value) => setState(() => _showClock = value),
            ),
          ),
          _SettingsHeading('About'),
          _SettingsItem(
            icon: Icons.info_outline,
            title: 'Medclock',
            subtitle:
                'Alpha · In development\n\n'
                'Keep track of your medication schedule. '
                'Fully open source and free forever!\n\n',
          ),
        ],
      ),
    );
  }

  Future<void> _chooseSound(BuildContext context) async {
    final sound = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Reminder sound'),
        children: [
          for (final sound in ['Gentle bell', 'Soft chime', 'None'])
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, sound),
              child: Text(sound),
            ),
        ],
      ),
    );
    if (sound != null) setState(() => _reminderSound = sound);
  }

  Future<void> _chooseSnooze(BuildContext context) async {
    final snooze = await showDialog<int>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Default snooze'),
        children: [
          for (final duration in [5, 10, 15])
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, duration),
              child: Text('$duration minutes'),
            ),
        ],
      ),
    );
    if (snooze != null) setState(() => _snoozeMinutes = snooze);
  }
}

class _SettingsHeading extends StatelessWidget {
  const _SettingsHeading(this.title);

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 14, 16, 5),
    child: Text(
      title,
      style: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 11,
        color: _darkGreen,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

class _SettingsItem extends StatelessWidget {
  const _SettingsItem({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => ListTile(
    dense: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
    leading: Icon(icon, size: 18, color: _muted),
    title: Text(
      title,
      style: const TextStyle(fontFamily: 'Inter', fontSize: 12),
    ),
    subtitle: subtitle == null
        ? null
        : Text(subtitle!, style: const TextStyle(fontSize: 10, color: _muted)),
    trailing: trailing,
    onTap: onTap,
  );
}

int _minutes(TimeOfDay time) => time.hour * 60 + time.minute;

String _weekday(int day) => const [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
][day - 1];

String _month(int month) => const [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
][month - 1];
