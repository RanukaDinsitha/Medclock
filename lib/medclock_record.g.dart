// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medclock_record.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMedicationRecordCollection on Isar {
  IsarCollection<MedicationRecord> get medicationRecords => this.collection();
}

const MedicationRecordSchema = CollectionSchema(
  name: r'MedicationRecord',
  id: 2640923040866432282,
  properties: {
    r'amount': PropertySchema(
      id: 0,
      name: r'amount',
      type: IsarType.string,
    ),
    r'enabled': PropertySchema(
      id: 1,
      name: r'enabled',
      type: IsarType.bool,
    ),
    r'minuteOfDay': PropertySchema(
      id: 2,
      name: r'minuteOfDay',
      type: IsarType.long,
    ),
    r'name': PropertySchema(
      id: 3,
      name: r'name',
      type: IsarType.string,
    ),
    r'notes': PropertySchema(
      id: 4,
      name: r'notes',
      type: IsarType.string,
    ),
    r'repeat': PropertySchema(
      id: 5,
      name: r'repeat',
      type: IsarType.string,
    ),
    r'strength': PropertySchema(
      id: 6,
      name: r'strength',
      type: IsarType.string,
    )
  },
  estimateSize: _medicationRecordEstimateSize,
  serialize: _medicationRecordSerialize,
  deserialize: _medicationRecordDeserialize,
  deserializeProp: _medicationRecordDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _medicationRecordGetId,
  getLinks: _medicationRecordGetLinks,
  attach: _medicationRecordAttach,
  version: '3.1.0+1',
);

int _medicationRecordEstimateSize(
  MedicationRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.amount.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.notes.length * 3;
  bytesCount += 3 + object.repeat.length * 3;
  bytesCount += 3 + object.strength.length * 3;
  return bytesCount;
}

void _medicationRecordSerialize(
  MedicationRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.amount);
  writer.writeBool(offsets[1], object.enabled);
  writer.writeLong(offsets[2], object.minuteOfDay);
  writer.writeString(offsets[3], object.name);
  writer.writeString(offsets[4], object.notes);
  writer.writeString(offsets[5], object.repeat);
  writer.writeString(offsets[6], object.strength);
}

MedicationRecord _medicationRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MedicationRecord();
  object.amount = reader.readString(offsets[0]);
  object.enabled = reader.readBool(offsets[1]);
  object.id = id;
  object.minuteOfDay = reader.readLong(offsets[2]);
  object.name = reader.readString(offsets[3]);
  object.notes = reader.readString(offsets[4]);
  object.repeat = reader.readString(offsets[5]);
  object.strength = reader.readString(offsets[6]);
  return object;
}

P _medicationRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _medicationRecordGetId(MedicationRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _medicationRecordGetLinks(MedicationRecord object) {
  return [];
}

void _medicationRecordAttach(
    IsarCollection<dynamic> col, Id id, MedicationRecord object) {
  object.id = id;
}

extension MedicationRecordQueryWhereSort
    on QueryBuilder<MedicationRecord, MedicationRecord, QWhere> {
  QueryBuilder<MedicationRecord, MedicationRecord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MedicationRecordQueryWhere
    on QueryBuilder<MedicationRecord, MedicationRecord, QWhereClause> {
  QueryBuilder<MedicationRecord, MedicationRecord, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MedicationRecordQueryFilter
    on QueryBuilder<MedicationRecord, MedicationRecord, QFilterCondition> {
  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      amountEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      amountGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      amountLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      amountBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      amountStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'amount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      amountEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'amount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      amountContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'amount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      amountMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'amount',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      amountIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amount',
        value: '',
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      amountIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'amount',
        value: '',
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      enabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enabled',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      minuteOfDayEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'minuteOfDay',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      minuteOfDayGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'minuteOfDay',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      minuteOfDayLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'minuteOfDay',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      minuteOfDayBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'minuteOfDay',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      notesEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      notesGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      notesLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      notesBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      notesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      notesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      notesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      notesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      repeatEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'repeat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      repeatGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'repeat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      repeatLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'repeat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      repeatBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'repeat',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      repeatStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'repeat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      repeatEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'repeat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      repeatContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'repeat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      repeatMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'repeat',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      repeatIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'repeat',
        value: '',
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      repeatIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'repeat',
        value: '',
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      strengthEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'strength',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      strengthGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'strength',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      strengthLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'strength',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      strengthBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'strength',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      strengthStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'strength',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      strengthEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'strength',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      strengthContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'strength',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      strengthMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'strength',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      strengthIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'strength',
        value: '',
      ));
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterFilterCondition>
      strengthIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'strength',
        value: '',
      ));
    });
  }
}

