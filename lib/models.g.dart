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

ProductItem _$ProductItemFromJson(Map json) {
  return ProductItem(
    id: json['id'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    offerPrice: json['offerPrice'] as int,
    price: json['price'] as int,
    url: json['url'] as String,
    media: json['media'] == null
        ? null
        : ProductMedia.fromJson((json['media'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
    features: (json['features'] as List)
        ?.map((e) => e == null
            ? null
            : ProductFeature.fromJson((e as Map)?.map(
                (k, e) => MapEntry(k as String, e),
              )))
        ?.toList(),
    spec: (json['spec'] as List)
        ?.map((e) => e == null
            ? null
            : ProductSpec.fromJson((e as Map)?.map(
                (k, e) => MapEntry(k as String, e),
              )))
        ?.toList(),
  );
}

Map<String, dynamic> _$ProductItemToJson(ProductItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'offerPrice': instance.offerPrice,
      'price': instance.price,
      'url': instance.url,
      'spec': instance.spec?.map((e) => e?.toJson())?.toList(),
      'features': instance.features?.map((e) => e?.toJson())?.toList(),
      'media': instance.media?.toJson(),
    };

ProductSpec _$ProductSpecFromJson(Map json) {
  return ProductSpec(
    title: json['title'] as String,
    desc: json['desc'] as String,
  );
}

Map<String, dynamic> _$ProductSpecToJson(ProductSpec instance) =>
    <String, dynamic>{
      'title': instance.title,
      'desc': instance.desc,
    };

ProductFeature _$ProductFeatureFromJson(Map json) {
  return ProductFeature(
    title: json['title'] as String,
    desc: json['desc'] as String,
  );
}

Map<String, dynamic> _$ProductFeatureToJson(ProductFeature instance) =>
    <String, dynamic>{
      'title': instance.title,
      'desc': instance.desc,
    };

ProductMedia _$ProductMediaFromJson(Map json) {
  return ProductMedia(
    images: (json['images'] as List)?.map((e) => e as String)?.toList(),
    videos: (json['videos'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ProductMediaToJson(ProductMedia instance) =>
    <String, dynamic>{
      'images': instance.images,
      'videos': instance.videos,
    };

ProductVariants _$ProductVariantsFromJson(Map json) {
  return ProductVariants(
    name: json['name'] as String,
    id: json['id'] as String,
    image: json['image'] as String,
    subTitle: json['subTitle'] as String,
    backgroundColor: json['backgroundColor'] as String,
  );
}

Map<String, dynamic> _$ProductVariantsToJson(ProductVariants instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'image': instance.image,
      'subTitle': instance.subTitle,
      'backgroundColor': instance.backgroundColor,
    };
