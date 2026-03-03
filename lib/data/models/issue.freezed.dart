// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'issue.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Issue {

 int get id; int get number; String get title; String? get body; String get state; User get user; List<Label>? get labels; User? get assignee;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'updated_at') DateTime get updatedAt;@JsonKey(name: 'closed_at') DateTime? get closedAt;@JsonKey(name: 'html_url') String get htmlUrl;@JsonKey(name: 'comments_url') String get commentsUrl; int? get comments;
/// Create a copy of Issue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IssueCopyWith<Issue> get copyWith => _$IssueCopyWithImpl<Issue>(this as Issue, _$identity);

  /// Serializes this Issue to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Issue&&(identical(other.id, id) || other.id == id)&&(identical(other.number, number) || other.number == number)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.state, state) || other.state == state)&&(identical(other.user, user) || other.user == user)&&const DeepCollectionEquality().equals(other.labels, labels)&&(identical(other.assignee, assignee) || other.assignee == assignee)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.closedAt, closedAt) || other.closedAt == closedAt)&&(identical(other.htmlUrl, htmlUrl) || other.htmlUrl == htmlUrl)&&(identical(other.commentsUrl, commentsUrl) || other.commentsUrl == commentsUrl)&&(identical(other.comments, comments) || other.comments == comments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,number,title,body,state,user,const DeepCollectionEquality().hash(labels),assignee,createdAt,updatedAt,closedAt,htmlUrl,commentsUrl,comments);

@override
String toString() {
  return 'Issue(id: $id, number: $number, title: $title, body: $body, state: $state, user: $user, labels: $labels, assignee: $assignee, createdAt: $createdAt, updatedAt: $updatedAt, closedAt: $closedAt, htmlUrl: $htmlUrl, commentsUrl: $commentsUrl, comments: $comments)';
}


}