extension MedicationRecordQueryObject
    on QueryBuilder<MedicationRecord, MedicationRecord, QFilterCondition> {}

extension MedicationRecordQueryLinks
    on QueryBuilder<MedicationRecord, MedicationRecord, QFilterCondition> {}

extension MedicationRecordQuerySortBy
    on QueryBuilder<MedicationRecord, MedicationRecord, QSortBy> {
  QueryBuilder<MedicationRecord, MedicationRecord, QAfterSortBy>
      sortByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterSortBy>
      sortByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterSortBy>
      sortByEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enabled', Sort.asc);
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterSortBy>
      sortByEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enabled', Sort.desc);
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterSortBy>
      sortByMinuteOfDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minuteOfDay', Sort.asc);
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterSortBy>
      sortByMinuteOfDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minuteOfDay', Sort.desc);
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterSortBy>
      sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterSortBy>
      sortByRepeat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeat', Sort.asc);
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterSortBy>
      sortByRepeatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeat', Sort.desc);
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterSortBy>
      sortByStrength() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strength', Sort.asc);
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterSortBy>
      sortByStrengthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strength', Sort.desc);
    });
  }
}

extension MedicationRecordQuerySortThenBy
    on QueryBuilder<MedicationRecord, MedicationRecord, QSortThenBy> {
  QueryBuilder<MedicationRecord, MedicationRecord, QAfterSortBy>
      thenByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterSortBy>
      thenByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterSortBy>
      thenByEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enabled', Sort.asc);
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterSortBy>
      thenByEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enabled', Sort.desc);
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterSortBy>
      thenByMinuteOfDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minuteOfDay', Sort.asc);
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterSortBy>
      thenByMinuteOfDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minuteOfDay', Sort.desc);
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterSortBy>
      thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterSortBy>
      thenByRepeat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeat', Sort.asc);
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterSortBy>
      thenByRepeatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeat', Sort.desc);
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterSortBy>
      thenByStrength() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strength', Sort.asc);
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QAfterSortBy>
      thenByStrengthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strength', Sort.desc);
    });
  }
}

extension MedicationRecordQueryWhereDistinct
    on QueryBuilder<MedicationRecord, MedicationRecord, QDistinct> {
  QueryBuilder<MedicationRecord, MedicationRecord, QDistinct> distinctByAmount(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amount', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QDistinct>
      distinctByEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'enabled');
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QDistinct>
      distinctByMinuteOfDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'minuteOfDay');
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QDistinct> distinctByNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QDistinct> distinctByRepeat(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'repeat', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicationRecord, MedicationRecord, QDistinct>
      distinctByStrength({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'strength', caseSensitive: caseSensitive);
    });
  }
}

extension MedicationRecordQueryProperty
    on QueryBuilder<MedicationRecord, MedicationRecord, QQueryProperty> {
  QueryBuilder<MedicationRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MedicationRecord, String, QQueryOperations> amountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amount');
    });
  }

  QueryBuilder<MedicationRecord, bool, QQueryOperations> enabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'enabled');
    });
  }

  QueryBuilder<MedicationRecord, int, QQueryOperations> minuteOfDayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'minuteOfDay');
    });
  }

  QueryBuilder<MedicationRecord, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<MedicationRecord, String, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<MedicationRecord, String, QQueryOperations> repeatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'repeat');
    });
  }

  QueryBuilder<MedicationRecord, String, QQueryOperations> strengthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'strength');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDoseRecordCollection on Isar {
  IsarCollection<DoseRecord> get doseRecords => this.collection();
}

