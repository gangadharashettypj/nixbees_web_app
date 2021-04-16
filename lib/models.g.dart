// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentModel _$PaymentModelFromJson(Map json) {
  return PaymentModel(
    orderAmount: json['orderAmount'] as String,
    customerName: json['customerName'] as String,
    customerPhone: json['customerPhone'] as String,
    customerEmail: json['customerEmail'] as String,
    orderNote: json['orderNote'] as String,
    stage: _$enumDecodeNullable(_$PaymentModeEnumMap, json['stage']),
  );
}

Map<String, dynamic> _$PaymentModelToJson(PaymentModel instance) =>
    <String, dynamic>{
      'orderAmount': instance.orderAmount,
      'customerName': instance.customerName,
      'customerPhone': instance.customerPhone,
      'customerEmail': instance.customerEmail,
      'orderNote': instance.orderNote,
      'stage': _$PaymentModeEnumMap[instance.stage],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$PaymentModeEnumMap = {
  PaymentMode.test: 'TEST',
  PaymentMode.prod: 'PROD',
};
