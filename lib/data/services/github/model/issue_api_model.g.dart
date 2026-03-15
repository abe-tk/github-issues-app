// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IssueApiModel _$IssueApiModelFromJson(Map<String, dynamic> json) =>
    _IssueApiModel(
      number: (json['number'] as num).toInt(),
      title: json['title'] as String,
      state: json['state'] as String,
      body: json['body'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$IssueApiModelToJson(_IssueApiModel instance) =>
    <String, dynamic>{
      'number': instance.number,
      'title': instance.title,
      'state': instance.state,
      'body': instance.body,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
