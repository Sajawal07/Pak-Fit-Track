// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_log.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFoodLogCollection on Isar {
  IsarCollection<FoodLog> get foodLogs => this.collection();
}

const FoodLogSchema = CollectionSchema(
  name: r'FoodLog',
  id: -1012088423414645589,
  properties: {
    r'cookingMethod': PropertySchema(
      id: 0,
      name: r'cookingMethod',
      type: IsarType.string,
      enumMap: _FoodLogcookingMethodEnumValueMap,
    ),
    r'date': PropertySchema(
      id: 1,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'firebaseId': PropertySchema(
      id: 2,
      name: r'firebaseId',
      type: IsarType.string,
    ),
    r'foodItemId': PropertySchema(
      id: 3,
      name: r'foodItemId',
      type: IsarType.long,
    ),
    r'foodName': PropertySchema(
      id: 4,
      name: r'foodName',
      type: IsarType.string,
    ),
    r'isDeleted': PropertySchema(
      id: 5,
      name: r'isDeleted',
      type: IsarType.bool,
    ),
    r'isGuestData': PropertySchema(
      id: 6,
      name: r'isGuestData',
      type: IsarType.bool,
    ),
    r'isLiquid': PropertySchema(
      id: 7,
      name: r'isLiquid',
      type: IsarType.bool,
    ),
    r'isSynced': PropertySchema(
      id: 8,
      name: r'isSynced',
      type: IsarType.bool,
    ),
    r'isUltraProcessed': PropertySchema(
      id: 9,
      name: r'isUltraProcessed',
      type: IsarType.bool,
    ),
    r'loggedAt': PropertySchema(
      id: 10,
      name: r'loggedAt',
      type: IsarType.dateTime,
    ),
    r'mealType': PropertySchema(
      id: 11,
      name: r'mealType',
      type: IsarType.string,
      enumMap: _FoodLogmealTypeEnumValueMap,
    ),
    r'oilTeaspoons': PropertySchema(
      id: 12,
      name: r'oilTeaspoons',
      type: IsarType.double,
    ),
    r'ownerUid': PropertySchema(
      id: 13,
      name: r'ownerUid',
      type: IsarType.string,
    ),
    r'quantity': PropertySchema(
      id: 14,
      name: r'quantity',
      type: IsarType.double,
    ),
    r'satietyScore': PropertySchema(
      id: 15,
      name: r'satietyScore',
      type: IsarType.double,
    ),
    r'servingAmount': PropertySchema(
      id: 16,
      name: r'servingAmount',
      type: IsarType.double,
    ),
    r'servingType': PropertySchema(
      id: 17,
      name: r'servingType',
      type: IsarType.string,
      enumMap: _FoodLogservingTypeEnumValueMap,
    ),
    r'totalCalories': PropertySchema(
      id: 18,
      name: r'totalCalories',
      type: IsarType.double,
    ),
    r'totalCarbs': PropertySchema(
      id: 19,
      name: r'totalCarbs',
      type: IsarType.double,
    ),
    r'totalFat': PropertySchema(
      id: 20,
      name: r'totalFat',
      type: IsarType.double,
    ),
    r'totalFiber': PropertySchema(
      id: 21,
      name: r'totalFiber',
      type: IsarType.double,
    ),
    r'totalProtein': PropertySchema(
      id: 22,
      name: r'totalProtein',
      type: IsarType.double,
    ),
    r'totalSugar': PropertySchema(
      id: 23,
      name: r'totalSugar',
      type: IsarType.double,
    ),
    r'uid': PropertySchema(
      id: 24,
      name: r'uid',
      type: IsarType.string,
    ),
    r'waterPercentage': PropertySchema(
      id: 25,
      name: r'waterPercentage',
      type: IsarType.double,
    )
  },
  estimateSize: _foodLogEstimateSize,
  serialize: _foodLogSerialize,
  deserialize: _foodLogDeserialize,
  deserializeProp: _foodLogDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _foodLogGetId,
  getLinks: _foodLogGetLinks,
  attach: _foodLogAttach,
  version: '3.1.0+1',
);

int _foodLogEstimateSize(
  FoodLog object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.cookingMethod.name.length * 3;
  {
    final value = object.firebaseId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.foodName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.mealType.name.length * 3;
  {
    final value = object.ownerUid;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.servingType.name.length * 3;
  bytesCount += 3 + object.uid.length * 3;
  return bytesCount;
}

void _foodLogSerialize(
  FoodLog object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.cookingMethod.name);
  writer.writeDateTime(offsets[1], object.date);
  writer.writeString(offsets[2], object.firebaseId);
  writer.writeLong(offsets[3], object.foodItemId);
  writer.writeString(offsets[4], object.foodName);
  writer.writeBool(offsets[5], object.isDeleted);
  writer.writeBool(offsets[6], object.isGuestData);
  writer.writeBool(offsets[7], object.isLiquid);
  writer.writeBool(offsets[8], object.isSynced);
  writer.writeBool(offsets[9], object.isUltraProcessed);
  writer.writeDateTime(offsets[10], object.loggedAt);
  writer.writeString(offsets[11], object.mealType.name);
  writer.writeDouble(offsets[12], object.oilTeaspoons);
  writer.writeString(offsets[13], object.ownerUid);
  writer.writeDouble(offsets[14], object.quantity);
  writer.writeDouble(offsets[15], object.satietyScore);
  writer.writeDouble(offsets[16], object.servingAmount);
  writer.writeString(offsets[17], object.servingType.name);
  writer.writeDouble(offsets[18], object.totalCalories);
  writer.writeDouble(offsets[19], object.totalCarbs);
  writer.writeDouble(offsets[20], object.totalFat);
  writer.writeDouble(offsets[21], object.totalFiber);
  writer.writeDouble(offsets[22], object.totalProtein);
  writer.writeDouble(offsets[23], object.totalSugar);
  writer.writeString(offsets[24], object.uid);
  writer.writeDouble(offsets[25], object.waterPercentage);
}

FoodLog _foodLogDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FoodLog();
  object.cookingMethod =
      _FoodLogcookingMethodValueEnumMap[reader.readStringOrNull(offsets[0])] ??
          CookingMethod.none;
  object.date = reader.readDateTime(offsets[1]);
  object.firebaseId = reader.readStringOrNull(offsets[2]);
  object.foodItemId = reader.readLong(offsets[3]);
  object.foodName = reader.readStringOrNull(offsets[4]);
  object.id = id;
  object.isDeleted = reader.readBool(offsets[5]);
  object.isGuestData = reader.readBool(offsets[6]);
  object.isLiquid = reader.readBool(offsets[7]);
  object.isSynced = reader.readBool(offsets[8]);
  object.isUltraProcessed = reader.readBool(offsets[9]);
  object.loggedAt = reader.readDateTime(offsets[10]);
  object.mealType =
      _FoodLogmealTypeValueEnumMap[reader.readStringOrNull(offsets[11])] ??
          MealType.breakfast;
  object.oilTeaspoons = reader.readDouble(offsets[12]);
  object.ownerUid = reader.readStringOrNull(offsets[13]);
  object.quantity = reader.readDouble(offsets[14]);
  object.satietyScore = reader.readDouble(offsets[15]);
  object.servingAmount = reader.readDouble(offsets[16]);
  object.servingType =
      _FoodLogservingTypeValueEnumMap[reader.readStringOrNull(offsets[17])] ??
          ServingType.gram;
  object.totalCalories = reader.readDouble(offsets[18]);
  object.totalCarbs = reader.readDouble(offsets[19]);
  object.totalFat = reader.readDouble(offsets[20]);
  object.totalFiber = reader.readDouble(offsets[21]);
  object.totalProtein = reader.readDouble(offsets[22]);
  object.totalSugar = reader.readDouble(offsets[23]);
  object.uid = reader.readString(offsets[24]);
  object.waterPercentage = reader.readDouble(offsets[25]);
  return object;
}

P _foodLogDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_FoodLogcookingMethodValueEnumMap[
              reader.readStringOrNull(offset)] ??
          CookingMethod.none) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readBool(offset)) as P;
    case 9:
      return (reader.readBool(offset)) as P;
    case 10:
      return (reader.readDateTime(offset)) as P;
    case 11:
      return (_FoodLogmealTypeValueEnumMap[reader.readStringOrNull(offset)] ??
          MealType.breakfast) as P;
    case 12:
      return (reader.readDouble(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readDouble(offset)) as P;
    case 15:
      return (reader.readDouble(offset)) as P;
    case 16:
      return (reader.readDouble(offset)) as P;
    case 17:
      return (_FoodLogservingTypeValueEnumMap[
              reader.readStringOrNull(offset)] ??
          ServingType.gram) as P;
    case 18:
      return (reader.readDouble(offset)) as P;
    case 19:
      return (reader.readDouble(offset)) as P;
    case 20:
      return (reader.readDouble(offset)) as P;
    case 21:
      return (reader.readDouble(offset)) as P;
    case 22:
      return (reader.readDouble(offset)) as P;
    case 23:
      return (reader.readDouble(offset)) as P;
    case 24:
      return (reader.readString(offset)) as P;
    case 25:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _FoodLogcookingMethodEnumValueMap = {
  r'none': r'none',
  r'boiled': r'boiled',
  r'grilled': r'grilled',
  r'airFried': r'airFried',
  r'panFried': r'panFried',
  r'deepFried': r'deepFried',
};
const _FoodLogcookingMethodValueEnumMap = {
  r'none': CookingMethod.none,
  r'boiled': CookingMethod.boiled,
  r'grilled': CookingMethod.grilled,
  r'airFried': CookingMethod.airFried,
  r'panFried': CookingMethod.panFried,
  r'deepFried': CookingMethod.deepFried,
};
const _FoodLogmealTypeEnumValueMap = {
  r'breakfast': r'breakfast',
  r'lunch': r'lunch',
  r'dinner': r'dinner',
  r'snack': r'snack',
};
const _FoodLogmealTypeValueEnumMap = {
  r'breakfast': MealType.breakfast,
  r'lunch': MealType.lunch,
  r'dinner': MealType.dinner,
  r'snack': MealType.snack,
};
const _FoodLogservingTypeEnumValueMap = {
  r'gram': r'gram',
  r'plate': r'plate',
  r'bowl': r'bowl',
  r'piece': r'piece',
  r'cup': r'cup',
};
const _FoodLogservingTypeValueEnumMap = {
  r'gram': ServingType.gram,
  r'plate': ServingType.plate,
  r'bowl': ServingType.bowl,
  r'piece': ServingType.piece,
  r'cup': ServingType.cup,
};

Id _foodLogGetId(FoodLog object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _foodLogGetLinks(FoodLog object) {
  return [];
}

void _foodLogAttach(IsarCollection<dynamic> col, Id id, FoodLog object) {
  object.id = id;
}

extension FoodLogQueryWhereSort on QueryBuilder<FoodLog, FoodLog, QWhere> {
  QueryBuilder<FoodLog, FoodLog, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FoodLogQueryWhere on QueryBuilder<FoodLog, FoodLog, QWhereClause> {
  QueryBuilder<FoodLog, FoodLog, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<FoodLog, FoodLog, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterWhereClause> idBetween(
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

extension FoodLogQueryFilter
    on QueryBuilder<FoodLog, FoodLog, QFilterCondition> {
  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> cookingMethodEqualTo(
    CookingMethod value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cookingMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition>
      cookingMethodGreaterThan(
    CookingMethod value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cookingMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> cookingMethodLessThan(
    CookingMethod value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cookingMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> cookingMethodBetween(
    CookingMethod lower,
    CookingMethod upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cookingMethod',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> cookingMethodStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cookingMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> cookingMethodEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cookingMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> cookingMethodContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cookingMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> cookingMethodMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cookingMethod',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> cookingMethodIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cookingMethod',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition>
      cookingMethodIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cookingMethod',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> dateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> firebaseIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'firebaseId',
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> firebaseIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'firebaseId',
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> firebaseIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firebaseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> firebaseIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'firebaseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> firebaseIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'firebaseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> firebaseIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'firebaseId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> firebaseIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'firebaseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> firebaseIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'firebaseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> firebaseIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'firebaseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> firebaseIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'firebaseId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> firebaseIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firebaseId',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> firebaseIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'firebaseId',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> foodItemIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'foodItemId',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> foodItemIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'foodItemId',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> foodItemIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'foodItemId',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> foodItemIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'foodItemId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> foodNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'foodName',
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> foodNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'foodName',
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> foodNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'foodName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> foodNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'foodName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> foodNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'foodName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> foodNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'foodName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> foodNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'foodName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> foodNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'foodName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> foodNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'foodName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> foodNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'foodName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> foodNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'foodName',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> foodNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'foodName',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> idBetween(
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

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> isDeletedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDeleted',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> isGuestDataEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isGuestData',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> isLiquidEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isLiquid',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> isSyncedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSynced',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> isUltraProcessedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isUltraProcessed',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> loggedAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'loggedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> loggedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'loggedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> loggedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'loggedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> loggedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'loggedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> mealTypeEqualTo(
    MealType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mealType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> mealTypeGreaterThan(
    MealType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mealType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> mealTypeLessThan(
    MealType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mealType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> mealTypeBetween(
    MealType lower,
    MealType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mealType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> mealTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mealType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> mealTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mealType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> mealTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mealType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> mealTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mealType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> mealTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mealType',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> mealTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mealType',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> oilTeaspoonsEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'oilTeaspoons',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> oilTeaspoonsGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'oilTeaspoons',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> oilTeaspoonsLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'oilTeaspoons',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> oilTeaspoonsBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'oilTeaspoons',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> ownerUidIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ownerUid',
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> ownerUidIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ownerUid',
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> ownerUidEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ownerUid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> ownerUidGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ownerUid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> ownerUidLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ownerUid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> ownerUidBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ownerUid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> ownerUidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ownerUid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> ownerUidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ownerUid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> ownerUidContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ownerUid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> ownerUidMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ownerUid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> ownerUidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ownerUid',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> ownerUidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ownerUid',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> quantityEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> quantityGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> quantityLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> quantityBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quantity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> satietyScoreEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'satietyScore',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> satietyScoreGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'satietyScore',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> satietyScoreLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'satietyScore',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> satietyScoreBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'satietyScore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> servingAmountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'servingAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition>
      servingAmountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'servingAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> servingAmountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'servingAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> servingAmountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'servingAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> servingTypeEqualTo(
    ServingType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'servingType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> servingTypeGreaterThan(
    ServingType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'servingType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> servingTypeLessThan(
    ServingType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'servingType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> servingTypeBetween(
    ServingType lower,
    ServingType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'servingType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> servingTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'servingType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> servingTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'servingType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> servingTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'servingType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> servingTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'servingType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> servingTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'servingType',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition>
      servingTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'servingType',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> totalCaloriesEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalCalories',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition>
      totalCaloriesGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalCalories',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> totalCaloriesLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalCalories',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> totalCaloriesBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalCalories',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> totalCarbsEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalCarbs',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> totalCarbsGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalCarbs',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> totalCarbsLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalCarbs',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> totalCarbsBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalCarbs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> totalFatEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalFat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> totalFatGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalFat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> totalFatLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalFat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> totalFatBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalFat',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> totalFiberEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalFiber',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> totalFiberGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalFiber',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> totalFiberLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalFiber',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> totalFiberBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalFiber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> totalProteinEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalProtein',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> totalProteinGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalProtein',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> totalProteinLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalProtein',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> totalProteinBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalProtein',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> totalSugarEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalSugar',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> totalSugarGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalSugar',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> totalSugarLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalSugar',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> totalSugarBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalSugar',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> uidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> uidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> uidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> uidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> uidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> uidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> uidContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> uidMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> uidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uid',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> uidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uid',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> waterPercentageEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'waterPercentage',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition>
      waterPercentageGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'waterPercentage',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> waterPercentageLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'waterPercentage',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterFilterCondition> waterPercentageBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'waterPercentage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension FoodLogQueryObject
    on QueryBuilder<FoodLog, FoodLog, QFilterCondition> {}

extension FoodLogQueryLinks
    on QueryBuilder<FoodLog, FoodLog, QFilterCondition> {}

extension FoodLogQuerySortBy on QueryBuilder<FoodLog, FoodLog, QSortBy> {
  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByCookingMethod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cookingMethod', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByCookingMethodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cookingMethod', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByFirebaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseId', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByFirebaseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseId', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByFoodItemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'foodItemId', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByFoodItemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'foodItemId', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByFoodName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'foodName', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByFoodNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'foodName', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByIsGuestData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGuestData', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByIsGuestDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGuestData', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByIsLiquid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLiquid', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByIsLiquidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLiquid', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByIsUltraProcessed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUltraProcessed', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByIsUltraProcessedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUltraProcessed', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByLoggedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loggedAt', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByLoggedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loggedAt', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByMealType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealType', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByMealTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealType', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByOilTeaspoons() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'oilTeaspoons', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByOilTeaspoonsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'oilTeaspoons', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByOwnerUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownerUid', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByOwnerUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownerUid', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortBySatietyScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'satietyScore', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortBySatietyScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'satietyScore', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByServingAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servingAmount', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByServingAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servingAmount', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByServingType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servingType', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByServingTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servingType', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByTotalCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCalories', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByTotalCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCalories', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByTotalCarbs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCarbs', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByTotalCarbsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCarbs', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByTotalFat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFat', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByTotalFatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFat', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByTotalFiber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFiber', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByTotalFiberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFiber', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByTotalProtein() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalProtein', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByTotalProteinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalProtein', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByTotalSugar() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSugar', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByTotalSugarDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSugar', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByWaterPercentage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterPercentage', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> sortByWaterPercentageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterPercentage', Sort.desc);
    });
  }
}

extension FoodLogQuerySortThenBy
    on QueryBuilder<FoodLog, FoodLog, QSortThenBy> {
  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByCookingMethod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cookingMethod', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByCookingMethodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cookingMethod', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByFirebaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseId', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByFirebaseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseId', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByFoodItemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'foodItemId', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByFoodItemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'foodItemId', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByFoodName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'foodName', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByFoodNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'foodName', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByIsGuestData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGuestData', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByIsGuestDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGuestData', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByIsLiquid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLiquid', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByIsLiquidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLiquid', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByIsUltraProcessed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUltraProcessed', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByIsUltraProcessedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUltraProcessed', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByLoggedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loggedAt', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByLoggedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loggedAt', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByMealType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealType', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByMealTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealType', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByOilTeaspoons() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'oilTeaspoons', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByOilTeaspoonsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'oilTeaspoons', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByOwnerUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownerUid', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByOwnerUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownerUid', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenBySatietyScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'satietyScore', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenBySatietyScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'satietyScore', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByServingAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servingAmount', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByServingAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servingAmount', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByServingType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servingType', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByServingTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servingType', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByTotalCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCalories', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByTotalCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCalories', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByTotalCarbs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCarbs', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByTotalCarbsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCarbs', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByTotalFat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFat', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByTotalFatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFat', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByTotalFiber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFiber', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByTotalFiberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFiber', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByTotalProtein() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalProtein', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByTotalProteinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalProtein', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByTotalSugar() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSugar', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByTotalSugarDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSugar', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByWaterPercentage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterPercentage', Sort.asc);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QAfterSortBy> thenByWaterPercentageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterPercentage', Sort.desc);
    });
  }
}

extension FoodLogQueryWhereDistinct
    on QueryBuilder<FoodLog, FoodLog, QDistinct> {
  QueryBuilder<FoodLog, FoodLog, QDistinct> distinctByCookingMethod(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cookingMethod',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<FoodLog, FoodLog, QDistinct> distinctByFirebaseId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'firebaseId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QDistinct> distinctByFoodItemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'foodItemId');
    });
  }

  QueryBuilder<FoodLog, FoodLog, QDistinct> distinctByFoodName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'foodName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QDistinct> distinctByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDeleted');
    });
  }

  QueryBuilder<FoodLog, FoodLog, QDistinct> distinctByIsGuestData() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isGuestData');
    });
  }

  QueryBuilder<FoodLog, FoodLog, QDistinct> distinctByIsLiquid() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isLiquid');
    });
  }

  QueryBuilder<FoodLog, FoodLog, QDistinct> distinctByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSynced');
    });
  }

  QueryBuilder<FoodLog, FoodLog, QDistinct> distinctByIsUltraProcessed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isUltraProcessed');
    });
  }

  QueryBuilder<FoodLog, FoodLog, QDistinct> distinctByLoggedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'loggedAt');
    });
  }

  QueryBuilder<FoodLog, FoodLog, QDistinct> distinctByMealType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mealType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QDistinct> distinctByOilTeaspoons() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'oilTeaspoons');
    });
  }

  QueryBuilder<FoodLog, FoodLog, QDistinct> distinctByOwnerUid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ownerUid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QDistinct> distinctByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quantity');
    });
  }

  QueryBuilder<FoodLog, FoodLog, QDistinct> distinctBySatietyScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'satietyScore');
    });
  }

  QueryBuilder<FoodLog, FoodLog, QDistinct> distinctByServingAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'servingAmount');
    });
  }

  QueryBuilder<FoodLog, FoodLog, QDistinct> distinctByServingType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'servingType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QDistinct> distinctByTotalCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalCalories');
    });
  }

  QueryBuilder<FoodLog, FoodLog, QDistinct> distinctByTotalCarbs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalCarbs');
    });
  }

  QueryBuilder<FoodLog, FoodLog, QDistinct> distinctByTotalFat() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalFat');
    });
  }

  QueryBuilder<FoodLog, FoodLog, QDistinct> distinctByTotalFiber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalFiber');
    });
  }

  QueryBuilder<FoodLog, FoodLog, QDistinct> distinctByTotalProtein() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalProtein');
    });
  }

  QueryBuilder<FoodLog, FoodLog, QDistinct> distinctByTotalSugar() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalSugar');
    });
  }

  QueryBuilder<FoodLog, FoodLog, QDistinct> distinctByUid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FoodLog, FoodLog, QDistinct> distinctByWaterPercentage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'waterPercentage');
    });
  }
}

