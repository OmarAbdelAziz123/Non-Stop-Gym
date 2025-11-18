import 'package:json_annotation/json_annotation.dart';

part 'booking_response.g.dart';

@JsonSerializable(explicitToJson: true)
class BookingResponse {
  BookingResponse({
    this.code,
    this.message,
    this.errors,
    this.data,
  });

  factory BookingResponse.fromJson(Map<String, dynamic> json) =>
      _$BookingResponseFromJson(json);

  final int? code;
  final String? message;
  final List<dynamic>? errors;
  final List<BookingModel>? data;

  Map<String, dynamic> toJson() => _$BookingResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BookingModel {
  BookingModel({
    this.id,
    this.bookingDate,
    this.isFinished,
    this.status,
    this.bookedAt,
    this.createdAt,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) =>
      _$BookingModelFromJson(json);

  final int? id;
  @JsonKey(name: 'booking_date')
  final BookingDateModel? bookingDate;
  @JsonKey(name: 'is_finished')
  final bool? isFinished;
  final String? status;
  @JsonKey(name: 'booked_at')
  final String? bookedAt;
  @JsonKey(name: 'created_at')
  final String? createdAt;

  Map<String, dynamic> toJson() => _$BookingModelToJson(this);
}

@JsonSerializable()
class BookingDateModel {
  BookingDateModel({
    this.id,
    this.date,
    this.time,
    this.formattedDateTime,
  });

  factory BookingDateModel.fromJson(Map<String, dynamic> json) =>
      _$BookingDateModelFromJson(json);

  final int? id;
  final String? date;
  final String? time;
  @JsonKey(name: 'formatted_date_time')
  final String? formattedDateTime;

  Map<String, dynamic> toJson() => _$BookingDateModelToJson(this);
}

