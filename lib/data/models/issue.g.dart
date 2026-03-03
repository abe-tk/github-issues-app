// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Issue _$IssueFromJson(Map<String, dynamic> json) => _Issue(
  id: (json['id'] as num).toInt(),
  number: (json['number'] as num).toInt(),
  title: json['title'] as String,
  body: json['body'] as String?,
  state: json['state'] as String,
  user: User.fromJson(json['user'] as Map<String, dynamic>),
  labels: (json['labels'] as List<dynamic>?)
      ?.map((e) => Label.fromJson(e as Map<String, dynamic>))
      .toList(),
  assignee: json['assignee'] == null
      ? null
      : User.fromJson(json['assignee'] as Map<String, dynamic>),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
  closedAt: json['closed_at'] == null
      ? null
      : DateTime.parse(json['closed_at'] as String),
  htmlUrl: json['html_url'] as String,
  commentsUrl: json['comments_url'] as String,
  comments: (json['comments'] as num?)?.toInt(),
);

Map<String, dynamic> _$IssueToJson(_Issue instance) => <String, dynamic>{
  'id': instance.id,
  'number': instance.number,
  'title': instance.title,
  'body': instance.body,
  'state': instance.state,
  'user': instance.user,
  'labels': instance.labels,
  'assignee': instance.assignee,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
  'closed_at': instance.closedAt?.toIso8601String(),
  'html_url': instance.htmlUrl,
  'comments_url': instance.commentsUrl,
  'comments': instance.comments,
};

_IssueRequest _$IssueRequestFromJson(Map<String, dynamic> json) =>
    _IssueRequest(
      title: json['title'] as String,
      body: json['body'] as String?,
      assignees: (json['assignees'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      labels: (json['labels'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      state: json['state'] as String?,
    );

Map<String, dynamic> _$IssueRequestToJson(_IssueRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': ?instance.body,
      'assignees': ?instance.assignees,
      'labels': ?instance.labels,
      'state': ?instance.state,
    };
