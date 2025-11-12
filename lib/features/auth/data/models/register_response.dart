import 'package:json_annotation/json_annotation.dart';
import 'package:non_stop/features/auth/data/models/login_response.dart';

part 'register_response.g.dart';

@JsonSerializable(explicitToJson: true)
class RegisterResponse {
  RegisterResponse({
    this.code,
    this.message,
    this.errors,
    this.data,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);

  final int? code;
  final String? message;
  final List<dynamic>? errors;
  final RegisterResponseData? data;

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RegisterResponseData {
  RegisterResponseData({
    this.user,
    this.otp,
  });

  factory RegisterResponseData.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseDataFromJson(json);

  final LoginUser? user;
  final String? otp;

  Map<String, dynamic> toJson() => _$RegisterResponseDataToJson(this);
}

