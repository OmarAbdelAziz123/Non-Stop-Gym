import 'package:json_annotation/json_annotation.dart';

part 'user_subscription_response.g.dart';

@JsonSerializable(explicitToJson: true)
class UserSubscriptionResponse {
  UserSubscriptionResponse({
    this.code,
    this.message,
    this.errors,
    this.data,
  });

  factory UserSubscriptionResponse.fromJson(Map<String, dynamic> json) =>
      _$UserSubscriptionResponseFromJson(json);

  final int? code;
  final String? message;
  final List<dynamic>? errors;
  final List<UserSubscriptionModel>? data;

  Map<String, dynamic> toJson() => _$UserSubscriptionResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserSubscriptionModel {
  UserSubscriptionModel({
    this.id,
    this.status,
    this.statusLabel,
    this.paidAmount,
    this.originalPrice,
    this.discountAmount,
    this.paymentMethod,
    this.startDate,
    this.endDate,
    this.isExpired,
    this.subscription,
  });

  factory UserSubscriptionModel.fromJson(Map<String, dynamic> json) =>
      _$UserSubscriptionModelFromJson(json);

  final int? id;
  final String? status;
  @JsonKey(name: 'status_label')
  final String? statusLabel;
  @JsonKey(name: 'paid_amount')
  final double? paidAmount;
  @JsonKey(name: 'original_price')
  final double? originalPrice;
  @JsonKey(name: 'discount_amount')
  final double? discountAmount;
  @JsonKey(name: 'payment_method')
  final String? paymentMethod;
  @JsonKey(name: 'start_date')
  final String? startDate;
  @JsonKey(name: 'end_date')
  final String? endDate;
  @JsonKey(name: 'is_expired')
  final bool? isExpired;
  final UserSubscriptionDetailModel? subscription;

  Map<String, dynamic> toJson() => _$UserSubscriptionModelToJson(this);
}

@JsonSerializable()
class UserSubscriptionDetailModel {
  UserSubscriptionDetailModel({
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

  factory UserSubscriptionDetailModel.fromJson(Map<String, dynamic> json) =>
      _$UserSubscriptionDetailModelFromJson(json);

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

  Map<String, dynamic> toJson() => _$UserSubscriptionDetailModelToJson(this);
}

