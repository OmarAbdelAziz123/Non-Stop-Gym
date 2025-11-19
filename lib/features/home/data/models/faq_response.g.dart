// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faq_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaqResponse _$FaqResponseFromJson(Map<String, dynamic> json) => FaqResponse(
  code: (json['code'] as num?)?.toInt(),
  message: json['message'] as String?,
  errors: json['errors'] as List<dynamic>?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => FaqModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$FaqResponseToJson(FaqResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };

FaqModel _$FaqModelFromJson(Map<String, dynamic> json) => FaqModel(
  question: json['question'] as String?,
  answer: json['answer'] as String?,
);

Map<String, dynamic> _$FaqModelToJson(FaqModel instance) => <String, dynamic>{
  'question': instance.question,
  'answer': instance.answer,
};
