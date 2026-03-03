// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'repository_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RepositoryInfo {

 String get owner; String get repo;
/// Create a copy of RepositoryInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RepositoryInfoCopyWith<RepositoryInfo> get copyWith => _$RepositoryInfoCopyWithImpl<RepositoryInfo>(this as RepositoryInfo, _$identity);

  /// Serializes this RepositoryInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RepositoryInfo&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.repo, repo) || other.repo == repo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,owner,repo);

@override
String toString() {
  return 'RepositoryInfo(owner: $owner, repo: $repo)';
}


}

/// @nodoc
abstract mixin class $RepositoryInfoCopyWith<$Res>  {
  factory $RepositoryInfoCopyWith(RepositoryInfo value, $Res Function(RepositoryInfo) _then) = _$RepositoryInfoCopyWithImpl;
@useResult
$Res call({
 String owner, String repo
});




}
/// @nodoc
class _$RepositoryInfoCopyWithImpl<$Res>
    implements $RepositoryInfoCopyWith<$Res> {
  _$RepositoryInfoCopyWithImpl(this._self, this._then);

  final RepositoryInfo _self;
  final $Res Function(RepositoryInfo) _then;

/// Create a copy of RepositoryInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? owner = null,Object? repo = null,}) {
  return _then(_self.copyWith(
owner: null == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as String,repo: null == repo ? _self.repo : repo // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RepositoryInfo].
extension RepositoryInfoPatterns on RepositoryInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RepositoryInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RepositoryInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RepositoryInfo value)  $default,){
final _that = this;
switch (_that) {
case _RepositoryInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RepositoryInfo value)?  $default,){
final _that = this;
switch (_that) {
case _RepositoryInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String owner,  String repo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RepositoryInfo() when $default != null:
return $default(_that.owner,_that.repo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String owner,  String repo)  $default,) {final _that = this;
switch (_that) {
case _RepositoryInfo():
return $default(_that.owner,_that.repo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String owner,  String repo)?  $default,) {final _that = this;
switch (_that) {
case _RepositoryInfo() when $default != null:
return $default(_that.owner,_that.repo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RepositoryInfo implements RepositoryInfo {
  const _RepositoryInfo({required this.owner, required this.repo});
  factory _RepositoryInfo.fromJson(Map<String, dynamic> json) => _$RepositoryInfoFromJson(json);

@override final  String owner;
@override final  String repo;

/// Create a copy of RepositoryInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RepositoryInfoCopyWith<_RepositoryInfo> get copyWith => __$RepositoryInfoCopyWithImpl<_RepositoryInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RepositoryInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RepositoryInfo&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.repo, repo) || other.repo == repo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,owner,repo);

@override
String toString() {
  return 'RepositoryInfo(owner: $owner, repo: $repo)';
}


}

/// @nodoc
abstract mixin class _$RepositoryInfoCopyWith<$Res> implements $RepositoryInfoCopyWith<$Res> {
  factory _$RepositoryInfoCopyWith(_RepositoryInfo value, $Res Function(_RepositoryInfo) _then) = __$RepositoryInfoCopyWithImpl;
@override @useResult
$Res call({
 String owner, String repo
});




}
/// @nodoc
class __$RepositoryInfoCopyWithImpl<$Res>
    implements _$RepositoryInfoCopyWith<$Res> {
  __$RepositoryInfoCopyWithImpl(this._self, this._then);

  final _RepositoryInfo _self;
  final $Res Function(_RepositoryInfo) _then;

/// Create a copy of RepositoryInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? owner = null,Object? repo = null,}) {
  return _then(_RepositoryInfo(
owner: null == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as String,repo: null == repo ? _self.repo : repo // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
