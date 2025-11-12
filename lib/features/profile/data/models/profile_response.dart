import 'package:json_annotation/json_annotation.dart';

part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse {
  ProfileResponse({
    this.code,
    this.message,
    this.errors,
    this.data,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);

  final int? code;
  final String? message;
  final List<dynamic>? errors;
  final ProfileData? data;

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}

@JsonSerializable()
class ProfileData {
  ProfileData({
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

  factory ProfileData.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataFromJson(json);

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

  Map<String, dynamic> toJson() => _$ProfileDataToJson(this);
}