extension FoodLogQueryProperty
    on QueryBuilder<FoodLog, FoodLog, QQueryProperty> {
  QueryBuilder<FoodLog, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FoodLog, CookingMethod, QQueryOperations>
      cookingMethodProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cookingMethod');
    });
  }

  QueryBuilder<FoodLog, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<FoodLog, String?, QQueryOperations> firebaseIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'firebaseId');
    });
  }

  QueryBuilder<FoodLog, int, QQueryOperations> foodItemIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'foodItemId');
    });
  }

  QueryBuilder<FoodLog, String?, QQueryOperations> foodNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'foodName');
    });
  }

  QueryBuilder<FoodLog, bool, QQueryOperations> isDeletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDeleted');
    });
  }

  QueryBuilder<FoodLog, bool, QQueryOperations> isGuestDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isGuestData');
    });
  }

  QueryBuilder<FoodLog, bool, QQueryOperations> isLiquidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isLiquid');
    });
  }

  QueryBuilder<FoodLog, bool, QQueryOperations> isSyncedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSynced');
    });
  }

  QueryBuilder<FoodLog, bool, QQueryOperations> isUltraProcessedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isUltraProcessed');
    });
  }

  QueryBuilder<FoodLog, DateTime, QQueryOperations> loggedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'loggedAt');
    });
  }

  QueryBuilder<FoodLog, MealType, QQueryOperations> mealTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mealType');
    });
  }

  QueryBuilder<FoodLog, double, QQueryOperations> oilTeaspoonsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'oilTeaspoons');
    });
  }

  QueryBuilder<FoodLog, String?, QQueryOperations> ownerUidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ownerUid');
    });
  }

  QueryBuilder<FoodLog, double, QQueryOperations> quantityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quantity');
    });
  }

  QueryBuilder<FoodLog, double, QQueryOperations> satietyScoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'satietyScore');
    });
  }

  QueryBuilder<FoodLog, double, QQueryOperations> servingAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'servingAmount');
    });
  }

  QueryBuilder<FoodLog, ServingType, QQueryOperations> servingTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'servingType');
    });
  }

  QueryBuilder<FoodLog, double, QQueryOperations> totalCaloriesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalCalories');
    });
  }

  QueryBuilder<FoodLog, double, QQueryOperations> totalCarbsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalCarbs');
    });
  }

  QueryBuilder<FoodLog, double, QQueryOperations> totalFatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalFat');
    });
  }

  QueryBuilder<FoodLog, double, QQueryOperations> totalFiberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalFiber');
    });
  }

  QueryBuilder<FoodLog, double, QQueryOperations> totalProteinProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalProtein');
    });
  }

  QueryBuilder<FoodLog, double, QQueryOperations> totalSugarProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalSugar');
    });
  }

  QueryBuilder<FoodLog, String, QQueryOperations> uidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uid');
    });
  }

  QueryBuilder<FoodLog, double, QQueryOperations> waterPercentageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'waterPercentage');
    });
  }
}
