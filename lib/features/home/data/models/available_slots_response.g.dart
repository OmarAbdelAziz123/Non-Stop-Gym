// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_slots_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvailableSlotsResponse _$AvailableSlotsResponseFromJson(
  Map<String, dynamic> json,
) => AvailableSlotsResponse(
  success: json['success'] as bool?,
  message: json['message'] as String?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => AvailableSlotModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AvailableSlotsResponseToJson(
  AvailableSlotsResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};

AvailableSlotModel _$AvailableSlotModelFromJson(Map<String, dynamic> json) =>
    AvailableSlotModel(
      id: (json['id'] as num?)?.toInt(),
      date: json['date'] as String?,
      time: json['time'] as String?,
      formattedDateTime: json['formatted_date_time'] as String?,
    );

Map<String, dynamic> _$AvailableSlotModelToJson(AvailableSlotModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'time': instance.time,
      'formatted_date_time': instance.formattedDateTime,
    };
