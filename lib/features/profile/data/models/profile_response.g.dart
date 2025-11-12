// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileResponse _$ProfileResponseFromJson(Map<String, dynamic> json) =>
    ProfileResponse(
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      errors: json['errors'] as List<dynamic>?,
      data: json['data'] == null
          ? null
          : ProfileData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileResponseToJson(ProfileResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };

ProfileData _$ProfileDataFromJson(Map<String, dynamic> json) => ProfileData(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  countryCode: json['country_code'] as String?,
  phone: json['phone'] as String?,
  email: json['email'] as String?,
  image: json['image'] as String?,
  gender: json['gender'] as String?,
  genderLabel: json['gender_label'] as String?,
  isCompleteRegistration: json['is_complete_registeration'] as bool?,
  activeBookingsCount: (json['active_bookings_count'] as num?)?.toInt(),
  finishedBookingsCount: (json['finished_bookings_count'] as num?)?.toInt(),
);

Map<String, dynamic> _$ProfileDataToJson(ProfileData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'country_code': instance.countryCode,
      'phone': instance.phone,
      'email': instance.email,
      'image': instance.image,
      'gender': instance.gender,
      'gender_label': instance.genderLabel,
      'is_complete_registeration': instance.isCompleteRegistration,
      'active_bookings_count': instance.activeBookingsCount,
      'finished_bookings_count': instance.finishedBookingsCount,
    };
