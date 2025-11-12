// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      errors: json['errors'] as List<dynamic>?,
      data: json['data'] == null
          ? null
          : LoginResponseData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data?.toJson(),
    };

LoginResponseData _$LoginResponseDataFromJson(Map<String, dynamic> json) =>
    LoginResponseData(
      user: json['user'] == null
          ? null
          : LoginUser.fromJson(json['user'] as Map<String, dynamic>),
      requiresCompletion: json['requires_completion'] as bool?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$LoginResponseDataToJson(LoginResponseData instance) =>
    <String, dynamic>{
      'user': instance.user?.toJson(),
      'requires_completion': instance.requiresCompletion,
      'token': instance.token,
    };

LoginUser _$LoginUserFromJson(Map<String, dynamic> json) => LoginUser(
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

Map<String, dynamic> _$LoginUserToJson(LoginUser instance) => <String, dynamic>{
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
