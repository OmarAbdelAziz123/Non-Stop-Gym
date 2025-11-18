// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingResponse _$BookingResponseFromJson(Map<String, dynamic> json) =>
    BookingResponse(
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      errors: json['errors'] as List<dynamic>?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => BookingModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookingResponseToJson(BookingResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };

BookingModel _$BookingModelFromJson(Map<String, dynamic> json) => BookingModel(
  id: (json['id'] as num?)?.toInt(),
  bookingDate: json['booking_date'] == null
      ? null
      : BookingDateModel.fromJson(json['booking_date'] as Map<String, dynamic>),
  isFinished: json['is_finished'] as bool?,
  status: json['status'] as String?,
  bookedAt: json['booked_at'] as String?,
  createdAt: json['created_at'] as String?,
);

Map<String, dynamic> _$BookingModelToJson(BookingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'booking_date': instance.bookingDate?.toJson(),
      'is_finished': instance.isFinished,
      'status': instance.status,
      'booked_at': instance.bookedAt,
      'created_at': instance.createdAt,
    };

BookingDateModel _$BookingDateModelFromJson(Map<String, dynamic> json) =>
    BookingDateModel(
      id: (json['id'] as num?)?.toInt(),
      date: json['date'] as String?,
      time: json['time'] as String?,
      formattedDateTime: json['formatted_date_time'] as String?,
    );

Map<String, dynamic> _$BookingDateModelToJson(BookingDateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'time': instance.time,
      'formatted_date_time': instance.formattedDateTime,
    };
