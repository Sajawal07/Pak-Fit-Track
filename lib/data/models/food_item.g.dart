// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_item.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFoodItemCollection on Isar {
  IsarCollection<FoodItem> get foodItems => this.collection();
}

const FoodItemSchema = CollectionSchema(
  name: r'FoodItem',
  id: 8311037358550475404,
  properties: {
    r'airFriedMultiplier': PropertySchema(
      id: 0,
      name: r'airFriedMultiplier',
      type: IsarType.double,
    ),
    r'allowedCookingMethods': PropertySchema(
      id: 1,
      name: r'allowedCookingMethods',
      type: IsarType.stringList,
    ),
    r'allowedServingUnits': PropertySchema(
      id: 2,
      name: r'allowedServingUnits',
      type: IsarType.stringList,
    ),
    r'boiledMultiplier': PropertySchema(
      id: 3,
      name: r'boiledMultiplier',
      type: IsarType.double,
    ),
    r'brand': PropertySchema(
      id: 4,
      name: r'brand',
      type: IsarType.string,
    ),
    r'caloriesPer100g': PropertySchema(
      id: 5,
      name: r'caloriesPer100g',
      type: IsarType.double,
    ),
    r'carbsPer100g': PropertySchema(
      id: 6,
      name: r'carbsPer100g',
      type: IsarType.double,
    ),
    r'category': PropertySchema(
      id: 7,
      name: r'category',
      type: IsarType.string,
      enumMap: _FoodItemcategoryEnumValueMap,
    ),
    r'createdAt': PropertySchema(
      id: 8,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'deepFriedMultiplier': PropertySchema(
      id: 9,
      name: r'deepFriedMultiplier',
      type: IsarType.double,
    ),
    r'description': PropertySchema(
      id: 10,
      name: r'description',
      type: IsarType.string,
    ),
    r'dynamicRank': PropertySchema(
      id: 11,
      name: r'dynamicRank',
      type: IsarType.long,
    ),
    r'family': PropertySchema(
      id: 12,
      name: r'family',
      type: IsarType.string,
    ),
    r'fatPer100g': PropertySchema(
      id: 13,
      name: r'fatPer100g',
      type: IsarType.double,
    ),
    r'fiberPer100g': PropertySchema(
      id: 14,
      name: r'fiberPer100g',
      type: IsarType.double,
    ),
    r'firebaseId': PropertySchema(
      id: 15,
      name: r'firebaseId',
      type: IsarType.string,
    ),
    r'grilledMultiplier': PropertySchema(
      id: 16,
      name: r'grilledMultiplier',
      type: IsarType.double,
    ),
    r'ingredients': PropertySchema(
      id: 17,
      name: r'ingredients',
      type: IsarType.stringList,
    ),
    r'inputMode': PropertySchema(
      id: 18,
      name: r'inputMode',
      type: IsarType.string,
      enumMap: _FoodIteminputModeEnumValueMap,
    ),
    r'isCustom': PropertySchema(
      id: 19,
      name: r'isCustom',
      type: IsarType.bool,
    ),
    r'isLiquid': PropertySchema(
      id: 20,
      name: r'isLiquid',
      type: IsarType.bool,
    ),
    r'isPakistani': PropertySchema(
      id: 21,
      name: r'isPakistani',
      type: IsarType.bool,
    ),
    r'isUltraProcessed': PropertySchema(
      id: 22,
      name: r'isUltraProcessed',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 23,
      name: r'name',
      type: IsarType.string,
    ),
    r'nameUrdu': PropertySchema(
      id: 24,
      name: r'nameUrdu',
      type: IsarType.string,
    ),
    r'panFriedMultiplier': PropertySchema(
      id: 25,
      name: r'panFriedMultiplier',
      type: IsarType.double,
    ),
    r'phoneticTokens': PropertySchema(
      id: 26,
      name: r'phoneticTokens',
      type: IsarType.stringList,
    ),
    r'proteinPer100g': PropertySchema(
      id: 27,
      name: r'proteinPer100g',
      type: IsarType.double,
    ),
    r'satietyScore': PropertySchema(
      id: 28,
      name: r'satietyScore',
      type: IsarType.double,
    ),
    r'schemaVersion': PropertySchema(
      id: 29,
      name: r'schemaVersion',
      type: IsarType.long,
    ),
    r'searchTokens': PropertySchema(
      id: 30,
      name: r'searchTokens',
      type: IsarType.stringList,
    ),
    r'seedId': PropertySchema(
      id: 31,
      name: r'seedId',
      type: IsarType.string,
    ),
    r'servingBowl': PropertySchema(
      id: 32,
      name: r'servingBowl',
      type: IsarType.double,
    ),
    r'servingCup': PropertySchema(
      id: 33,
      name: r'servingCup',
      type: IsarType.double,
    ),
    r'servingPiece': PropertySchema(
      id: 34,
      name: r'servingPiece',
      type: IsarType.double,
    ),
    r'servingPlate': PropertySchema(
      id: 35,
      name: r'servingPlate',
      type: IsarType.double,
    ),
    r'servingPresets': PropertySchema(
      id: 36,
      name: r'servingPresets',
      type: IsarType.objectList,
      target: r'ServingPreset',
    ),
    r'stateType': PropertySchema(
      id: 37,
      name: r'stateType',
      type: IsarType.string,
      enumMap: _FoodItemstateTypeEnumValueMap,
    ),
    r'staticRank': PropertySchema(
      id: 38,
      name: r'staticRank',
      type: IsarType.long,
    ),
    r'sugarPer100g': PropertySchema(
      id: 39,
      name: r'sugarPer100g',
      type: IsarType.double,
    ),
    r'supportsCookingMethod': PropertySchema(
      id: 40,
      name: r'supportsCookingMethod',
      type: IsarType.bool,
    ),
    r'supportsCustomServing': PropertySchema(
      id: 41,
      name: r'supportsCustomServing',
      type: IsarType.bool,
    ),
    r'supportsExtraOil': PropertySchema(
      id: 42,
      name: r'supportsExtraOil',
      type: IsarType.bool,
    ),
    r'type': PropertySchema(
      id: 43,
      name: r'type',
      type: IsarType.string,
    ),
    r'waterPercentage': PropertySchema(
      id: 44,
      name: r'waterPercentage',
      type: IsarType.double,
    )
  },
  estimateSize: _foodItemEstimateSize,
  serialize: _foodItemSerialize,
  deserialize: _foodItemDeserialize,
  deserializeProp: _foodItemDeserializeProp,
  idName: r'id',
  indexes: {
    r'seedId': IndexSchema(
      id: -5618340880442612555,
      name: r'seedId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'seedId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'family': IndexSchema(
      id: 1611489020059486243,
      name: r'family',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'family',
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    ),
    r'searchTokens': IndexSchema(
      id: 2062148741461982474,
      name: r'searchTokens',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'searchTokens',
          type: IndexType.hashElements,
          caseSensitive: true,
        )
      ],
    ),
    r'phoneticTokens': IndexSchema(
      id: 4371263264083884504,
      name: r'phoneticTokens',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'phoneticTokens',
          type: IndexType.hashElements,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'ServingPreset': ServingPresetSchema},
  getId: _foodItemGetId,
  getLinks: _foodItemGetLinks,
  attach: _foodItemAttach,
  version: '3.1.0+1',
);

int _foodItemEstimateSize(
  FoodItem object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.allowedCookingMethods.length * 3;
  {
    for (var i = 0; i < object.allowedCookingMethods.length; i++) {
      final value = object.allowedCookingMethods[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.allowedServingUnits.length * 3;
  {
    for (var i = 0; i < object.allowedServingUnits.length; i++) {
      final value = object.allowedServingUnits[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.brand;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.category.name.length * 3;
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.family;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.firebaseId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.ingredients.length * 3;
  {
    for (var i = 0; i < object.ingredients.length; i++) {
      final value = object.ingredients[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.inputMode.name.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.nameUrdu.length * 3;
  bytesCount += 3 + object.phoneticTokens.length * 3;
  {
    for (var i = 0; i < object.phoneticTokens.length; i++) {
      final value = object.phoneticTokens[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.searchTokens.length * 3;
  {
    for (var i = 0; i < object.searchTokens.length; i++) {
      final value = object.searchTokens[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.seedId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.servingPresets.length * 3;
  {
    final offsets = allOffsets[ServingPreset]!;
    for (var i = 0; i < object.servingPresets.length; i++) {
      final value = object.servingPresets[i];
      bytesCount +=
          ServingPresetSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.stateType.name.length * 3;
  bytesCount += 3 + object.type.length * 3;
  return bytesCount;
}

void _foodItemSerialize(
  FoodItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.airFriedMultiplier);
  writer.writeStringList(offsets[1], object.allowedCookingMethods);
  writer.writeStringList(offsets[2], object.allowedServingUnits);
  writer.writeDouble(offsets[3], object.boiledMultiplier);
  writer.writeString(offsets[4], object.brand);
  writer.writeDouble(offsets[5], object.caloriesPer100g);
  writer.writeDouble(offsets[6], object.carbsPer100g);
  writer.writeString(offsets[7], object.category.name);
  writer.writeDateTime(offsets[8], object.createdAt);
  writer.writeDouble(offsets[9], object.deepFriedMultiplier);
  writer.writeString(offsets[10], object.description);
  writer.writeLong(offsets[11], object.dynamicRank);
  writer.writeString(offsets[12], object.family);
  writer.writeDouble(offsets[13], object.fatPer100g);
  writer.writeDouble(offsets[14], object.fiberPer100g);
  writer.writeString(offsets[15], object.firebaseId);
  writer.writeDouble(offsets[16], object.grilledMultiplier);
  writer.writeStringList(offsets[17], object.ingredients);
  writer.writeString(offsets[18], object.inputMode.name);
  writer.writeBool(offsets[19], object.isCustom);
  writer.writeBool(offsets[20], object.isLiquid);
  writer.writeBool(offsets[21], object.isPakistani);
  writer.writeBool(offsets[22], object.isUltraProcessed);
  writer.writeString(offsets[23], object.name);
  writer.writeString(offsets[24], object.nameUrdu);
  writer.writeDouble(offsets[25], object.panFriedMultiplier);
  writer.writeStringList(offsets[26], object.phoneticTokens);
  writer.writeDouble(offsets[27], object.proteinPer100g);
  writer.writeDouble(offsets[28], object.satietyScore);
  writer.writeLong(offsets[29], object.schemaVersion);
  writer.writeStringList(offsets[30], object.searchTokens);
  writer.writeString(offsets[31], object.seedId);
  writer.writeDouble(offsets[32], object.servingBowl);
  writer.writeDouble(offsets[33], object.servingCup);
  writer.writeDouble(offsets[34], object.servingPiece);
  writer.writeDouble(offsets[35], object.servingPlate);
  writer.writeObjectList<ServingPreset>(
    offsets[36],
    allOffsets,
    ServingPresetSchema.serialize,
    object.servingPresets,
  );
  writer.writeString(offsets[37], object.stateType.name);
  writer.writeLong(offsets[38], object.staticRank);
  writer.writeDouble(offsets[39], object.sugarPer100g);
  writer.writeBool(offsets[40], object.supportsCookingMethod);
  writer.writeBool(offsets[41], object.supportsCustomServing);
  writer.writeBool(offsets[42], object.supportsExtraOil);
  writer.writeString(offsets[43], object.type);
  writer.writeDouble(offsets[44], object.waterPercentage);
}

FoodItem _foodItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FoodItem();
  object.airFriedMultiplier = reader.readDouble(offsets[0]);
  object.allowedCookingMethods = reader.readStringList(offsets[1]) ?? [];
  object.allowedServingUnits = reader.readStringList(offsets[2]) ?? [];
  object.boiledMultiplier = reader.readDouble(offsets[3]);
  object.brand = reader.readStringOrNull(offsets[4]);
  object.caloriesPer100g = reader.readDouble(offsets[5]);
  object.carbsPer100g = reader.readDouble(offsets[6]);
  object.category =
      _FoodItemcategoryValueEnumMap[reader.readStringOrNull(offsets[7])] ??
          FoodCategory.bread;
  object.createdAt = reader.readDateTime(offsets[8]);
  object.deepFriedMultiplier = reader.readDouble(offsets[9]);
  object.description = reader.readStringOrNull(offsets[10]);
  object.dynamicRank = reader.readLong(offsets[11]);
  object.family = reader.readStringOrNull(offsets[12]);
  object.fatPer100g = reader.readDouble(offsets[13]);
  object.fiberPer100g = reader.readDouble(offsets[14]);
  object.firebaseId = reader.readStringOrNull(offsets[15]);
  object.grilledMultiplier = reader.readDouble(offsets[16]);
  object.id = id;
  object.ingredients = reader.readStringList(offsets[17]) ?? [];
  object.inputMode =
      _FoodIteminputModeValueEnumMap[reader.readStringOrNull(offsets[18])] ??
          FoodInputMode.presetOnly;
  object.isCustom = reader.readBool(offsets[19]);
  object.isLiquid = reader.readBool(offsets[20]);
  object.isPakistani = reader.readBool(offsets[21]);
  object.isUltraProcessed = reader.readBool(offsets[22]);
  object.name = reader.readString(offsets[23]);
  object.nameUrdu = reader.readString(offsets[24]);
  object.panFriedMultiplier = reader.readDouble(offsets[25]);
  object.phoneticTokens = reader.readStringList(offsets[26]) ?? [];
  object.proteinPer100g = reader.readDouble(offsets[27]);
  object.satietyScore = reader.readDouble(offsets[28]);
  object.schemaVersion = reader.readLong(offsets[29]);
  object.searchTokens = reader.readStringList(offsets[30]) ?? [];
  object.seedId = reader.readStringOrNull(offsets[31]);
  object.servingBowl = reader.readDoubleOrNull(offsets[32]);
  object.servingCup = reader.readDoubleOrNull(offsets[33]);
  object.servingPiece = reader.readDoubleOrNull(offsets[34]);
  object.servingPlate = reader.readDoubleOrNull(offsets[35]);
  object.servingPresets = reader.readObjectList<ServingPreset>(
        offsets[36],
        ServingPresetSchema.deserialize,
        allOffsets,
        ServingPreset(),
      ) ??
      [];
  object.stateType =
      _FoodItemstateTypeValueEnumMap[reader.readStringOrNull(offsets[37])] ??
          FoodStateType.raw;
  object.staticRank = reader.readLong(offsets[38]);
  object.sugarPer100g = reader.readDouble(offsets[39]);
  object.supportsCookingMethod = reader.readBool(offsets[40]);
  object.supportsCustomServing = reader.readBool(offsets[41]);
  object.supportsExtraOil = reader.readBool(offsets[42]);
  object.type = reader.readString(offsets[43]);
  object.waterPercentage = reader.readDouble(offsets[44]);
  return object;
}

P _foodItemDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readStringList(offset) ?? []) as P;
    case 2:
      return (reader.readStringList(offset) ?? []) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    case 7:
      return (_FoodItemcategoryValueEnumMap[reader.readStringOrNull(offset)] ??
          FoodCategory.bread) as P;
    case 8:
      return (reader.readDateTime(offset)) as P;
    case 9:
      return (reader.readDouble(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readLong(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readDouble(offset)) as P;
    case 14:
      return (reader.readDouble(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readDouble(offset)) as P;
    case 17:
      return (reader.readStringList(offset) ?? []) as P;
    case 18:
      return (_FoodIteminputModeValueEnumMap[reader.readStringOrNull(offset)] ??
          FoodInputMode.presetOnly) as P;
    case 19:
      return (reader.readBool(offset)) as P;
    case 20:
      return (reader.readBool(offset)) as P;
    case 21:
      return (reader.readBool(offset)) as P;
    case 22:
      return (reader.readBool(offset)) as P;
    case 23:
      return (reader.readString(offset)) as P;
    case 24:
      return (reader.readString(offset)) as P;
    case 25:
      return (reader.readDouble(offset)) as P;
    case 26:
      return (reader.readStringList(offset) ?? []) as P;
    case 27:
      return (reader.readDouble(offset)) as P;
    case 28:
      return (reader.readDouble(offset)) as P;
    case 29:
      return (reader.readLong(offset)) as P;
    case 30:
      return (reader.readStringList(offset) ?? []) as P;
    case 31:
      return (reader.readStringOrNull(offset)) as P;
    case 32:
      return (reader.readDoubleOrNull(offset)) as P;
    case 33:
      return (reader.readDoubleOrNull(offset)) as P;
    case 34:
      return (reader.readDoubleOrNull(offset)) as P;
    case 35:
      return (reader.readDoubleOrNull(offset)) as P;
    case 36:
      return (reader.readObjectList<ServingPreset>(
            offset,
            ServingPresetSchema.deserialize,
            allOffsets,
            ServingPreset(),
          ) ??
          []) as P;
    case 37:
      return (_FoodItemstateTypeValueEnumMap[reader.readStringOrNull(offset)] ??
          FoodStateType.raw) as P;
    case 38:
      return (reader.readLong(offset)) as P;
    case 39:
      return (reader.readDouble(offset)) as P;
    case 40:
      return (reader.readBool(offset)) as P;
    case 41:
      return (reader.readBool(offset)) as P;
    case 42:
      return (reader.readBool(offset)) as P;
    case 43:
      return (reader.readString(offset)) as P;
    case 44:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _FoodItemcategoryEnumValueMap = {
  r'bread': r'bread',
  r'rice': r'rice',
  r'lentils': r'lentils',
  r'chicken': r'chicken',
  r'beef': r'beef',
  r'mutton': r'mutton',
  r'fish': r'fish',
  r'vegetables': r'vegetables',
  r'dairy': r'dairy',
  r'snacks': r'snacks',
  r'fruits': r'fruits',
  r'beverages': r'beverages',
  r'desserts': r'desserts',
  r'oils': r'oils',
  r'fastFood': r'fastFood',
  r'other': r'other',
};
const _FoodItemcategoryValueEnumMap = {
  r'bread': FoodCategory.bread,
  r'rice': FoodCategory.rice,
  r'lentils': FoodCategory.lentils,
  r'chicken': FoodCategory.chicken,
  r'beef': FoodCategory.beef,
  r'mutton': FoodCategory.mutton,
  r'fish': FoodCategory.fish,
  r'vegetables': FoodCategory.vegetables,
  r'dairy': FoodCategory.dairy,
  r'snacks': FoodCategory.snacks,
  r'fruits': FoodCategory.fruits,
  r'beverages': FoodCategory.beverages,
  r'desserts': FoodCategory.desserts,
  r'oils': FoodCategory.oils,
  r'fastFood': FoodCategory.fastFood,
  r'other': FoodCategory.other,
};
const _FoodIteminputModeEnumValueMap = {
  r'presetOnly': r'presetOnly',
  r'flexible': r'flexible',
  r'rawOnly': r'rawOnly',
};
const _FoodIteminputModeValueEnumMap = {
  r'presetOnly': FoodInputMode.presetOnly,
  r'flexible': FoodInputMode.flexible,
  r'rawOnly': FoodInputMode.rawOnly,
};
const _FoodItemstateTypeEnumValueMap = {
  r'raw': r'raw',
  r'semiProcessed': r'semiProcessed',
  r'cookedFixed': r'cookedFixed',
  r'composite': r'composite',
};
const _FoodItemstateTypeValueEnumMap = {
  r'raw': FoodStateType.raw,
  r'semiProcessed': FoodStateType.semiProcessed,
  r'cookedFixed': FoodStateType.cookedFixed,
  r'composite': FoodStateType.composite,
};

Id _foodItemGetId(FoodItem object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _foodItemGetLinks(FoodItem object) {
  return [];
}

void _foodItemAttach(IsarCollection<dynamic> col, Id id, FoodItem object) {
  object.id = id;
}

extension FoodItemByIndex on IsarCollection<FoodItem> {
  Future<FoodItem?> getBySeedId(String? seedId) {
    return getByIndex(r'seedId', [seedId]);
  }

  FoodItem? getBySeedIdSync(String? seedId) {
    return getByIndexSync(r'seedId', [seedId]);
  }

  Future<bool> deleteBySeedId(String? seedId) {
    return deleteByIndex(r'seedId', [seedId]);
  }

  bool deleteBySeedIdSync(String? seedId) {
    return deleteByIndexSync(r'seedId', [seedId]);
  }

  Future<List<FoodItem?>> getAllBySeedId(List<String?> seedIdValues) {
    final values = seedIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'seedId', values);
  }

  List<FoodItem?> getAllBySeedIdSync(List<String?> seedIdValues) {
    final values = seedIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'seedId', values);
  }

  Future<int> deleteAllBySeedId(List<String?> seedIdValues) {
    final values = seedIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'seedId', values);
  }

  int deleteAllBySeedIdSync(List<String?> seedIdValues) {
    final values = seedIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'seedId', values);
  }

  Future<Id> putBySeedId(FoodItem object) {
    return putByIndex(r'seedId', object);
  }

  Id putBySeedIdSync(FoodItem object, {bool saveLinks = true}) {
    return putByIndexSync(r'seedId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllBySeedId(List<FoodItem> objects) {
    return putAllByIndex(r'seedId', objects);
  }

  List<Id> putAllBySeedIdSync(List<FoodItem> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'seedId', objects, saveLinks: saveLinks);
  }
}

extension FoodItemQueryWhereSort on QueryBuilder<FoodItem, FoodItem, QWhere> {
  QueryBuilder<FoodItem, FoodItem, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterWhere> anyFamily() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'family'),
      );
    });
  }
}

extension FoodItemQueryWhere on QueryBuilder<FoodItem, FoodItem, QWhereClause> {
  QueryBuilder<FoodItem, FoodItem, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<FoodItem, FoodItem, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterWhereClause> idBetween(
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

  QueryBuilder<FoodItem, FoodItem, QAfterWhereClause> seedIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'seedId',
        value: [null],
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterWhereClause> seedIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'seedId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterWhereClause> seedIdEqualTo(
      String? seedId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'seedId',
        value: [seedId],
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterWhereClause> seedIdNotEqualTo(
      String? seedId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'seedId',
              lower: [],
              upper: [seedId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'seedId',
              lower: [seedId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'seedId',
              lower: [seedId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'seedId',
              lower: [],
              upper: [seedId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterWhereClause> familyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'family',
        value: [null],
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterWhereClause> familyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'family',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterWhereClause> familyEqualTo(
      String? family) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'family',
        value: [family],
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterWhereClause> familyNotEqualTo(
      String? family) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'family',
              lower: [],
              upper: [family],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'family',
              lower: [family],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'family',
              lower: [family],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'family',
              lower: [],
              upper: [family],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterWhereClause> familyGreaterThan(
    String? family, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'family',
        lower: [family],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterWhereClause> familyLessThan(
    String? family, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'family',
        lower: [],
        upper: [family],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterWhereClause> familyBetween(
    String? lowerFamily,
    String? upperFamily, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'family',
        lower: [lowerFamily],
        includeLower: includeLower,
        upper: [upperFamily],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterWhereClause> familyStartsWith(
      String FamilyPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'family',
        lower: [FamilyPrefix],
        upper: ['$FamilyPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterWhereClause> familyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'family',
        value: [''],
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterWhereClause> familyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'family',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'family',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'family',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'family',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterWhereClause>
      searchTokensElementEqualTo(String searchTokensElement) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'searchTokens',
        value: [searchTokensElement],
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterWhereClause>
      searchTokensElementNotEqualTo(String searchTokensElement) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchTokens',
              lower: [],
              upper: [searchTokensElement],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchTokens',
              lower: [searchTokensElement],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchTokens',
              lower: [searchTokensElement],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchTokens',
              lower: [],
              upper: [searchTokensElement],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterWhereClause>
      phoneticTokensElementEqualTo(String phoneticTokensElement) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'phoneticTokens',
        value: [phoneticTokensElement],
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterWhereClause>
      phoneticTokensElementNotEqualTo(String phoneticTokensElement) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'phoneticTokens',
              lower: [],
              upper: [phoneticTokensElement],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'phoneticTokens',
              lower: [phoneticTokensElement],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'phoneticTokens',
              lower: [phoneticTokensElement],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'phoneticTokens',
              lower: [],
              upper: [phoneticTokensElement],
              includeUpper: false,
            ));
      }
    });
  }
}

extension FoodItemQueryFilter
    on QueryBuilder<FoodItem, FoodItem, QFilterCondition> {
  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      airFriedMultiplierEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'airFriedMultiplier',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      airFriedMultiplierGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'airFriedMultiplier',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      airFriedMultiplierLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'airFriedMultiplier',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      airFriedMultiplierBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'airFriedMultiplier',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      allowedCookingMethodsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'allowedCookingMethods',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      allowedCookingMethodsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'allowedCookingMethods',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      allowedCookingMethodsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'allowedCookingMethods',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      allowedCookingMethodsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'allowedCookingMethods',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      allowedCookingMethodsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'allowedCookingMethods',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      allowedCookingMethodsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'allowedCookingMethods',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      allowedCookingMethodsElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'allowedCookingMethods',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      allowedCookingMethodsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'allowedCookingMethods',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      allowedCookingMethodsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'allowedCookingMethods',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      allowedCookingMethodsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'allowedCookingMethods',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      allowedCookingMethodsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allowedCookingMethods',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      allowedCookingMethodsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allowedCookingMethods',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      allowedCookingMethodsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allowedCookingMethods',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      allowedCookingMethodsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allowedCookingMethods',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      allowedCookingMethodsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allowedCookingMethods',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      allowedCookingMethodsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allowedCookingMethods',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      allowedServingUnitsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'allowedServingUnits',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      allowedServingUnitsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'allowedServingUnits',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      allowedServingUnitsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'allowedServingUnits',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      allowedServingUnitsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'allowedServingUnits',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      allowedServingUnitsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'allowedServingUnits',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      allowedServingUnitsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'allowedServingUnits',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      allowedServingUnitsElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'allowedServingUnits',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      allowedServingUnitsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'allowedServingUnits',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      allowedServingUnitsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'allowedServingUnits',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      allowedServingUnitsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'allowedServingUnits',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      allowedServingUnitsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allowedServingUnits',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      allowedServingUnitsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allowedServingUnits',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      allowedServingUnitsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allowedServingUnits',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      allowedServingUnitsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allowedServingUnits',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      allowedServingUnitsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allowedServingUnits',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      allowedServingUnitsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allowedServingUnits',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      boiledMultiplierEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'boiledMultiplier',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      boiledMultiplierGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'boiledMultiplier',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      boiledMultiplierLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'boiledMultiplier',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      boiledMultiplierBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'boiledMultiplier',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> brandIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'brand',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> brandIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'brand',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> brandEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> brandGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> brandLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> brandBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'brand',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> brandStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> brandEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> brandContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> brandMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'brand',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> brandIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'brand',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> brandIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'brand',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      caloriesPer100gEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'caloriesPer100g',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      caloriesPer100gGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'caloriesPer100g',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      caloriesPer100gLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'caloriesPer100g',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      caloriesPer100gBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'caloriesPer100g',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> carbsPer100gEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'carbsPer100g',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      carbsPer100gGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'carbsPer100g',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> carbsPer100gLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'carbsPer100g',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> carbsPer100gBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'carbsPer100g',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> categoryEqualTo(
    FoodCategory value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> categoryGreaterThan(
    FoodCategory value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> categoryLessThan(
    FoodCategory value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> categoryBetween(
    FoodCategory lower,
    FoodCategory upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> categoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> categoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> categoryContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> categoryMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      deepFriedMultiplierEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deepFriedMultiplier',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      deepFriedMultiplierGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deepFriedMultiplier',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      deepFriedMultiplierLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deepFriedMultiplier',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      deepFriedMultiplierBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deepFriedMultiplier',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> descriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      descriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> descriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> descriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> descriptionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> descriptionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> dynamicRankEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dynamicRank',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      dynamicRankGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dynamicRank',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> dynamicRankLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dynamicRank',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> dynamicRankBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dynamicRank',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> familyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'family',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> familyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'family',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> familyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'family',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> familyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'family',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> familyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'family',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> familyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'family',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> familyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'family',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> familyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'family',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> familyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'family',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> familyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'family',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> familyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'family',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> familyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'family',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> fatPer100gEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fatPer100g',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> fatPer100gGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fatPer100g',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> fatPer100gLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fatPer100g',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> fatPer100gBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fatPer100g',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> fiberPer100gEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fiberPer100g',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      fiberPer100gGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fiberPer100g',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> fiberPer100gLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fiberPer100g',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> fiberPer100gBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fiberPer100g',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> firebaseIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'firebaseId',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      firebaseIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'firebaseId',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> firebaseIdEqualTo(
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

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> firebaseIdGreaterThan(
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

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> firebaseIdLessThan(
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

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> firebaseIdBetween(
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

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> firebaseIdStartsWith(
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

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> firebaseIdEndsWith(
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

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> firebaseIdContains(
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

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> firebaseIdMatches(
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

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> firebaseIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firebaseId',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      firebaseIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'firebaseId',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      grilledMultiplierEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'grilledMultiplier',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      grilledMultiplierGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'grilledMultiplier',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      grilledMultiplierLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'grilledMultiplier',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      grilledMultiplierBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'grilledMultiplier',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> idBetween(
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

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      ingredientsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ingredients',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      ingredientsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ingredients',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      ingredientsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ingredients',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      ingredientsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ingredients',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      ingredientsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ingredients',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      ingredientsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ingredients',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      ingredientsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ingredients',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      ingredientsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ingredients',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      ingredientsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ingredients',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      ingredientsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ingredients',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      ingredientsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ingredients',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> ingredientsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ingredients',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      ingredientsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ingredients',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      ingredientsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ingredients',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      ingredientsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ingredients',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      ingredientsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ingredients',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> inputModeEqualTo(
    FoodInputMode value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inputMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> inputModeGreaterThan(
    FoodInputMode value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'inputMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> inputModeLessThan(
    FoodInputMode value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'inputMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> inputModeBetween(
    FoodInputMode lower,
    FoodInputMode upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'inputMode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> inputModeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'inputMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> inputModeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'inputMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> inputModeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'inputMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> inputModeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'inputMode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> inputModeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inputMode',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      inputModeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'inputMode',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> isCustomEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCustom',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> isLiquidEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isLiquid',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> isPakistaniEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isPakistani',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      isUltraProcessedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isUltraProcessed',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> nameContains(
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

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> nameUrduEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nameUrdu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> nameUrduGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nameUrdu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> nameUrduLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nameUrdu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> nameUrduBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nameUrdu',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> nameUrduStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nameUrdu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> nameUrduEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nameUrdu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> nameUrduContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nameUrdu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> nameUrduMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nameUrdu',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> nameUrduIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nameUrdu',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> nameUrduIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nameUrdu',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      panFriedMultiplierEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'panFriedMultiplier',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      panFriedMultiplierGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'panFriedMultiplier',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      panFriedMultiplierLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'panFriedMultiplier',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      panFriedMultiplierBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'panFriedMultiplier',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      phoneticTokensElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phoneticTokens',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      phoneticTokensElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'phoneticTokens',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      phoneticTokensElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'phoneticTokens',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      phoneticTokensElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'phoneticTokens',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      phoneticTokensElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'phoneticTokens',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      phoneticTokensElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'phoneticTokens',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      phoneticTokensElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'phoneticTokens',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      phoneticTokensElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'phoneticTokens',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      phoneticTokensElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phoneticTokens',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      phoneticTokensElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'phoneticTokens',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      phoneticTokensLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'phoneticTokens',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      phoneticTokensIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'phoneticTokens',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      phoneticTokensIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'phoneticTokens',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      phoneticTokensLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'phoneticTokens',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      phoneticTokensLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'phoneticTokens',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      phoneticTokensLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'phoneticTokens',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> proteinPer100gEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'proteinPer100g',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      proteinPer100gGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'proteinPer100g',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      proteinPer100gLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'proteinPer100g',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> proteinPer100gBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'proteinPer100g',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> satietyScoreEqualTo(
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

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      satietyScoreGreaterThan(
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

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> satietyScoreLessThan(
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

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> satietyScoreBetween(
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

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> schemaVersionEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'schemaVersion',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      schemaVersionGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'schemaVersion',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> schemaVersionLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'schemaVersion',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> schemaVersionBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'schemaVersion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      searchTokensElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'searchTokens',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      searchTokensElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'searchTokens',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      searchTokensElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'searchTokens',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      searchTokensElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'searchTokens',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      searchTokensElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'searchTokens',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      searchTokensElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'searchTokens',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      searchTokensElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'searchTokens',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      searchTokensElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'searchTokens',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      searchTokensElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'searchTokens',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      searchTokensElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'searchTokens',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      searchTokensLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'searchTokens',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      searchTokensIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'searchTokens',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      searchTokensIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'searchTokens',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      searchTokensLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'searchTokens',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      searchTokensLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'searchTokens',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      searchTokensLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'searchTokens',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> seedIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'seedId',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> seedIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'seedId',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> seedIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'seedId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> seedIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'seedId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> seedIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'seedId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> seedIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'seedId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> seedIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'seedId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> seedIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'seedId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> seedIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'seedId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> seedIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'seedId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> seedIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'seedId',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> seedIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'seedId',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> servingBowlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'servingBowl',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      servingBowlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'servingBowl',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> servingBowlEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'servingBowl',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      servingBowlGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'servingBowl',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> servingBowlLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'servingBowl',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> servingBowlBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'servingBowl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> servingCupIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'servingCup',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      servingCupIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'servingCup',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> servingCupEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'servingCup',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> servingCupGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'servingCup',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> servingCupLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'servingCup',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> servingCupBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'servingCup',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> servingPieceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'servingPiece',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      servingPieceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'servingPiece',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> servingPieceEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'servingPiece',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      servingPieceGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'servingPiece',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> servingPieceLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'servingPiece',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> servingPieceBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'servingPiece',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> servingPlateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'servingPlate',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      servingPlateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'servingPlate',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> servingPlateEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'servingPlate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      servingPlateGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'servingPlate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> servingPlateLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'servingPlate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> servingPlateBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'servingPlate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      servingPresetsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'servingPresets',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      servingPresetsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'servingPresets',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      servingPresetsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'servingPresets',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      servingPresetsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'servingPresets',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      servingPresetsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'servingPresets',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      servingPresetsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'servingPresets',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> stateTypeEqualTo(
    FoodStateType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stateType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> stateTypeGreaterThan(
    FoodStateType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stateType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> stateTypeLessThan(
    FoodStateType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stateType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> stateTypeBetween(
    FoodStateType lower,
    FoodStateType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stateType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> stateTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'stateType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> stateTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'stateType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> stateTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'stateType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> stateTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'stateType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> stateTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stateType',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      stateTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stateType',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> staticRankEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'staticRank',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> staticRankGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'staticRank',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> staticRankLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'staticRank',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> staticRankBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'staticRank',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> sugarPer100gEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sugarPer100g',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      sugarPer100gGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sugarPer100g',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> sugarPer100gLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sugarPer100g',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> sugarPer100gBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sugarPer100g',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      supportsCookingMethodEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'supportsCookingMethod',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      supportsCustomServingEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'supportsCustomServing',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      supportsExtraOilEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'supportsExtraOil',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> typeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> typeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> typeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> typeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> typeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      waterPercentageEqualTo(
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

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
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

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      waterPercentageLessThan(
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

  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition>
      waterPercentageBetween(
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

extension FoodItemQueryObject
    on QueryBuilder<FoodItem, FoodItem, QFilterCondition> {
  QueryBuilder<FoodItem, FoodItem, QAfterFilterCondition> servingPresetsElement(
      FilterQuery<ServingPreset> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'servingPresets');
    });
  }
}

extension FoodItemQueryLinks
    on QueryBuilder<FoodItem, FoodItem, QFilterCondition> {}

extension FoodItemQuerySortBy on QueryBuilder<FoodItem, FoodItem, QSortBy> {
  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByAirFriedMultiplier() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'airFriedMultiplier', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy>
      sortByAirFriedMultiplierDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'airFriedMultiplier', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByBoiledMultiplier() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boiledMultiplier', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByBoiledMultiplierDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boiledMultiplier', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByBrand() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brand', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByBrandDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brand', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByCaloriesPer100g() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caloriesPer100g', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByCaloriesPer100gDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caloriesPer100g', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByCarbsPer100g() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carbsPer100g', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByCarbsPer100gDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carbsPer100g', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByDeepFriedMultiplier() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deepFriedMultiplier', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy>
      sortByDeepFriedMultiplierDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deepFriedMultiplier', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByDynamicRank() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dynamicRank', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByDynamicRankDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dynamicRank', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByFamily() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'family', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByFamilyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'family', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByFatPer100g() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fatPer100g', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByFatPer100gDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fatPer100g', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByFiberPer100g() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fiberPer100g', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByFiberPer100gDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fiberPer100g', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByFirebaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseId', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByFirebaseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseId', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByGrilledMultiplier() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grilledMultiplier', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByGrilledMultiplierDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grilledMultiplier', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByInputMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inputMode', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByInputModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inputMode', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByIsCustom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCustom', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByIsCustomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCustom', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByIsLiquid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLiquid', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByIsLiquidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLiquid', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByIsPakistani() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPakistani', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByIsPakistaniDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPakistani', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByIsUltraProcessed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUltraProcessed', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByIsUltraProcessedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUltraProcessed', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByNameUrdu() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameUrdu', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByNameUrduDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameUrdu', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByPanFriedMultiplier() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'panFriedMultiplier', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy>
      sortByPanFriedMultiplierDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'panFriedMultiplier', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByProteinPer100g() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proteinPer100g', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByProteinPer100gDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proteinPer100g', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortBySatietyScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'satietyScore', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortBySatietyScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'satietyScore', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortBySchemaVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'schemaVersion', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortBySchemaVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'schemaVersion', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortBySeedId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seedId', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortBySeedIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seedId', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByServingBowl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servingBowl', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByServingBowlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servingBowl', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByServingCup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servingCup', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByServingCupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servingCup', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByServingPiece() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servingPiece', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByServingPieceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servingPiece', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByServingPlate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servingPlate', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByServingPlateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servingPlate', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByStateType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stateType', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByStateTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stateType', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByStaticRank() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'staticRank', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByStaticRankDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'staticRank', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortBySugarPer100g() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sugarPer100g', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortBySugarPer100gDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sugarPer100g', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortBySupportsCookingMethod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supportsCookingMethod', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy>
      sortBySupportsCookingMethodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supportsCookingMethod', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortBySupportsCustomServing() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supportsCustomServing', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy>
      sortBySupportsCustomServingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supportsCustomServing', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortBySupportsExtraOil() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supportsExtraOil', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortBySupportsExtraOilDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supportsExtraOil', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByWaterPercentage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterPercentage', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> sortByWaterPercentageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterPercentage', Sort.desc);
    });
  }
}

extension FoodItemQuerySortThenBy
    on QueryBuilder<FoodItem, FoodItem, QSortThenBy> {
  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByAirFriedMultiplier() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'airFriedMultiplier', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy>
      thenByAirFriedMultiplierDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'airFriedMultiplier', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByBoiledMultiplier() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boiledMultiplier', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByBoiledMultiplierDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boiledMultiplier', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByBrand() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brand', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByBrandDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brand', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByCaloriesPer100g() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caloriesPer100g', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByCaloriesPer100gDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caloriesPer100g', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByCarbsPer100g() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carbsPer100g', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByCarbsPer100gDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carbsPer100g', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByDeepFriedMultiplier() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deepFriedMultiplier', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy>
      thenByDeepFriedMultiplierDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deepFriedMultiplier', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByDynamicRank() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dynamicRank', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByDynamicRankDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dynamicRank', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByFamily() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'family', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByFamilyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'family', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByFatPer100g() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fatPer100g', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByFatPer100gDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fatPer100g', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByFiberPer100g() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fiberPer100g', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByFiberPer100gDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fiberPer100g', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByFirebaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseId', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByFirebaseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseId', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByGrilledMultiplier() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grilledMultiplier', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByGrilledMultiplierDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grilledMultiplier', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByInputMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inputMode', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByInputModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inputMode', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByIsCustom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCustom', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByIsCustomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCustom', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByIsLiquid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLiquid', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByIsLiquidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLiquid', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByIsPakistani() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPakistani', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByIsPakistaniDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPakistani', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByIsUltraProcessed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUltraProcessed', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByIsUltraProcessedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUltraProcessed', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByNameUrdu() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameUrdu', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByNameUrduDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameUrdu', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByPanFriedMultiplier() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'panFriedMultiplier', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy>
      thenByPanFriedMultiplierDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'panFriedMultiplier', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByProteinPer100g() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proteinPer100g', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByProteinPer100gDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proteinPer100g', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenBySatietyScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'satietyScore', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenBySatietyScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'satietyScore', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenBySchemaVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'schemaVersion', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenBySchemaVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'schemaVersion', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenBySeedId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seedId', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenBySeedIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seedId', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByServingBowl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servingBowl', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByServingBowlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servingBowl', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByServingCup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servingCup', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByServingCupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servingCup', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByServingPiece() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servingPiece', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByServingPieceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servingPiece', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByServingPlate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servingPlate', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByServingPlateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servingPlate', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByStateType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stateType', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByStateTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stateType', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByStaticRank() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'staticRank', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByStaticRankDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'staticRank', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenBySugarPer100g() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sugarPer100g', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenBySugarPer100gDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sugarPer100g', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenBySupportsCookingMethod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supportsCookingMethod', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy>
      thenBySupportsCookingMethodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supportsCookingMethod', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenBySupportsCustomServing() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supportsCustomServing', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy>
      thenBySupportsCustomServingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supportsCustomServing', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenBySupportsExtraOil() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supportsExtraOil', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenBySupportsExtraOilDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supportsExtraOil', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByWaterPercentage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterPercentage', Sort.asc);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QAfterSortBy> thenByWaterPercentageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterPercentage', Sort.desc);
    });
  }
}

extension FoodItemQueryWhereDistinct
    on QueryBuilder<FoodItem, FoodItem, QDistinct> {
  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctByAirFriedMultiplier() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'airFriedMultiplier');
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct>
      distinctByAllowedCookingMethods() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'allowedCookingMethods');
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctByAllowedServingUnits() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'allowedServingUnits');
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctByBoiledMultiplier() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'boiledMultiplier');
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctByBrand(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'brand', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctByCaloriesPer100g() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'caloriesPer100g');
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctByCarbsPer100g() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'carbsPer100g');
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctByCategory(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctByDeepFriedMultiplier() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deepFriedMultiplier');
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctByDynamicRank() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dynamicRank');
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctByFamily(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'family', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctByFatPer100g() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fatPer100g');
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctByFiberPer100g() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fiberPer100g');
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctByFirebaseId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'firebaseId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctByGrilledMultiplier() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'grilledMultiplier');
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctByIngredients() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ingredients');
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctByInputMode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'inputMode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctByIsCustom() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCustom');
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctByIsLiquid() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isLiquid');
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctByIsPakistani() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPakistani');
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctByIsUltraProcessed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isUltraProcessed');
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctByNameUrdu(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nameUrdu', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctByPanFriedMultiplier() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'panFriedMultiplier');
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctByPhoneticTokens() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'phoneticTokens');
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctByProteinPer100g() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'proteinPer100g');
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctBySatietyScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'satietyScore');
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctBySchemaVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'schemaVersion');
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctBySearchTokens() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'searchTokens');
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctBySeedId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'seedId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctByServingBowl() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'servingBowl');
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctByServingCup() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'servingCup');
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctByServingPiece() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'servingPiece');
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctByServingPlate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'servingPlate');
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctByStateType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stateType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctByStaticRank() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'staticRank');
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctBySugarPer100g() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sugarPer100g');
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct>
      distinctBySupportsCookingMethod() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'supportsCookingMethod');
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct>
      distinctBySupportsCustomServing() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'supportsCustomServing');
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctBySupportsExtraOil() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'supportsExtraOil');
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FoodItem, FoodItem, QDistinct> distinctByWaterPercentage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'waterPercentage');
    });
  }
}

extension FoodItemQueryProperty
    on QueryBuilder<FoodItem, FoodItem, QQueryProperty> {
  QueryBuilder<FoodItem, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FoodItem, double, QQueryOperations>
      airFriedMultiplierProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'airFriedMultiplier');
    });
  }

  QueryBuilder<FoodItem, List<String>, QQueryOperations>
      allowedCookingMethodsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'allowedCookingMethods');
    });
  }

  QueryBuilder<FoodItem, List<String>, QQueryOperations>
      allowedServingUnitsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'allowedServingUnits');
    });
  }

  QueryBuilder<FoodItem, double, QQueryOperations> boiledMultiplierProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'boiledMultiplier');
    });
  }

  QueryBuilder<FoodItem, String?, QQueryOperations> brandProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'brand');
    });
  }

  QueryBuilder<FoodItem, double, QQueryOperations> caloriesPer100gProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'caloriesPer100g');
    });
  }

  QueryBuilder<FoodItem, double, QQueryOperations> carbsPer100gProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'carbsPer100g');
    });
  }

  QueryBuilder<FoodItem, FoodCategory, QQueryOperations> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<FoodItem, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<FoodItem, double, QQueryOperations>
      deepFriedMultiplierProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deepFriedMultiplier');
    });
  }

  QueryBuilder<FoodItem, String?, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<FoodItem, int, QQueryOperations> dynamicRankProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dynamicRank');
    });
  }

  QueryBuilder<FoodItem, String?, QQueryOperations> familyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'family');
    });
  }

  QueryBuilder<FoodItem, double, QQueryOperations> fatPer100gProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fatPer100g');
    });
  }

  QueryBuilder<FoodItem, double, QQueryOperations> fiberPer100gProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fiberPer100g');
    });
  }

  QueryBuilder<FoodItem, String?, QQueryOperations> firebaseIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'firebaseId');
    });
  }

  QueryBuilder<FoodItem, double, QQueryOperations> grilledMultiplierProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'grilledMultiplier');
    });
  }

  QueryBuilder<FoodItem, List<String>, QQueryOperations> ingredientsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ingredients');
    });
  }

  QueryBuilder<FoodItem, FoodInputMode, QQueryOperations> inputModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'inputMode');
    });
  }

  QueryBuilder<FoodItem, bool, QQueryOperations> isCustomProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCustom');
    });
  }

  QueryBuilder<FoodItem, bool, QQueryOperations> isLiquidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isLiquid');
    });
  }

  QueryBuilder<FoodItem, bool, QQueryOperations> isPakistaniProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPakistani');
    });
  }

  QueryBuilder<FoodItem, bool, QQueryOperations> isUltraProcessedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isUltraProcessed');
    });
  }

  QueryBuilder<FoodItem, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<FoodItem, String, QQueryOperations> nameUrduProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nameUrdu');
    });
  }

  QueryBuilder<FoodItem, double, QQueryOperations>
      panFriedMultiplierProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'panFriedMultiplier');
    });
  }

  QueryBuilder<FoodItem, List<String>, QQueryOperations>
      phoneticTokensProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'phoneticTokens');
    });
  }

  QueryBuilder<FoodItem, double, QQueryOperations> proteinPer100gProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'proteinPer100g');
    });
  }

  QueryBuilder<FoodItem, double, QQueryOperations> satietyScoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'satietyScore');
    });
  }

  QueryBuilder<FoodItem, int, QQueryOperations> schemaVersionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'schemaVersion');
    });
  }

  QueryBuilder<FoodItem, List<String>, QQueryOperations>
      searchTokensProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'searchTokens');
    });
  }

  QueryBuilder<FoodItem, String?, QQueryOperations> seedIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'seedId');
    });
  }

  QueryBuilder<FoodItem, double?, QQueryOperations> servingBowlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'servingBowl');
    });
  }

  QueryBuilder<FoodItem, double?, QQueryOperations> servingCupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'servingCup');
    });
  }

  QueryBuilder<FoodItem, double?, QQueryOperations> servingPieceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'servingPiece');
    });
  }

  QueryBuilder<FoodItem, double?, QQueryOperations> servingPlateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'servingPlate');
    });
  }

  QueryBuilder<FoodItem, List<ServingPreset>, QQueryOperations>
      servingPresetsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'servingPresets');
    });
  }

  QueryBuilder<FoodItem, FoodStateType, QQueryOperations> stateTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stateType');
    });
  }

  QueryBuilder<FoodItem, int, QQueryOperations> staticRankProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'staticRank');
    });
  }

  QueryBuilder<FoodItem, double, QQueryOperations> sugarPer100gProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sugarPer100g');
    });
  }

  QueryBuilder<FoodItem, bool, QQueryOperations>
      supportsCookingMethodProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'supportsCookingMethod');
    });
  }

  QueryBuilder<FoodItem, bool, QQueryOperations>
      supportsCustomServingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'supportsCustomServing');
    });
  }

  QueryBuilder<FoodItem, bool, QQueryOperations> supportsExtraOilProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'supportsExtraOil');
    });
  }

  QueryBuilder<FoodItem, String, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<FoodItem, double, QQueryOperations> waterPercentageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'waterPercentage');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const ServingPresetSchema = Schema(
  name: r'ServingPreset',
  id: -7975243277374335934,
  properties: {
    r'gramsConfidence': PropertySchema(
      id: 0,
      name: r'gramsConfidence',
      type: IsarType.string,
      enumMap: _ServingPresetgramsConfidenceEnumValueMap,
    ),
    r'gramsEquivalent': PropertySchema(
      id: 1,
      name: r'gramsEquivalent',
      type: IsarType.double,
    ),
    r'label': PropertySchema(
      id: 2,
      name: r'label',
      type: IsarType.string,
    ),
    r'quantity': PropertySchema(
      id: 3,
      name: r'quantity',
      type: IsarType.double,
    ),
    r'unit': PropertySchema(
      id: 4,
      name: r'unit',
      type: IsarType.string,
    )
  },
  estimateSize: _servingPresetEstimateSize,
  serialize: _servingPresetSerialize,
  deserialize: _servingPresetDeserialize,
  deserializeProp: _servingPresetDeserializeProp,
);

