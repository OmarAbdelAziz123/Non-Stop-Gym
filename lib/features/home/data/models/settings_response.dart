import 'package:json_annotation/json_annotation.dart';

part 'settings_response.g.dart';

@JsonSerializable(explicitToJson: true)
class SettingsResponse {
  SettingsResponse({
    this.code,
    this.message,
    this.errors,
    this.data,
  });

  factory SettingsResponse.fromJson(Map<String, dynamic> json) =>
      _$SettingsResponseFromJson(json);

  final int? code;
  final String? message;
  final List<dynamic>? errors;
  final SettingsData? data;

  Map<String, dynamic> toJson() => _$SettingsResponseToJson(this);
}

@JsonSerializable()
class SettingsData {
  SettingsData({
    this.phone,
    this.email,
    this.xLink,
    this.facebookLink,
    this.instagramLink,
    this.whatsappLink,
    this.aboutUs,
    this.ourVision,
    this.ourValues,
    this.ourGoals,
  });

  factory SettingsData.fromJson(Map<String, dynamic> json) =>
      _$SettingsDataFromJson(json);

  @JsonKey(name: 'phone')
  final String? phone;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'x_link')
  final String? xLink;

  @JsonKey(name: 'facebook_link')
  final String? facebookLink;

  @JsonKey(name: 'instagram_link')
  final String? instagramLink;

  @JsonKey(name: 'whatsapp_link')
  final String? whatsappLink;

  @JsonKey(name: 'about_us')
  final String? aboutUs;

  @JsonKey(name: 'our_vision')
  final String? ourVision;

  @JsonKey(name: 'our_values')
  final String? ourValues;

  @JsonKey(name: 'our_goals')
  final String? ourGoals;

  Map<String, dynamic> toJson() => _$SettingsDataToJson(this);
}

