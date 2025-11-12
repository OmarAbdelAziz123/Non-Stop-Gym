import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginResponse {
  LoginResponse({
    this.code,
    this.message,
    this.errors,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  final int? code;
  final String? message;
  final List<dynamic>? errors;
  final LoginResponseData? data;

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LoginResponseData {
  LoginResponseData({
    this.user,
    this.requiresCompletion,
    this.token,
  });

  factory LoginResponseData.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDataFromJson(json);

  final LoginUser? user;
  @JsonKey(name: 'requires_completion')
  final bool? requiresCompletion;
  final String? token;

  Map<String, dynamic> toJson() => _$LoginResponseDataToJson(this);
}

@JsonSerializable()
class LoginUser {
  LoginUser({
    this.id,
    this.name,
    this.countryCode,
    this.phone,
    this.email,
    this.image,
    this.gender,
    this.genderLabel,
    this.isCompleteRegistration,
    this.activeBookingsCount,
    this.finishedBookingsCount,
  });

  factory LoginUser.fromJson(Map<String, dynamic> json) =>
      _$LoginUserFromJson(json);

  final int? id;
  final String? name;
  @JsonKey(name: 'country_code')
  final String? countryCode;
  final String? phone;
  final String? email;
  final String? image;
  final String? gender;
  @JsonKey(name: 'gender_label')
  final String? genderLabel;
  @JsonKey(name: 'is_complete_registeration')
  final bool? isCompleteRegistration;
  @JsonKey(name: 'active_bookings_count')
  final int? activeBookingsCount;
  @JsonKey(name: 'finished_bookings_count')
  final int? finishedBookingsCount;

  Map<String, dynamic> toJson() => _$LoginUserToJson(this);
}

