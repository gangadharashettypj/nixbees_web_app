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
