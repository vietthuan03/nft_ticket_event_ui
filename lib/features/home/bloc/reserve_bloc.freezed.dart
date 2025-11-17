// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reserve_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReserveEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReserveEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReserveEvent()';
}


}

/// @nodoc
class $ReserveEventCopyWith<$Res>  {
$ReserveEventCopyWith(ReserveEvent _, $Res Function(ReserveEvent) __);
}


/// Adds pattern-matching-related methods to [ReserveEvent].
extension ReserveEventPatterns on ReserveEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadTicketEvent value)?  loadTicket,TResult Function( _ToggleThemeEvent value)?  toggleTheme,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadTicketEvent() when loadTicket != null:
return loadTicket(_that);case _ToggleThemeEvent() when toggleTheme != null:
return toggleTheme(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadTicketEvent value)  loadTicket,required TResult Function( _ToggleThemeEvent value)  toggleTheme,}){
final _that = this;
switch (_that) {
case _LoadTicketEvent():
return loadTicket(_that);case _ToggleThemeEvent():
return toggleTheme(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadTicketEvent value)?  loadTicket,TResult? Function( _ToggleThemeEvent value)?  toggleTheme,}){
final _that = this;
switch (_that) {
case _LoadTicketEvent() when loadTicket != null:
return loadTicket(_that);case _ToggleThemeEvent() when toggleTheme != null:
return toggleTheme(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadTicket,TResult Function()?  toggleTheme,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadTicketEvent() when loadTicket != null:
return loadTicket();case _ToggleThemeEvent() when toggleTheme != null:
return toggleTheme();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadTicket,required TResult Function()  toggleTheme,}) {final _that = this;
switch (_that) {
case _LoadTicketEvent():
return loadTicket();case _ToggleThemeEvent():
return toggleTheme();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadTicket,TResult? Function()?  toggleTheme,}) {final _that = this;
switch (_that) {
case _LoadTicketEvent() when loadTicket != null:
return loadTicket();case _ToggleThemeEvent() when toggleTheme != null:
return toggleTheme();case _:
  return null;

}
}

}

/// @nodoc


class _LoadTicketEvent implements ReserveEvent {
  const _LoadTicketEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadTicketEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReserveEvent.loadTicket()';
}


}




/// @nodoc


class _ToggleThemeEvent implements ReserveEvent {
  const _ToggleThemeEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleThemeEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReserveEvent.toggleTheme()';
}


}




// dart format on
