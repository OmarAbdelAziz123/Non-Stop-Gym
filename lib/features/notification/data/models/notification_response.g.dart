// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationResponse _$NotificationResponseFromJson(Map<String, dynamic> json) =>
    NotificationResponse(
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      errors: json['errors'] as List<dynamic>?,
      data: json['data'] == null
          ? null
          : NotificationData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NotificationResponseToJson(NotificationResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data?.toJson(),
    };

NotificationData _$NotificationDataFromJson(Map<String, dynamic> json) => NotificationData(
  items: (json['items'] as List<dynamic>?)
      ?.map((e) => NotificationItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  pagination: json['pagination'] == null
      ? null
      : PaginationModel.fromJson(json['pagination'] as Map<String, dynamic>),
);

Map<String, dynamic> _$NotificationDataToJson(NotificationData instance) =>
    <String, dynamic>{
      'items': instance.items?.map((e) => e.toJson()).toList(),
      'pagination': instance.pagination?.toJson(),
    };

NotificationItem _$NotificationItemFromJson(Map<String, dynamic> json) =>
    NotificationItem(
      id: json['id'] as String?,
      title: json['title'] as String?,
      body: json['body'] as String?,
      isRead: json['is_read'] as bool?,
      readAt: json['read_at'] as String?,
      createdAt: json['created_at'] as String?,
      timeAgo: json['time_ago'] as String?,
    );

Map<String, dynamic> _$NotificationItemToJson(NotificationItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'is_read': instance.isRead,
      'read_at': instance.readAt,
      'created_at': instance.createdAt,
      'time_ago': instance.timeAgo,
    };

PaginationModel _$PaginationModelFromJson(Map<String, dynamic> json) =>
    PaginationModel(
      total: (json['total'] as num?)?.toInt(),
      perPage: (json['per_page'] as num?)?.toInt(),
      currentPage: (json['current_page'] as num?)?.toInt(),
      lastPage: (json['last_page'] as num?)?.toInt(),
      from: (json['from'] as num?)?.toInt(),
      to: (json['to'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PaginationModelToJson(PaginationModel instance) =>
    <String, dynamic>{
      'total': instance.total,
      'per_page': instance.perPage,
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
      'from': instance.from,
      'to': instance.to,
    };

