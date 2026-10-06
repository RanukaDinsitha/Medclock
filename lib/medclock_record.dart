import 'package:isar/isar.dart';

part 'medclock_record.g.dart';

@collection
class MedicationRecord {
  Id id = Isar.autoIncrement;

  late String name;
  late String strength;
  late String amount;
  late int minuteOfDay;
  late String repeat;
  late String notes;
  late bool enabled;
}

@collection
class DoseRecord {
  Id id = Isar.autoIncrement;

  late String name;
  late DateTime takenAt;
  late int repeatHours;

  DateTime get nextDoseAt => takenAt.add(Duration(hours: repeatHours));
}

@collection
class AppStateRecord {
  Id id = 0;

  late bool starterMedicationsLoaded;
  late String reminderSound;
  late int snoozeMinutes;
  late bool vibrate;
  late bool twentyFourHour;
  late bool showAnalogClock;
}
