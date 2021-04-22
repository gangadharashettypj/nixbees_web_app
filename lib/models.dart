import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

enum PaymentMode {
  @JsonValue("TEST")
  test,
  @JsonValue("PROD")
  prod,
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class PaymentModel {
  String orderAmount;
  String customerName;
  String customerPhone;
  String customerEmail;
  String orderNote;
  PaymentMode stage;

  PaymentModel({
    this.orderAmount,
    this.customerName,
    this.customerPhone,
    this.customerEmail,
    this.orderNote,
    this.stage,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentModelToJson(this);
  String toJsonString() => jsonEncode(_$PaymentModelToJson(this));
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class ProductItem {
  String id;
  String name;
  String description;
  int offerPrice;
  int price;
  String url;
  List<ProductSpec> spec;
  List<ProductFeature> features;
  ProductMedia media;

  ProductItem({
    this.id,
    this.name,
    this.description,
    this.offerPrice,
    this.price,
    this.url,
    this.media,
    this.features,
    this.spec,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) =>
      _$ProductItemFromJson(json);

  Map<String, dynamic> toJson() => _$ProductItemToJson(this);
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class ProductSpec {
  String title;
  String desc;

  ProductSpec({
    this.title,
    this.desc,
  });

  factory ProductSpec.fromJson(Map<String, dynamic> json) =>
      _$ProductSpecFromJson(json);

  Map<String, dynamic> toJson() => _$ProductSpecToJson(this);
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class ProductFeature {
  String title;
  String desc;

  ProductFeature({
    this.title,
    this.desc,
  });

  factory ProductFeature.fromJson(Map<String, dynamic> json) =>
      _$ProductFeatureFromJson(json);

  Map<String, dynamic> toJson() => _$ProductFeatureToJson(this);
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class ProductMedia {
  List<String> images;
  List<String> videos;

  ProductMedia({
    this.images,
    this.videos,
  });

  factory ProductMedia.fromJson(Map<String, dynamic> json) =>
      _$ProductMediaFromJson(json);

  Map<String, dynamic> toJson() => _$ProductMediaToJson(this);
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class ProductVariants {
  String name;
  String id;
  String image;
  String subTitle;
  String backgroundColor;

  ProductVariants({
    this.name,
    this.id,
    this.image,
    this.subTitle,
    this.backgroundColor,
  });

  factory ProductVariants.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantsFromJson(json);

  Map<String, dynamic> toJson() => _$ProductVariantsToJson(this);
}