int _servingPresetEstimateSize(
  ServingPreset object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.gramsConfidence.name.length * 3;
  bytesCount += 3 + object.label.length * 3;
  bytesCount += 3 + object.unit.length * 3;
  return bytesCount;
}

void _servingPresetSerialize(
  ServingPreset object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.gramsConfidence.name);
  writer.writeDouble(offsets[1], object.gramsEquivalent);
  writer.writeString(offsets[2], object.label);
  writer.writeDouble(offsets[3], object.quantity);
  writer.writeString(offsets[4], object.unit);
}

ServingPreset _servingPresetDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ServingPreset();
  object.gramsConfidence = _ServingPresetgramsConfidenceValueEnumMap[
          reader.readStringOrNull(offsets[0])] ??
      DataConfidence.high;
  object.gramsEquivalent = reader.readDoubleOrNull(offsets[1]);
  object.label = reader.readString(offsets[2]);
  object.quantity = reader.readDouble(offsets[3]);
  object.unit = reader.readString(offsets[4]);
  return object;
}

P _servingPresetDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_ServingPresetgramsConfidenceValueEnumMap[
              reader.readStringOrNull(offset)] ??
          DataConfidence.high) as P;
    case 1:
      return (reader.readDoubleOrNull(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _ServingPresetgramsConfidenceEnumValueMap = {
  r'high': r'high',
  r'medium': r'medium',
  r'low': r'low',
};
const _ServingPresetgramsConfidenceValueEnumMap = {
  r'high': DataConfidence.high,
  r'medium': DataConfidence.medium,
  r'low': DataConfidence.low,
};

extension ServingPresetQueryFilter
    on QueryBuilder<ServingPreset, ServingPreset, QFilterCondition> {
  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition>
      gramsConfidenceEqualTo(
    DataConfidence value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gramsConfidence',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition>
      gramsConfidenceGreaterThan(
    DataConfidence value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gramsConfidence',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition>
      gramsConfidenceLessThan(
    DataConfidence value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gramsConfidence',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition>
      gramsConfidenceBetween(
    DataConfidence lower,
    DataConfidence upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gramsConfidence',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition>
      gramsConfidenceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'gramsConfidence',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition>
      gramsConfidenceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'gramsConfidence',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition>
      gramsConfidenceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'gramsConfidence',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition>
      gramsConfidenceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'gramsConfidence',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition>
      gramsConfidenceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gramsConfidence',
        value: '',
      ));
    });
  }

  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition>
      gramsConfidenceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'gramsConfidence',
        value: '',
      ));
    });
  }

  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition>
      gramsEquivalentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'gramsEquivalent',
      ));
    });
  }

  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition>
      gramsEquivalentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'gramsEquivalent',
      ));
    });
  }

  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition>
      gramsEquivalentEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gramsEquivalent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition>
      gramsEquivalentGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gramsEquivalent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition>
      gramsEquivalentLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gramsEquivalent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition>
      gramsEquivalentBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gramsEquivalent',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition>
      labelEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition>
      labelGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition>
      labelLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition>
      labelBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'label',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition>
      labelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition>
      labelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition>
      labelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition>
      labelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'label',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition>
      labelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'label',
        value: '',
      ));
    });
  }

  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition>
      labelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'label',
        value: '',
      ));
    });
  }

  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition>
      quantityEqualTo(
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

  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition>
      quantityGreaterThan(
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

  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition>
      quantityLessThan(
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

  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition>
      quantityBetween(
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

  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition> unitEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition>
      unitGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition>
      unitLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition> unitBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition>
      unitStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition>
      unitEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition>
      unitContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition> unitMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'unit',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition>
      unitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unit',
        value: '',
      ));
    });
  }

  QueryBuilder<ServingPreset, ServingPreset, QAfterFilterCondition>
      unitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'unit',
        value: '',
      ));
    });
  }
}

extension ServingPresetQueryObject
    on QueryBuilder<ServingPreset, ServingPreset, QFilterCondition> {}
