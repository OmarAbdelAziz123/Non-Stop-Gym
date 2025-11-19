// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gallery_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GalleryResponse _$GalleryResponseFromJson(Map<String, dynamic> json) =>
    GalleryResponse(
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      errors: json['errors'] as List<dynamic>?,
      data: json['data'] == null
          ? null
          : GalleryData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GalleryResponseToJson(GalleryResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data?.toJson(),
    };

GalleryData _$GalleryDataFromJson(Map<String, dynamic> json) => GalleryData(
  items: (json['items'] as List<dynamic>?)
      ?.map((e) => GalleryItemModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  pagination: json['pagination'] == null
      ? null
      : PaginationModel.fromJson(json['pagination'] as Map<String, dynamic>),
);

Map<String, dynamic> _$GalleryDataToJson(GalleryData instance) =>
    <String, dynamic>{
      'items': instance.items?.map((e) => e.toJson()).toList(),
      'pagination': instance.pagination?.toJson(),
    };

GalleryItemModel _$GalleryItemModelFromJson(Map<String, dynamic> json) =>
    GalleryItemModel(
      id: (json['id'] as num?)?.toInt(),
      image: json['image'] as String?,
      comment: json['comment'] as String?,
      user: json['user'] == null
          ? null
          : GalleryUserModel.fromJson(json['user'] as Map<String, dynamic>),
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$GalleryItemModelToJson(GalleryItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'comment': instance.comment,
      'user': instance.user?.toJson(),
      'created_at': instance.createdAt,
    };

GalleryUserModel _$GalleryUserModelFromJson(Map<String, dynamic> json) =>
    GalleryUserModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      countryCode: json['country_code'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      image: json['image'] as String?,
      gender: json['gender'] as String?,
      genderLabel: json['gender_label'] as String?,
      isCompleteRegisteration: json['is_complete_registeration'] as bool?,
      activeBookingsCount: (json['active_bookings_count'] as num?)?.toInt(),
      finishedBookingsCount: (json['finished_bookings_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GalleryUserModelToJson(GalleryUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'country_code': instance.countryCode,
      'phone': instance.phone,
      'email': instance.email,
      'image': instance.image,
      'gender': instance.gender,
      'gender_label': instance.genderLabel,
      'is_complete_registeration': instance.isCompleteRegisteration,
      'active_bookings_count': instance.activeBookingsCount,
      'finished_bookings_count': instance.finishedBookingsCount,
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
