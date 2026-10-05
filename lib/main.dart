import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() {
  runApp(const MedclockApp());
}

const _green = Color(0xFF3C9A62);
const _darkGreen = Color(0xFF246B45);
const _lightGreen = Color(0xFFE7F3EA);
const _muted = Color(0xFF6D7971);
const _canvas = Color(0xFFF4F7F3);
const _ink = Color(0xFF202A23);

class MedclockApp extends StatelessWidget {
  const MedclockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'medclock',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
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
      home: const MedclockHome(),
    );
  }
}

class Medication {
  Medication({
    required this.name,
    required this.strength,
    required this.amount,
    required this.time,
    this.repeat = 'Every day',
    this.notes = '',
    this.enabled = true,
  });

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

class MedclockHome extends StatefulWidget {
  const MedclockHome({super.key});

  @override
  State<MedclockHome> createState() => _MedclockHomeState();
}

class _MedclockHomeState extends State<MedclockHome> {
  MedicationSettings _settings = const MedicationSettings();
  final Set<Medication> _takenToday = {};
  final List<Medication> _medications = [
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

  Future<void> _editMedication({Medication? medication}) async {
    final result = await Navigator.of(context).push<Medication>(
      MaterialPageRoute(
        builder: (_) => MedicationFormPage(
          medication: medication,
          onDelete: medication == null
              ? null
              : () {
                  setState(() => _medications.remove(medication));
                  Navigator.of(context).pop();
                },
        ),
      ),
    );
    if (result == null || !mounted) return;
    setState(() {
      if (medication == null) {
        _medications.add(result);
      } else {
        medication
          ..name = result.name
          ..strength = result.strength
          ..amount = result.amount
          ..time = result.time
          ..repeat = result.repeat
          ..notes = result.notes
          ..enabled = result.enabled;
      }
    });
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
    if (settings != null && mounted) setState(() => _settings = settings);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Builder(
        builder: (context) {
          final tabs = DefaultTabController.of(context);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                tooltip: 'Settings',
                icon: const Icon(Icons.menu, size: 20),
                onPressed: _openSettings,
              ),
              title: const Text('medclock'),
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
                    icon: const Icon(Icons.more_vert, size: 20),
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
                  onChanged: () => setState(() {}),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              tooltip: 'Add medication',
              mini: true,
              onPressed: () => _editMedication(),
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
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
        Text(
          'A little care, every day.',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: _ink,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.6,
          ),
        ),
        const SizedBox(height: 4),
        Text(date, style: const TextStyle(fontSize: 13, color: _muted)),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: _lightGreen,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
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
                const SizedBox(width: 18),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'RIGHT NOW',
                      style: TextStyle(
                        fontSize: 10,
                        color: _darkGreen,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formatTime(
                        TimeOfDay.fromDateTime(now),
                        twentyFourHour: twentyFourHour,
                      ),
                      style: const TextStyle(
                        fontSize: 27,
                        color: _ink,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.8,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '$takenCount of ${sorted.length} taken',
                        style: const TextStyle(
                          fontSize: 11,
                          color: _darkGreen,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
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
  final VoidCallback? onDelete;

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
    if (confirmed == true && mounted) widget.onDelete?.call();
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
      title: Text(title, style: const TextStyle(fontSize: 12)),
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
        title: const Text('medclock'),
        actions: [
          IconButton(
            tooltip: 'More options',
            icon: const Icon(Icons.more_vert, size: 20),
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
            icon: const Icon(Icons.more_vert, size: 20),
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
            title: 'medclock',
            subtitle:
                'Version 1.0 · UI template\n\n'
                'Keep track of your medication schedule. '
                'This template does not send reminders or provide medical advice.',
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
    title: Text(title, style: const TextStyle(fontSize: 12)),
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
