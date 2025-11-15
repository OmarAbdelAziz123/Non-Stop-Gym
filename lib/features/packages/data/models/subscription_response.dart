import 'package:json_annotation/json_annotation.dart';

part 'subscription_response.g.dart';

@JsonSerializable(explicitToJson: true)
class SubscriptionResponse {
  SubscriptionResponse({
    this.code,
    this.message,
    this.errors,
    this.data,
  });

  factory SubscriptionResponse.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionResponseFromJson(json);

  final int? code;
  final String? message;
  final List<dynamic>? errors;
  final List<SubscriptionModel>? data;

  Map<String, dynamic> toJson() => _$SubscriptionResponseToJson(this);
}

@JsonSerializable()
class SubscriptionModel {
  SubscriptionModel({
    this.id,
    this.title,
    this.price,
    this.discountType,
    this.discountTypeLabel,
    this.discountAmount,
    this.priceAfterDiscount,
    this.type,
    this.typeLabel,
    this.typeAmount,
    this.benefits,
    this.subscriptionIconType,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionModelFromJson(json);

  final int? id;
  final String? title;
  final double? price;
  @JsonKey(name: 'discount_type')
  final String? discountType;
  @JsonKey(name: 'discount_type_label')
  final String? discountTypeLabel;
  @JsonKey(name: 'discount_amount')
  final double? discountAmount;
  @JsonKey(name: 'price_after_discount')
  final double? priceAfterDiscount;
  final String? type;
  @JsonKey(name: 'type_label')
  final String? typeLabel;
  @JsonKey(name: 'type_amount')
  final int? typeAmount;
  final String? benefits;
  @JsonKey(name: 'subscription_icon_type')
  final String? subscriptionIconType;

  Map<String, dynamic> toJson() => _$SubscriptionModelToJson(this);
}

