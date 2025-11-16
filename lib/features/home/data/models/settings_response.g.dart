// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsResponse _$SettingsResponseFromJson(Map<String, dynamic> json) =>
    SettingsResponse(
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      errors: json['errors'] as List<dynamic>?,
      data: json['data'] == null
          ? null
          : SettingsData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SettingsResponseToJson(SettingsResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data?.toJson(),
    };

SettingsData _$SettingsDataFromJson(Map<String, dynamic> json) => SettingsData(
  phone: json['phone'] as String?,
  email: json['email'] as String?,
  xLink: json['x_link'] as String?,
  facebookLink: json['facebook_link'] as String?,
  instagramLink: json['instagram_link'] as String?,
  whatsappLink: json['whatsapp_link'] as String?,
  aboutUs: json['about_us'] as String?,
  ourVision: json['our_vision'] as String?,
  ourValues: json['our_values'] as String?,
  ourGoals: json['our_goals'] as String?,
);

Map<String, dynamic> _$SettingsDataToJson(SettingsData instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'email': instance.email,
      'x_link': instance.xLink,
      'facebook_link': instance.facebookLink,
      'instagram_link': instance.instagramLink,
      'whatsapp_link': instance.whatsappLink,
      'about_us': instance.aboutUs,
      'our_vision': instance.ourVision,
      'our_values': instance.ourValues,
      'our_goals': instance.ourGoals,
    };
