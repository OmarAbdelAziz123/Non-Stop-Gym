// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_subscription_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSubscriptionResponse _$UserSubscriptionResponseFromJson(
  Map<String, dynamic> json,
) => UserSubscriptionResponse(
  code: (json['code'] as num?)?.toInt(),
  message: json['message'] as String?,
  errors: json['errors'] as List<dynamic>?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => UserSubscriptionModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$UserSubscriptionResponseToJson(
  UserSubscriptionResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'message': instance.message,
  'errors': instance.errors,
  'data': instance.data?.map((e) => e.toJson()).toList(),
};

UserSubscriptionModel _$UserSubscriptionModelFromJson(
  Map<String, dynamic> json,
) => UserSubscriptionModel(
  id: (json['id'] as num?)?.toInt(),
  status: json['status'] as String?,
  statusLabel: json['status_label'] as String?,
  paidAmount: (json['paid_amount'] as num?)?.toDouble(),
  originalPrice: (json['original_price'] as num?)?.toDouble(),
  discountAmount: (json['discount_amount'] as num?)?.toDouble(),
  paymentMethod: json['payment_method'] as String?,
  startDate: json['start_date'] as String?,
  endDate: json['end_date'] as String?,
  isExpired: json['is_expired'] as bool?,
  subscription: json['subscription'] == null
      ? null
      : UserSubscriptionDetailModel.fromJson(
          json['subscription'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$UserSubscriptionModelToJson(
  UserSubscriptionModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'status': instance.status,
  'status_label': instance.statusLabel,
  'paid_amount': instance.paidAmount,
  'original_price': instance.originalPrice,
  'discount_amount': instance.discountAmount,
  'payment_method': instance.paymentMethod,
  'start_date': instance.startDate,
  'end_date': instance.endDate,
  'is_expired': instance.isExpired,
  'subscription': instance.subscription?.toJson(),
};

UserSubscriptionDetailModel _$UserSubscriptionDetailModelFromJson(
  Map<String, dynamic> json,
) => UserSubscriptionDetailModel(
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

Map<String, dynamic> _$UserSubscriptionDetailModelToJson(
  UserSubscriptionDetailModel instance,
) => <String, dynamic>{
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