const DoseRecordSchema = CollectionSchema(
  name: r'DoseRecord',
  id: 9029586081048020273,
  properties: {
    r'name': PropertySchema(
      id: 0,
      name: r'name',
      type: IsarType.string,
    ),
    r'nextDoseAt': PropertySchema(
      id: 1,
      name: r'nextDoseAt',
      type: IsarType.dateTime,
    ),
    r'repeatHours': PropertySchema(
      id: 2,
      name: r'repeatHours',
      type: IsarType.long,
    ),
    r'takenAt': PropertySchema(
      id: 3,
      name: r'takenAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _doseRecordEstimateSize,
  serialize: _doseRecordSerialize,
  deserialize: _doseRecordDeserialize,
  deserializeProp: _doseRecordDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _doseRecordGetId,
  getLinks: _doseRecordGetLinks,
  attach: _doseRecordAttach,
  version: '3.1.0+1',
);

int _doseRecordEstimateSize(
  DoseRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _doseRecordSerialize(
  DoseRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.name);
  writer.writeDateTime(offsets[1], object.nextDoseAt);
  writer.writeLong(offsets[2], object.repeatHours);
  writer.writeDateTime(offsets[3], object.takenAt);
}

DoseRecord _doseRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DoseRecord();
  object.id = id;
  object.name = reader.readString(offsets[0]);
  object.repeatHours = reader.readLong(offsets[2]);
  object.takenAt = reader.readDateTime(offsets[3]);
  return object;
}

P _doseRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _doseRecordGetId(DoseRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _doseRecordGetLinks(DoseRecord object) {
  return [];
}

void _doseRecordAttach(IsarCollection<dynamic> col, Id id, DoseRecord object) {
  object.id = id;
}

extension DoseRecordQueryWhereSort
    on QueryBuilder<DoseRecord, DoseRecord, QWhere> {
  QueryBuilder<DoseRecord, DoseRecord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DoseRecordQueryWhere
    on QueryBuilder<DoseRecord, DoseRecord, QWhereClause> {
  QueryBuilder<DoseRecord, DoseRecord, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DoseRecordQueryFilter
    on QueryBuilder<DoseRecord, DoseRecord, QFilterCondition> {
  QueryBuilder<DoseRecord, DoseRecord, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterFilterCondition> nextDoseAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nextDoseAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterFilterCondition>
      nextDoseAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nextDoseAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterFilterCondition>
      nextDoseAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nextDoseAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterFilterCondition> nextDoseAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nextDoseAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterFilterCondition>
      repeatHoursEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'repeatHours',
        value: value,
      ));
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterFilterCondition>
      repeatHoursGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'repeatHours',
        value: value,
      ));
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterFilterCondition>
      repeatHoursLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'repeatHours',
        value: value,
      ));
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterFilterCondition>
      repeatHoursBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'repeatHours',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterFilterCondition> takenAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'takenAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterFilterCondition>
      takenAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'takenAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterFilterCondition> takenAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'takenAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterFilterCondition> takenAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'takenAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DoseRecordQueryObject
    on QueryBuilder<DoseRecord, DoseRecord, QFilterCondition> {}

extension DoseRecordQueryLinks
    on QueryBuilder<DoseRecord, DoseRecord, QFilterCondition> {}

extension DoseRecordQuerySortBy
    on QueryBuilder<DoseRecord, DoseRecord, QSortBy> {
  QueryBuilder<DoseRecord, DoseRecord, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterSortBy> sortByNextDoseAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextDoseAt', Sort.asc);
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterSortBy> sortByNextDoseAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextDoseAt', Sort.desc);
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterSortBy> sortByRepeatHours() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeatHours', Sort.asc);
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterSortBy> sortByRepeatHoursDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeatHours', Sort.desc);
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterSortBy> sortByTakenAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'takenAt', Sort.asc);
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterSortBy> sortByTakenAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'takenAt', Sort.desc);
    });
  }
}

extension DoseRecordQuerySortThenBy
    on QueryBuilder<DoseRecord, DoseRecord, QSortThenBy> {
  QueryBuilder<DoseRecord, DoseRecord, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterSortBy> thenByNextDoseAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextDoseAt', Sort.asc);
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterSortBy> thenByNextDoseAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextDoseAt', Sort.desc);
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterSortBy> thenByRepeatHours() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeatHours', Sort.asc);
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterSortBy> thenByRepeatHoursDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeatHours', Sort.desc);
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterSortBy> thenByTakenAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'takenAt', Sort.asc);
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QAfterSortBy> thenByTakenAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'takenAt', Sort.desc);
    });
  }
}

extension DoseRecordQueryWhereDistinct
    on QueryBuilder<DoseRecord, DoseRecord, QDistinct> {
  QueryBuilder<DoseRecord, DoseRecord, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QDistinct> distinctByNextDoseAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nextDoseAt');
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QDistinct> distinctByRepeatHours() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'repeatHours');
    });
  }

  QueryBuilder<DoseRecord, DoseRecord, QDistinct> distinctByTakenAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'takenAt');
    });
  }
}

extension DoseRecordQueryProperty
    on QueryBuilder<DoseRecord, DoseRecord, QQueryProperty> {
  QueryBuilder<DoseRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DoseRecord, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<DoseRecord, DateTime, QQueryOperations> nextDoseAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nextDoseAt');
    });
  }

  QueryBuilder<DoseRecord, int, QQueryOperations> repeatHoursProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'repeatHours');
    });
  }

  QueryBuilder<DoseRecord, DateTime, QQueryOperations> takenAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'takenAt');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAppStateRecordCollection on Isar {
  IsarCollection<AppStateRecord> get appStateRecords => this.collection();
}

