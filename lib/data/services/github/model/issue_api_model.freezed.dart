// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'issue_api_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IssueApiModel {

/// Issue 番号
 int get number;/// Issue タイトル
 String get title;/// 状態（"open" / "closed"）
 String get state;/// Issue 本文（nullable）
 String? get body;/// 作成日時
@JsonKey(name: 'created_at') DateTime get createdAt;/// 更新日時
@JsonKey(name: 'updated_at') DateTime get updatedAt;
/// Create a copy of IssueApiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IssueApiModelCopyWith<IssueApiModel> get copyWith => _$IssueApiModelCopyWithImpl<IssueApiModel>(this as IssueApiModel, _$identity);

  /// Serializes this IssueApiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IssueApiModel&&(identical(other.number, number) || other.number == number)&&(identical(other.title, title) || other.title == title)&&(identical(other.state, state) || other.state == state)&&(identical(other.body, body) || other.body == body)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,number,title,state,body,createdAt,updatedAt);

@override
String toString() {
  return 'IssueApiModel(number: $number, title: $title, state: $state, body: $body, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $IssueApiModelCopyWith<$Res>  {
  factory $IssueApiModelCopyWith(IssueApiModel value, $Res Function(IssueApiModel) _then) = _$IssueApiModelCopyWithImpl;
@useResult
$Res call({
 int number, String title, String state, String? body,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class _$IssueApiModelCopyWithImpl<$Res>
    implements $IssueApiModelCopyWith<$Res> {
  _$IssueApiModelCopyWithImpl(this._self, this._then);

  final IssueApiModel _self;
  final $Res Function(IssueApiModel) _then;

/// Create a copy of IssueApiModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? number = null,Object? title = null,Object? state = null,Object? body = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [IssueApiModel].
extension IssueApiModelPatterns on IssueApiModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IssueApiModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IssueApiModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IssueApiModel value)  $default,){
final _that = this;
switch (_that) {
case _IssueApiModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IssueApiModel value)?  $default,){
final _that = this;
switch (_that) {
case _IssueApiModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int number,  String title,  String state,  String? body, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IssueApiModel() when $default != null:
return $default(_that.number,_that.title,_that.state,_that.body,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int number,  String title,  String state,  String? body, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _IssueApiModel():
return $default(_that.number,_that.title,_that.state,_that.body,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int number,  String title,  String state,  String? body, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _IssueApiModel() when $default != null:
return $default(_that.number,_that.title,_that.state,_that.body,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IssueApiModel implements IssueApiModel {
  const _IssueApiModel({required this.number, required this.title, required this.state, this.body, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt});
  factory _IssueApiModel.fromJson(Map<String, dynamic> json) => _$IssueApiModelFromJson(json);

/// Issue 番号
@override final  int number;
/// Issue タイトル
@override final  String title;
/// 状態（"open" / "closed"）
@override final  String state;
/// Issue 本文（nullable）
@override final  String? body;
/// 作成日時
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
/// 更新日時
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;

/// Create a copy of IssueApiModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IssueApiModelCopyWith<_IssueApiModel> get copyWith => __$IssueApiModelCopyWithImpl<_IssueApiModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IssueApiModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IssueApiModel&&(identical(other.number, number) || other.number == number)&&(identical(other.title, title) || other.title == title)&&(identical(other.state, state) || other.state == state)&&(identical(other.body, body) || other.body == body)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,number,title,state,body,createdAt,updatedAt);

@override
String toString() {
  return 'IssueApiModel(number: $number, title: $title, state: $state, body: $body, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$IssueApiModelCopyWith<$Res> implements $IssueApiModelCopyWith<$Res> {
  factory _$IssueApiModelCopyWith(_IssueApiModel value, $Res Function(_IssueApiModel) _then) = __$IssueApiModelCopyWithImpl;
@override @useResult
$Res call({
 int number, String title, String state, String? body,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class __$IssueApiModelCopyWithImpl<$Res>
    implements _$IssueApiModelCopyWith<$Res> {
  __$IssueApiModelCopyWithImpl(this._self, this._then);

  final _IssueApiModel _self;
  final $Res Function(_IssueApiModel) _then;

/// Create a copy of IssueApiModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? number = null,Object? title = null,Object? state = null,Object? body = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_IssueApiModel(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
