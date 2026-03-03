// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'label.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Label _$LabelFromJson(Map<String, dynamic> json) => _Label(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  color: json['color'] as String,
  description: json['description'] as String?,
);

Map<String, dynamic> _$LabelToJson(_Label instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'color': instance.color,
  'description': instance.description,
};