const AppStateRecordSchema = CollectionSchema(
  name: r'AppStateRecord',
  id: 4728061756950040693,
  properties: {
    r'reminderSound': PropertySchema(
      id: 0,
      name: r'reminderSound',
      type: IsarType.string,
    ),
    r'showAnalogClock': PropertySchema(
      id: 1,
      name: r'showAnalogClock',
      type: IsarType.bool,
    ),
    r'snoozeMinutes': PropertySchema(
      id: 2,
      name: r'snoozeMinutes',
      type: IsarType.long,
    ),
    r'starterMedicationsLoaded': PropertySchema(
      id: 3,
      name: r'starterMedicationsLoaded',
      type: IsarType.bool,
    ),
    r'twentyFourHour': PropertySchema(
      id: 4,
      name: r'twentyFourHour',
      type: IsarType.bool,
    ),
    r'vibrate': PropertySchema(
      id: 5,
      name: r'vibrate',
      type: IsarType.bool,
    )
  },
  estimateSize: _appStateRecordEstimateSize,
  serialize: _appStateRecordSerialize,
  deserialize: _appStateRecordDeserialize,
  deserializeProp: _appStateRecordDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _appStateRecordGetId,
  getLinks: _appStateRecordGetLinks,
  attach: _appStateRecordAttach,
  version: '3.1.0+1',
);

int _appStateRecordEstimateSize(
  AppStateRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.reminderSound.length * 3;
  return bytesCount;
}

void _appStateRecordSerialize(
  AppStateRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.reminderSound);
  writer.writeBool(offsets[1], object.showAnalogClock);
  writer.writeLong(offsets[2], object.snoozeMinutes);
  writer.writeBool(offsets[3], object.starterMedicationsLoaded);
  writer.writeBool(offsets[4], object.twentyFourHour);
  writer.writeBool(offsets[5], object.vibrate);
}

AppStateRecord _appStateRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AppStateRecord();
  object.id = id;
  object.reminderSound = reader.readString(offsets[0]);
  object.showAnalogClock = reader.readBool(offsets[1]);
  object.snoozeMinutes = reader.readLong(offsets[2]);
  object.starterMedicationsLoaded = reader.readBool(offsets[3]);
  object.twentyFourHour = reader.readBool(offsets[4]);
  object.vibrate = reader.readBool(offsets[5]);
  return object;
}

P _appStateRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _appStateRecordGetId(AppStateRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _appStateRecordGetLinks(AppStateRecord object) {
  return [];
}

void _appStateRecordAttach(
    IsarCollection<dynamic> col, Id id, AppStateRecord object) {
  object.id = id;
}

extension AppStateRecordQueryWhereSort
    on QueryBuilder<AppStateRecord, AppStateRecord, QWhere> {
  QueryBuilder<AppStateRecord, AppStateRecord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AppStateRecordQueryWhere
    on QueryBuilder<AppStateRecord, AppStateRecord, QWhereClause> {
  QueryBuilder<AppStateRecord, AppStateRecord, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AppStateRecordQueryFilter
    on QueryBuilder<AppStateRecord, AppStateRecord, QFilterCondition> {
  QueryBuilder<AppStateRecord, AppStateRecord, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterFilterCondition>
      reminderSoundEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reminderSound',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterFilterCondition>
      reminderSoundGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reminderSound',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterFilterCondition>
      reminderSoundLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reminderSound',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterFilterCondition>
      reminderSoundBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reminderSound',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterFilterCondition>
      reminderSoundStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'reminderSound',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterFilterCondition>
      reminderSoundEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'reminderSound',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterFilterCondition>
      reminderSoundContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'reminderSound',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterFilterCondition>
      reminderSoundMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'reminderSound',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterFilterCondition>
      reminderSoundIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reminderSound',
        value: '',
      ));
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterFilterCondition>
      reminderSoundIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'reminderSound',
        value: '',
      ));
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterFilterCondition>
      showAnalogClockEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'showAnalogClock',
        value: value,
      ));
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterFilterCondition>
      snoozeMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'snoozeMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterFilterCondition>
      snoozeMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'snoozeMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterFilterCondition>
      snoozeMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'snoozeMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterFilterCondition>
      snoozeMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'snoozeMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterFilterCondition>
      starterMedicationsLoadedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'starterMedicationsLoaded',
        value: value,
      ));
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterFilterCondition>
      twentyFourHourEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'twentyFourHour',
        value: value,
      ));
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterFilterCondition>
      vibrateEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vibrate',
        value: value,
      ));
    });
  }
}

