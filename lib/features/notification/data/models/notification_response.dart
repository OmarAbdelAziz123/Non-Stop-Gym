import 'package:json_annotation/json_annotation.dart';

part 'notification_response.g.dart';

@JsonSerializable(explicitToJson: true)
class NotificationResponse {
  NotificationResponse({
    this.code,
    this.message,
    this.errors,
    this.data,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseFromJson(json);

  final int? code;
  final String? message;
  final List<dynamic>? errors;
  final NotificationData? data;

  Map<String, dynamic> toJson() => _$NotificationResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NotificationData {
  NotificationData({
    this.items,
    this.pagination,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataFromJson(json);

  final List<NotificationItem>? items;
  final PaginationModel? pagination;

  Map<String, dynamic> toJson() => _$NotificationDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NotificationItem {
  NotificationItem({
    this.id,
    this.title,
    this.body,
    this.isRead,
    this.readAt,
    this.createdAt,
    this.timeAgo,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) =>
      _$NotificationItemFromJson(json);

  final String? id;
  final String? title;
  final String? body;
  @JsonKey(name: 'is_read')
  final bool? isRead;
  @JsonKey(name: 'read_at')
  final String? readAt;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'time_ago')
  final String? timeAgo;

  Map<String, dynamic> toJson() => _$NotificationItemToJson(this);
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

