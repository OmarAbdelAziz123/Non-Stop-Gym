import 'package:json_annotation/json_annotation.dart';

part 'banner_response.g.dart';

@JsonSerializable(explicitToJson: true)
class BannerResponse {
  BannerResponse({
    this.code,
    this.message,
    this.errors,
    this.data,
  });

  factory BannerResponse.fromJson(Map<String, dynamic> json) =>
      _$BannerResponseFromJson(json);

  final int? code;
  final String? message;
  final List<dynamic>? errors;
  final List<BannerModel>? data;

  Map<String, dynamic> toJson() => _$BannerResponseToJson(this);
}

@JsonSerializable()
class BannerModel {
  BannerModel({
    this.id,
    this.image,
    this.url,
    this.title,
    this.description,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);

  final int? id;
  final String? image;
  final String? url;
  final String? title;
  final String? description;

  Map<String, dynamic> toJson() => _$BannerModelToJson(this);
}

