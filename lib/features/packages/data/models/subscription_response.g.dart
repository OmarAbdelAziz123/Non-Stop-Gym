// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionResponse _$SubscriptionResponseFromJson(
  Map<String, dynamic> json,
) => SubscriptionResponse(
  code: (json['code'] as num?)?.toInt(),
  message: json['message'] as String?,
  errors: json['errors'] as List<dynamic>?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => SubscriptionModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SubscriptionResponseToJson(
  SubscriptionResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'message': instance.message,
  'errors': instance.errors,
  'data': instance.data?.map((e) => e.toJson()).toList(),
};

SubscriptionModel _$SubscriptionModelFromJson(Map<String, dynamic> json) =>
    SubscriptionModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      discountType: json['discount_type'] as String?,
      discountTypeLabel: json['discount_type_label'] as String?,
      discountAmount: (json['discount_amount'] as num?)?.toDouble(),
      priceAfterDiscount: (json['price_after_discount'] as num?)?.toDouble(),
      type: json['type'] as String?,
      typeLabel: json['type_label'] as String?,
      typeAmount: (json['type_amount'] as num?)?.toInt(),
      benefits: json['benefits'] as String?,
      subscriptionIconType: json['subscription_icon_type'] as String?,
    );

Map<String, dynamic> _$SubscriptionModelToJson(SubscriptionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'discount_type': instance.discountType,
      'discount_type_label': instance.discountTypeLabel,
      'discount_amount': instance.discountAmount,
      'price_after_discount': instance.priceAfterDiscount,
      'type': instance.type,
      'type_label': instance.typeLabel,
      'type_amount': instance.typeAmount,
      'benefits': instance.benefits,
      'subscription_icon_type': instance.subscriptionIconType,
    };
