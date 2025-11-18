import 'package:json_annotation/json_annotation.dart';

part 'available_slots_response.g.dart';

@JsonSerializable()
class AvailableSlotsResponse {
  AvailableSlotsResponse({
    this.success,
    this.message,
    this.data,
  });

  factory AvailableSlotsResponse.fromJson(Map<String, dynamic> json) =>
      _$AvailableSlotsResponseFromJson(json);

  final bool? success;
  final String? message;
  final List<AvailableSlotModel>? data;

  Map<String, dynamic> toJson() => _$AvailableSlotsResponseToJson(this);
}

@JsonSerializable()
class AvailableSlotModel {
  AvailableSlotModel({
    this.id,
    this.date,
    this.time,
    this.formattedDateTime,
  });

  factory AvailableSlotModel.fromJson(Map<String, dynamic> json) =>
      _$AvailableSlotModelFromJson(json);

  final int? id;
  final String? date;
  final String? time;
  @JsonKey(name: 'formatted_date_time')
  final String? formattedDateTime;

  Map<String, dynamic> toJson() => _$AvailableSlotModelToJson(this);
}