/// @nodoc
abstract mixin class $IssueCopyWith<$Res>  {
  factory $IssueCopyWith(Issue value, $Res Function(Issue) _then) = _$IssueCopyWithImpl;
@useResult
$Res call({
 int id, int number, String title, String? body, String state, User user, List<Label>? labels, User? assignee,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt,@JsonKey(name: 'closed_at') DateTime? closedAt,@JsonKey(name: 'html_url') String htmlUrl,@JsonKey(name: 'comments_url') String commentsUrl, int? comments
});


$UserCopyWith<$Res> get user;$UserCopyWith<$Res>? get assignee;

}
/// @nodoc
class _$IssueCopyWithImpl<$Res>
    implements $IssueCopyWith<$Res> {
  _$IssueCopyWithImpl(this._self, this._then);

  final Issue _self;
  final $Res Function(Issue) _then;

/// Create a copy of Issue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? number = null,Object? title = null,Object? body = freezed,Object? state = null,Object? user = null,Object? labels = freezed,Object? assignee = freezed,Object? createdAt = null,Object? updatedAt = null,Object? closedAt = freezed,Object? htmlUrl = null,Object? commentsUrl = null,Object? comments = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,labels: freezed == labels ? _self.labels : labels // ignore: cast_nullable_to_non_nullable
as List<Label>?,assignee: freezed == assignee ? _self.assignee : assignee // ignore: cast_nullable_to_non_nullable
as User?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,closedAt: freezed == closedAt ? _self.closedAt : closedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,htmlUrl: null == htmlUrl ? _self.htmlUrl : htmlUrl // ignore: cast_nullable_to_non_nullable
as String,commentsUrl: null == commentsUrl ? _self.commentsUrl : commentsUrl // ignore: cast_nullable_to_non_nullable
as String,comments: freezed == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of Issue
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get user {
  
  return $UserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of Issue
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res>? get assignee {
    if (_self.assignee == null) {
    return null;
  }

  return $UserCopyWith<$Res>(_self.assignee!, (value) {
    return _then(_self.copyWith(assignee: value));
  });
}
}


/// Adds pattern-matching-related methods to [Issue].
extension IssuePatterns on Issue {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Issue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Issue() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Issue value)  $default,){
final _that = this;
switch (_that) {
case _Issue():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Issue value)?  $default,){
final _that = this;
switch (_that) {
case _Issue() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int number,  String title,  String? body,  String state,  User user,  List<Label>? labels,  User? assignee, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt, @JsonKey(name: 'closed_at')  DateTime? closedAt, @JsonKey(name: 'html_url')  String htmlUrl, @JsonKey(name: 'comments_url')  String commentsUrl,  int? comments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Issue() when $default != null:
return $default(_that.id,_that.number,_that.title,_that.body,_that.state,_that.user,_that.labels,_that.assignee,_that.createdAt,_that.updatedAt,_that.closedAt,_that.htmlUrl,_that.commentsUrl,_that.comments);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int number,  String title,  String? body,  String state,  User user,  List<Label>? labels,  User? assignee, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt, @JsonKey(name: 'closed_at')  DateTime? closedAt, @JsonKey(name: 'html_url')  String htmlUrl, @JsonKey(name: 'comments_url')  String commentsUrl,  int? comments)  $default,) {final _that = this;
switch (_that) {
case _Issue():
return $default(_that.id,_that.number,_that.title,_that.body,_that.state,_that.user,_that.labels,_that.assignee,_that.createdAt,_that.updatedAt,_that.closedAt,_that.htmlUrl,_that.commentsUrl,_that.comments);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int number,  String title,  String? body,  String state,  User user,  List<Label>? labels,  User? assignee, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt, @JsonKey(name: 'closed_at')  DateTime? closedAt, @JsonKey(name: 'html_url')  String htmlUrl, @JsonKey(name: 'comments_url')  String commentsUrl,  int? comments)?  $default,) {final _that = this;
switch (_that) {
case _Issue() when $default != null:
return $default(_that.id,_that.number,_that.title,_that.body,_that.state,_that.user,_that.labels,_that.assignee,_that.createdAt,_that.updatedAt,_that.closedAt,_that.htmlUrl,_that.commentsUrl,_that.comments);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Issue implements Issue {
  const _Issue({required this.id, required this.number, required this.title, this.body, required this.state, required this.user, final  List<Label>? labels, this.assignee, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt, @JsonKey(name: 'closed_at') this.closedAt, @JsonKey(name: 'html_url') required this.htmlUrl, @JsonKey(name: 'comments_url') required this.commentsUrl, this.comments}): _labels = labels;
  factory _Issue.fromJson(Map<String, dynamic> json) => _$IssueFromJson(json);

@override final  int id;
@override final  int number;
@override final  String title;
@override final  String? body;
@override final  String state;
@override final  User user;
 final  List<Label>? _labels;
@override List<Label>? get labels {
  final value = _labels;
  if (value == null) return null;
  if (_labels is EqualUnmodifiableListView) return _labels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  User? assignee;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;
@override@JsonKey(name: 'closed_at') final  DateTime? closedAt;
@override@JsonKey(name: 'html_url') final  String htmlUrl;
@override@JsonKey(name: 'comments_url') final  String commentsUrl;
@override final  int? comments;

/// Create a copy of Issue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IssueCopyWith<_Issue> get copyWith => __$IssueCopyWithImpl<_Issue>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IssueToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Issue&&(identical(other.id, id) || other.id == id)&&(identical(other.number, number) || other.number == number)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.state, state) || other.state == state)&&(identical(other.user, user) || other.user == user)&&const DeepCollectionEquality().equals(other._labels, _labels)&&(identical(other.assignee, assignee) || other.assignee == assignee)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.closedAt, closedAt) || other.closedAt == closedAt)&&(identical(other.htmlUrl, htmlUrl) || other.htmlUrl == htmlUrl)&&(identical(other.commentsUrl, commentsUrl) || other.commentsUrl == commentsUrl)&&(identical(other.comments, comments) || other.comments == comments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,number,title,body,state,user,const DeepCollectionEquality().hash(_labels),assignee,createdAt,updatedAt,closedAt,htmlUrl,commentsUrl,comments);

@override
String toString() {
  return 'Issue(id: $id, number: $number, title: $title, body: $body, state: $state, user: $user, labels: $labels, assignee: $assignee, createdAt: $createdAt, updatedAt: $updatedAt, closedAt: $closedAt, htmlUrl: $htmlUrl, commentsUrl: $commentsUrl, comments: $comments)';
}


}

/// @nodoc
abstract mixin class _$IssueCopyWith<$Res> implements $IssueCopyWith<$Res> {
  factory _$IssueCopyWith(_Issue value, $Res Function(_Issue) _then) = __$IssueCopyWithImpl;
@override @useResult
$Res call({
 int id, int number, String title, String? body, String state, User user, List<Label>? labels, User? assignee,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt,@JsonKey(name: 'closed_at') DateTime? closedAt,@JsonKey(name: 'html_url') String htmlUrl,@JsonKey(name: 'comments_url') String commentsUrl, int? comments
});


@override $UserCopyWith<$Res> get user;@override $UserCopyWith<$Res>? get assignee;

}
/// @nodoc
class __$IssueCopyWithImpl<$Res>
    implements _$IssueCopyWith<$Res> {
  __$IssueCopyWithImpl(this._self, this._then);

  final _Issue _self;
  final $Res Function(_Issue) _then;

/// Create a copy of Issue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? number = null,Object? title = null,Object? body = freezed,Object? state = null,Object? user = null,Object? labels = freezed,Object? assignee = freezed,Object? createdAt = null,Object? updatedAt = null,Object? closedAt = freezed,Object? htmlUrl = null,Object? commentsUrl = null,Object? comments = freezed,}) {
  return _then(_Issue(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,labels: freezed == labels ? _self._labels : labels // ignore: cast_nullable_to_non_nullable
as List<Label>?,assignee: freezed == assignee ? _self.assignee : assignee // ignore: cast_nullable_to_non_nullable
as User?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,closedAt: freezed == closedAt ? _self.closedAt : closedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,htmlUrl: null == htmlUrl ? _self.htmlUrl : htmlUrl // ignore: cast_nullable_to_non_nullable
as String,commentsUrl: null == commentsUrl ? _self.commentsUrl : commentsUrl // ignore: cast_nullable_to_non_nullable
as String,comments: freezed == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of Issue
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get user {
  
  return $UserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of Issue
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res>? get assignee {
    if (_self.assignee == null) {
    return null;
  }

  return $UserCopyWith<$Res>(_self.assignee!, (value) {
    return _then(_self.copyWith(assignee: value));
  });
}
}


/// @nodoc
mixin _$IssueRequest {

 String get title;@JsonKey(includeIfNull: false) String? get body;@JsonKey(includeIfNull: false) List<String>? get assignees;@JsonKey(includeIfNull: false) List<String>? get labels;@JsonKey(includeIfNull: false) String? get state;
/// Create a copy of IssueRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IssueRequestCopyWith<IssueRequest> get copyWith => _$IssueRequestCopyWithImpl<IssueRequest>(this as IssueRequest, _$identity);

  /// Serializes this IssueRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IssueRequest&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&const DeepCollectionEquality().equals(other.assignees, assignees)&&const DeepCollectionEquality().equals(other.labels, labels)&&(identical(other.state, state) || other.state == state));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,body,const DeepCollectionEquality().hash(assignees),const DeepCollectionEquality().hash(labels),state);

@override
String toString() {
  return 'IssueRequest(title: $title, body: $body, assignees: $assignees, labels: $labels, state: $state)';
}


}

/// @nodoc
abstract mixin class $IssueRequestCopyWith<$Res>  {
  factory $IssueRequestCopyWith(IssueRequest value, $Res Function(IssueRequest) _then) = _$IssueRequestCopyWithImpl;
@useResult
$Res call({
 String title,@JsonKey(includeIfNull: false) String? body,@JsonKey(includeIfNull: false) List<String>? assignees,@JsonKey(includeIfNull: false) List<String>? labels,@JsonKey(includeIfNull: false) String? state
});




}
/// @nodoc
class _$IssueRequestCopyWithImpl<$Res>
    implements $IssueRequestCopyWith<$Res> {
  _$IssueRequestCopyWithImpl(this._self, this._then);

  final IssueRequest _self;
  final $Res Function(IssueRequest) _then;

/// Create a copy of IssueRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? body = freezed,Object? assignees = freezed,Object? labels = freezed,Object? state = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,assignees: freezed == assignees ? _self.assignees : assignees // ignore: cast_nullable_to_non_nullable
as List<String>?,labels: freezed == labels ? _self.labels : labels // ignore: cast_nullable_to_non_nullable
as List<String>?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [IssueRequest].
extension IssueRequestPatterns on IssueRequest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IssueRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IssueRequest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IssueRequest value)  $default,){
final _that = this;
switch (_that) {
case _IssueRequest():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IssueRequest value)?  $default,){
final _that = this;
switch (_that) {
case _IssueRequest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title, @JsonKey(includeIfNull: false)  String? body, @JsonKey(includeIfNull: false)  List<String>? assignees, @JsonKey(includeIfNull: false)  List<String>? labels, @JsonKey(includeIfNull: false)  String? state)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IssueRequest() when $default != null:
return $default(_that.title,_that.body,_that.assignees,_that.labels,_that.state);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title, @JsonKey(includeIfNull: false)  String? body, @JsonKey(includeIfNull: false)  List<String>? assignees, @JsonKey(includeIfNull: false)  List<String>? labels, @JsonKey(includeIfNull: false)  String? state)  $default,) {final _that = this;
switch (_that) {
case _IssueRequest():
return $default(_that.title,_that.body,_that.assignees,_that.labels,_that.state);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title, @JsonKey(includeIfNull: false)  String? body, @JsonKey(includeIfNull: false)  List<String>? assignees, @JsonKey(includeIfNull: false)  List<String>? labels, @JsonKey(includeIfNull: false)  String? state)?  $default,) {final _that = this;
switch (_that) {
case _IssueRequest() when $default != null:
return $default(_that.title,_that.body,_that.assignees,_that.labels,_that.state);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IssueRequest implements IssueRequest {
  const _IssueRequest({required this.title, @JsonKey(includeIfNull: false) this.body, @JsonKey(includeIfNull: false) final  List<String>? assignees, @JsonKey(includeIfNull: false) final  List<String>? labels, @JsonKey(includeIfNull: false) this.state}): _assignees = assignees,_labels = labels;
  factory _IssueRequest.fromJson(Map<String, dynamic> json) => _$IssueRequestFromJson(json);

@override final  String title;
@override@JsonKey(includeIfNull: false) final  String? body;
 final  List<String>? _assignees;
@override@JsonKey(includeIfNull: false) List<String>? get assignees {
  final value = _assignees;
  if (value == null) return null;
  if (_assignees is EqualUnmodifiableListView) return _assignees;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _labels;
@override@JsonKey(includeIfNull: false) List<String>? get labels {
  final value = _labels;
  if (value == null) return null;
  if (_labels is EqualUnmodifiableListView) return _labels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(includeIfNull: false) final  String? state;

/// Create a copy of IssueRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IssueRequestCopyWith<_IssueRequest> get copyWith => __$IssueRequestCopyWithImpl<_IssueRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IssueRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IssueRequest&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&const DeepCollectionEquality().equals(other._assignees, _assignees)&&const DeepCollectionEquality().equals(other._labels, _labels)&&(identical(other.state, state) || other.state == state));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,body,const DeepCollectionEquality().hash(_assignees),const DeepCollectionEquality().hash(_labels),state);

@override
String toString() {
  return 'IssueRequest(title: $title, body: $body, assignees: $assignees, labels: $labels, state: $state)';
}


}

/// @nodoc
abstract mixin class _$IssueRequestCopyWith<$Res> implements $IssueRequestCopyWith<$Res> {
  factory _$IssueRequestCopyWith(_IssueRequest value, $Res Function(_IssueRequest) _then) = __$IssueRequestCopyWithImpl;
@override @useResult
$Res call({
 String title,@JsonKey(includeIfNull: false) String? body,@JsonKey(includeIfNull: false) List<String>? assignees,@JsonKey(includeIfNull: false) List<String>? labels,@JsonKey(includeIfNull: false) String? state
});




}
/// @nodoc
class __$IssueRequestCopyWithImpl<$Res>
    implements _$IssueRequestCopyWith<$Res> {
  __$IssueRequestCopyWithImpl(this._self, this._then);

  final _IssueRequest _self;
  final $Res Function(_IssueRequest) _then;

/// Create a copy of IssueRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? body = freezed,Object? assignees = freezed,Object? labels = freezed,Object? state = freezed,}) {
  return _then(_IssueRequest(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,assignees: freezed == assignees ? _self._assignees : assignees // ignore: cast_nullable_to_non_nullable
as List<String>?,labels: freezed == labels ? _self._labels : labels // ignore: cast_nullable_to_non_nullable
as List<String>?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
