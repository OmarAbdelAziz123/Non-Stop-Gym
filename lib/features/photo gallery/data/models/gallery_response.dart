import 'package:json_annotation/json_annotation.dart';

part 'gallery_response.g.dart';

@JsonSerializable(explicitToJson: true)
class GalleryResponse {
  GalleryResponse({
    this.code,
    this.message,
    this.errors,
    this.data,
  });

  factory GalleryResponse.fromJson(Map<String, dynamic> json) =>
      _$GalleryResponseFromJson(json);

  final int? code;
  final String? message;
  final List<dynamic>? errors;
  final GalleryData? data;

  Map<String, dynamic> toJson() => _$GalleryResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GalleryData {
  GalleryData({
    this.items,
    this.pagination,
  });

  factory GalleryData.fromJson(Map<String, dynamic> json) =>
      _$GalleryDataFromJson(json);

  final List<GalleryItemModel>? items;
  final PaginationModel? pagination;

  Map<String, dynamic> toJson() => _$GalleryDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GalleryItemModel {
  GalleryItemModel({
    this.id,
    this.image,
    this.comment,
    this.user,
    this.createdAt,
  });

  factory GalleryItemModel.fromJson(Map<String, dynamic> json) =>
      _$GalleryItemModelFromJson(json);

  final int? id;
  final String? image;
  final String? comment;
  final GalleryUserModel? user;
  @JsonKey(name: 'created_at')
  final String? createdAt;

  Map<String, dynamic> toJson() => _$GalleryItemModelToJson(this);
}

@JsonSerializable()
class GalleryUserModel {
  GalleryUserModel({
    this.id,
    this.name,
    this.countryCode,
    this.phone,
    this.email,
    this.image,
    this.gender,
    this.genderLabel,
    this.isCompleteRegisteration,
    this.activeBookingsCount,
    this.finishedBookingsCount,
  });

  factory GalleryUserModel.fromJson(Map<String, dynamic> json) =>
      _$GalleryUserModelFromJson(json);

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
  final bool? isCompleteRegisteration;
  @JsonKey(name: 'active_bookings_count')
  final int? activeBookingsCount;
  @JsonKey(name: 'finished_bookings_count')
  final int? finishedBookingsCount;

  Map<String, dynamic> toJson() => _$GalleryUserModelToJson(this);
}

@JsonSerializable()
class PaginationModel {
  PaginationModel({
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
    this.from,
    this.to,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationModelFromJson(json);

  final int? total;
  @JsonKey(name: 'per_page')
  final int? perPage;
  @JsonKey(name: 'current_page')
  final int? currentPage;
  @JsonKey(name: 'last_page')
  final int? lastPage;
  final int? from;
  final int? to;

  Map<String, dynamic> toJson() => _$PaginationModelToJson(this);
}