extension AppStateRecordQueryObject
    on QueryBuilder<AppStateRecord, AppStateRecord, QFilterCondition> {}

extension AppStateRecordQueryLinks
    on QueryBuilder<AppStateRecord, AppStateRecord, QFilterCondition> {}

extension AppStateRecordQuerySortBy
    on QueryBuilder<AppStateRecord, AppStateRecord, QSortBy> {
  QueryBuilder<AppStateRecord, AppStateRecord, QAfterSortBy>
      sortByReminderSound() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderSound', Sort.asc);
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterSortBy>
      sortByReminderSoundDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderSound', Sort.desc);
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterSortBy>
      sortByShowAnalogClock() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showAnalogClock', Sort.asc);
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterSortBy>
      sortByShowAnalogClockDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showAnalogClock', Sort.desc);
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterSortBy>
      sortBySnoozeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'snoozeMinutes', Sort.asc);
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterSortBy>
      sortBySnoozeMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'snoozeMinutes', Sort.desc);
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterSortBy>
      sortByStarterMedicationsLoaded() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'starterMedicationsLoaded', Sort.asc);
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterSortBy>
      sortByStarterMedicationsLoadedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'starterMedicationsLoaded', Sort.desc);
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterSortBy>
      sortByTwentyFourHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'twentyFourHour', Sort.asc);
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterSortBy>
      sortByTwentyFourHourDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'twentyFourHour', Sort.desc);
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterSortBy> sortByVibrate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vibrate', Sort.asc);
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterSortBy>
      sortByVibrateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vibrate', Sort.desc);
    });
  }
}

extension AppStateRecordQuerySortThenBy
    on QueryBuilder<AppStateRecord, AppStateRecord, QSortThenBy> {
  QueryBuilder<AppStateRecord, AppStateRecord, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterSortBy>
      thenByReminderSound() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderSound', Sort.asc);
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterSortBy>
      thenByReminderSoundDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderSound', Sort.desc);
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterSortBy>
      thenByShowAnalogClock() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showAnalogClock', Sort.asc);
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterSortBy>
      thenByShowAnalogClockDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showAnalogClock', Sort.desc);
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterSortBy>
      thenBySnoozeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'snoozeMinutes', Sort.asc);
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterSortBy>
      thenBySnoozeMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'snoozeMinutes', Sort.desc);
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterSortBy>
      thenByStarterMedicationsLoaded() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'starterMedicationsLoaded', Sort.asc);
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterSortBy>
      thenByStarterMedicationsLoadedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'starterMedicationsLoaded', Sort.desc);
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterSortBy>
      thenByTwentyFourHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'twentyFourHour', Sort.asc);
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterSortBy>
      thenByTwentyFourHourDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'twentyFourHour', Sort.desc);
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterSortBy> thenByVibrate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vibrate', Sort.asc);
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QAfterSortBy>
      thenByVibrateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vibrate', Sort.desc);
    });
  }
}

extension AppStateRecordQueryWhereDistinct
    on QueryBuilder<AppStateRecord, AppStateRecord, QDistinct> {
  QueryBuilder<AppStateRecord, AppStateRecord, QDistinct>
      distinctByReminderSound({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reminderSound',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QDistinct>
      distinctByShowAnalogClock() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'showAnalogClock');
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QDistinct>
      distinctBySnoozeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'snoozeMinutes');
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QDistinct>
      distinctByStarterMedicationsLoaded() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'starterMedicationsLoaded');
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QDistinct>
      distinctByTwentyFourHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'twentyFourHour');
    });
  }

  QueryBuilder<AppStateRecord, AppStateRecord, QDistinct> distinctByVibrate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vibrate');
    });
  }
}

extension AppStateRecordQueryProperty
    on QueryBuilder<AppStateRecord, AppStateRecord, QQueryProperty> {
  QueryBuilder<AppStateRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AppStateRecord, String, QQueryOperations>
      reminderSoundProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reminderSound');
    });
  }

  QueryBuilder<AppStateRecord, bool, QQueryOperations>
      showAnalogClockProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'showAnalogClock');
    });
  }

  QueryBuilder<AppStateRecord, int, QQueryOperations> snoozeMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'snoozeMinutes');
    });
  }

  QueryBuilder<AppStateRecord, bool, QQueryOperations>
      starterMedicationsLoadedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'starterMedicationsLoaded');
    });
  }

  QueryBuilder<AppStateRecord, bool, QQueryOperations>
      twentyFourHourProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'twentyFourHour');
    });
  }

  QueryBuilder<AppStateRecord, bool, QQueryOperations> vibrateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vibrate');
    });
  }
}
