import 'package:json_annotation/json_annotation.dart';

part 'faq_response.g.dart';

@JsonSerializable(explicitToJson: true)
class FaqResponse {
  FaqResponse({
    this.code,
    this.message,
    this.errors,
    this.data,
  });

  factory FaqResponse.fromJson(Map<String, dynamic> json) =>
      _$FaqResponseFromJson(json);

  final int? code;
  final String? message;
  final List<dynamic>? errors;
  final List<FaqModel>? data;

  Map<String, dynamic> toJson() => _$FaqResponseToJson(this);
}

@JsonSerializable()
class FaqModel {
  FaqModel({
    this.question,
    this.answer,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) =>
      _$FaqModelFromJson(json);

  final String? question;
  final String? answer;

  Map<String, dynamic> toJson() => _$FaqModelToJson(this);
}

