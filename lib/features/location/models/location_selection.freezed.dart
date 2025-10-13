// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_selection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocationSelection {

 String get country; String get city;
/// Create a copy of LocationSelection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationSelectionCopyWith<LocationSelection> get copyWith => _$LocationSelectionCopyWithImpl<LocationSelection>(this as LocationSelection, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationSelection&&(identical(other.country, country) || other.country == country)&&(identical(other.city, city) || other.city == city));
}


@override
int get hashCode => Object.hash(runtimeType,country,city);

@override
String toString() {
  return 'LocationSelection(country: $country, city: $city)';
}


}

/// @nodoc
abstract mixin class $LocationSelectionCopyWith<$Res>  {
  factory $LocationSelectionCopyWith(LocationSelection value, $Res Function(LocationSelection) _then) = _$LocationSelectionCopyWithImpl;
@useResult
$Res call({
 String country, String city
});




}
/// @nodoc
class _$LocationSelectionCopyWithImpl<$Res>
    implements $LocationSelectionCopyWith<$Res> {
  _$LocationSelectionCopyWithImpl(this._self, this._then);

  final LocationSelection _self;
  final $Res Function(LocationSelection) _then;

/// Create a copy of LocationSelection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? country = null,Object? city = null,}) {
  return _then(_self.copyWith(
country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LocationSelection].
extension LocationSelectionPatterns on LocationSelection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocationSelection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocationSelection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocationSelection value)  $default,){
final _that = this;
switch (_that) {
case _LocationSelection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocationSelection value)?  $default,){
final _that = this;
switch (_that) {
case _LocationSelection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String country,  String city)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocationSelection() when $default != null:
return $default(_that.country,_that.city);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String country,  String city)  $default,) {final _that = this;
switch (_that) {
case _LocationSelection():
return $default(_that.country,_that.city);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String country,  String city)?  $default,) {final _that = this;
switch (_that) {
case _LocationSelection() when $default != null:
return $default(_that.country,_that.city);case _:
  return null;

}
}

}

/// @nodoc


class _LocationSelection extends LocationSelection {
  const _LocationSelection({required this.country, required this.city}): super._();
  

@override final  String country;
@override final  String city;

/// Create a copy of LocationSelection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationSelectionCopyWith<_LocationSelection> get copyWith => __$LocationSelectionCopyWithImpl<_LocationSelection>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationSelection&&(identical(other.country, country) || other.country == country)&&(identical(other.city, city) || other.city == city));
}


@override
int get hashCode => Object.hash(runtimeType,country,city);

@override
String toString() {
  return 'LocationSelection(country: $country, city: $city)';
}


}

/// @nodoc
abstract mixin class _$LocationSelectionCopyWith<$Res> implements $LocationSelectionCopyWith<$Res> {
  factory _$LocationSelectionCopyWith(_LocationSelection value, $Res Function(_LocationSelection) _then) = __$LocationSelectionCopyWithImpl;
@override @useResult
$Res call({
 String country, String city
});




}
/// @nodoc
class __$LocationSelectionCopyWithImpl<$Res>
    implements _$LocationSelectionCopyWith<$Res> {
  __$LocationSelectionCopyWithImpl(this._self, this._then);

  final _LocationSelection _self;
  final $Res Function(_LocationSelection) _then;

/// Create a copy of LocationSelection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? country = null,Object? city = null,}) {
  return _then(_LocationSelection(
country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
