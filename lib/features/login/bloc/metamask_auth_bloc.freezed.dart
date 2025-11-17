// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'metamask_auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WalletEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WalletEvent()';
}


}

/// @nodoc
class $WalletEventCopyWith<$Res>  {
$WalletEventCopyWith(WalletEvent _, $Res Function(WalletEvent) __);
}


/// Adds pattern-matching-related methods to [WalletEvent].
extension WalletEventPatterns on WalletEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _MetamaskAuthEvent value)?  metamaskAuth,TResult Function( _MetamaskPaymentEvent value)?  metamaskPayment,TResult Function( _DisconnectEvent value)?  disconnect,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MetamaskAuthEvent() when metamaskAuth != null:
return metamaskAuth(_that);case _MetamaskPaymentEvent() when metamaskPayment != null:
return metamaskPayment(_that);case _DisconnectEvent() when disconnect != null:
return disconnect(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _MetamaskAuthEvent value)  metamaskAuth,required TResult Function( _MetamaskPaymentEvent value)  metamaskPayment,required TResult Function( _DisconnectEvent value)  disconnect,}){
final _that = this;
switch (_that) {
case _MetamaskAuthEvent():
return metamaskAuth(_that);case _MetamaskPaymentEvent():
return metamaskPayment(_that);case _DisconnectEvent():
return disconnect(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _MetamaskAuthEvent value)?  metamaskAuth,TResult? Function( _MetamaskPaymentEvent value)?  metamaskPayment,TResult? Function( _DisconnectEvent value)?  disconnect,}){
final _that = this;
switch (_that) {
case _MetamaskAuthEvent() when metamaskAuth != null:
return metamaskAuth(_that);case _MetamaskPaymentEvent() when metamaskPayment != null:
return metamaskPayment(_that);case _DisconnectEvent() when disconnect != null:
return disconnect(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String signatureFromBackend)?  metamaskAuth,TResult Function( String toAddress,  String amount,  String? data,  bool isTestnet)?  metamaskPayment,TResult Function()?  disconnect,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MetamaskAuthEvent() when metamaskAuth != null:
return metamaskAuth(_that.signatureFromBackend);case _MetamaskPaymentEvent() when metamaskPayment != null:
return metamaskPayment(_that.toAddress,_that.amount,_that.data,_that.isTestnet);case _DisconnectEvent() when disconnect != null:
return disconnect();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String signatureFromBackend)  metamaskAuth,required TResult Function( String toAddress,  String amount,  String? data,  bool isTestnet)  metamaskPayment,required TResult Function()  disconnect,}) {final _that = this;
switch (_that) {
case _MetamaskAuthEvent():
return metamaskAuth(_that.signatureFromBackend);case _MetamaskPaymentEvent():
return metamaskPayment(_that.toAddress,_that.amount,_that.data,_that.isTestnet);case _DisconnectEvent():
return disconnect();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String signatureFromBackend)?  metamaskAuth,TResult? Function( String toAddress,  String amount,  String? data,  bool isTestnet)?  metamaskPayment,TResult? Function()?  disconnect,}) {final _that = this;
switch (_that) {
case _MetamaskAuthEvent() when metamaskAuth != null:
return metamaskAuth(_that.signatureFromBackend);case _MetamaskPaymentEvent() when metamaskPayment != null:
return metamaskPayment(_that.toAddress,_that.amount,_that.data,_that.isTestnet);case _DisconnectEvent() when disconnect != null:
return disconnect();case _:
  return null;

}
}

}

/// @nodoc


class _MetamaskAuthEvent implements WalletEvent {
  const _MetamaskAuthEvent({required this.signatureFromBackend});
  

 final  String signatureFromBackend;

/// Create a copy of WalletEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MetamaskAuthEventCopyWith<_MetamaskAuthEvent> get copyWith => __$MetamaskAuthEventCopyWithImpl<_MetamaskAuthEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MetamaskAuthEvent&&(identical(other.signatureFromBackend, signatureFromBackend) || other.signatureFromBackend == signatureFromBackend));
}


@override
int get hashCode => Object.hash(runtimeType,signatureFromBackend);

@override
String toString() {
  return 'WalletEvent.metamaskAuth(signatureFromBackend: $signatureFromBackend)';
}


}

/// @nodoc
abstract mixin class _$MetamaskAuthEventCopyWith<$Res> implements $WalletEventCopyWith<$Res> {
  factory _$MetamaskAuthEventCopyWith(_MetamaskAuthEvent value, $Res Function(_MetamaskAuthEvent) _then) = __$MetamaskAuthEventCopyWithImpl;
@useResult
$Res call({
 String signatureFromBackend
});




}
/// @nodoc
class __$MetamaskAuthEventCopyWithImpl<$Res>
    implements _$MetamaskAuthEventCopyWith<$Res> {
  __$MetamaskAuthEventCopyWithImpl(this._self, this._then);

  final _MetamaskAuthEvent _self;
  final $Res Function(_MetamaskAuthEvent) _then;

/// Create a copy of WalletEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? signatureFromBackend = null,}) {
  return _then(_MetamaskAuthEvent(
signatureFromBackend: null == signatureFromBackend ? _self.signatureFromBackend : signatureFromBackend // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _MetamaskPaymentEvent implements WalletEvent {
  const _MetamaskPaymentEvent({required this.toAddress, required this.amount, this.data, this.isTestnet = false});
  

 final  String toAddress;
 final  String amount;
 final  String? data;
@JsonKey() final  bool isTestnet;

/// Create a copy of WalletEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MetamaskPaymentEventCopyWith<_MetamaskPaymentEvent> get copyWith => __$MetamaskPaymentEventCopyWithImpl<_MetamaskPaymentEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MetamaskPaymentEvent&&(identical(other.toAddress, toAddress) || other.toAddress == toAddress)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.data, data) || other.data == data)&&(identical(other.isTestnet, isTestnet) || other.isTestnet == isTestnet));
}


@override
int get hashCode => Object.hash(runtimeType,toAddress,amount,data,isTestnet);

@override
String toString() {
  return 'WalletEvent.metamaskPayment(toAddress: $toAddress, amount: $amount, data: $data, isTestnet: $isTestnet)';
}


}

/// @nodoc
abstract mixin class _$MetamaskPaymentEventCopyWith<$Res> implements $WalletEventCopyWith<$Res> {
  factory _$MetamaskPaymentEventCopyWith(_MetamaskPaymentEvent value, $Res Function(_MetamaskPaymentEvent) _then) = __$MetamaskPaymentEventCopyWithImpl;
@useResult
$Res call({
 String toAddress, String amount, String? data, bool isTestnet
});




}
/// @nodoc
class __$MetamaskPaymentEventCopyWithImpl<$Res>
    implements _$MetamaskPaymentEventCopyWith<$Res> {
  __$MetamaskPaymentEventCopyWithImpl(this._self, this._then);

  final _MetamaskPaymentEvent _self;
  final $Res Function(_MetamaskPaymentEvent) _then;

/// Create a copy of WalletEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? toAddress = null,Object? amount = null,Object? data = freezed,Object? isTestnet = null,}) {
  return _then(_MetamaskPaymentEvent(
toAddress: null == toAddress ? _self.toAddress : toAddress // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as String?,isTestnet: null == isTestnet ? _self.isTestnet : isTestnet // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _DisconnectEvent implements WalletEvent {
  const _DisconnectEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DisconnectEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WalletEvent.disconnect()';
}


}




/// @nodoc
mixin _$WalletState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WalletState()';
}


}

/// @nodoc
class $WalletStateCopyWith<$Res>  {
$WalletStateCopyWith(WalletState _, $Res Function(WalletState) __);
}


/// Adds pattern-matching-related methods to [WalletState].
extension WalletStatePatterns on WalletState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( WalletInitialState value)?  initial,TResult Function( _WalletInitializingState value)?  initializing,TResult Function( _WalletInitializedState value)?  initialized,TResult Function( _WalletAuthorizedState value)?  authorized,TResult Function( _WalletReceivedSignatureState value)?  receivedSignature,TResult Function( _WalletPaymentPendingState value)?  paymentPending,TResult Function( _WalletPaymentSuccessState value)?  paymentSuccess,TResult Function( WalletPaymentFailedState value)?  paymentFailed,TResult Function( _WalletErrorState value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case WalletInitialState() when initial != null:
return initial(_that);case _WalletInitializingState() when initializing != null:
return initializing(_that);case _WalletInitializedState() when initialized != null:
return initialized(_that);case _WalletAuthorizedState() when authorized != null:
return authorized(_that);case _WalletReceivedSignatureState() when receivedSignature != null:
return receivedSignature(_that);case _WalletPaymentPendingState() when paymentPending != null:
return paymentPending(_that);case _WalletPaymentSuccessState() when paymentSuccess != null:
return paymentSuccess(_that);case WalletPaymentFailedState() when paymentFailed != null:
return paymentFailed(_that);case _WalletErrorState() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( WalletInitialState value)  initial,required TResult Function( _WalletInitializingState value)  initializing,required TResult Function( _WalletInitializedState value)  initialized,required TResult Function( _WalletAuthorizedState value)  authorized,required TResult Function( _WalletReceivedSignatureState value)  receivedSignature,required TResult Function( _WalletPaymentPendingState value)  paymentPending,required TResult Function( _WalletPaymentSuccessState value)  paymentSuccess,required TResult Function( WalletPaymentFailedState value)  paymentFailed,required TResult Function( _WalletErrorState value)  error,}){
final _that = this;
switch (_that) {
case WalletInitialState():
return initial(_that);case _WalletInitializingState():
return initializing(_that);case _WalletInitializedState():
return initialized(_that);case _WalletAuthorizedState():
return authorized(_that);case _WalletReceivedSignatureState():
return receivedSignature(_that);case _WalletPaymentPendingState():
return paymentPending(_that);case _WalletPaymentSuccessState():
return paymentSuccess(_that);case WalletPaymentFailedState():
return paymentFailed(_that);case _WalletErrorState():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( WalletInitialState value)?  initial,TResult? Function( _WalletInitializingState value)?  initializing,TResult? Function( _WalletInitializedState value)?  initialized,TResult? Function( _WalletAuthorizedState value)?  authorized,TResult? Function( _WalletReceivedSignatureState value)?  receivedSignature,TResult? Function( _WalletPaymentPendingState value)?  paymentPending,TResult? Function( _WalletPaymentSuccessState value)?  paymentSuccess,TResult? Function( WalletPaymentFailedState value)?  paymentFailed,TResult? Function( _WalletErrorState value)?  error,}){
final _that = this;
switch (_that) {
case WalletInitialState() when initial != null:
return initial(_that);case _WalletInitializingState() when initializing != null:
return initializing(_that);case _WalletInitializedState() when initialized != null:
return initialized(_that);case _WalletAuthorizedState() when authorized != null:
return authorized(_that);case _WalletReceivedSignatureState() when receivedSignature != null:
return receivedSignature(_that);case _WalletPaymentPendingState() when paymentPending != null:
return paymentPending(_that);case _WalletPaymentSuccessState() when paymentSuccess != null:
return paymentSuccess(_that);case WalletPaymentFailedState() when paymentFailed != null:
return paymentFailed(_that);case _WalletErrorState() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( String message)?  initializing,TResult Function( String message)?  initialized,TResult Function( String message)?  authorized,TResult Function( String signatureFromWallet,  String signatureFromBk,  String walletAddress,  String message)?  receivedSignature,TResult Function( String txHash,  String? message)?  paymentPending,TResult Function( String txHash,  String walletAddress,  String amount,  String? receipt,  String? message)?  paymentSuccess,TResult Function( String message)?  paymentFailed,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case WalletInitialState() when initial != null:
return initial();case _WalletInitializingState() when initializing != null:
return initializing(_that.message);case _WalletInitializedState() when initialized != null:
return initialized(_that.message);case _WalletAuthorizedState() when authorized != null:
return authorized(_that.message);case _WalletReceivedSignatureState() when receivedSignature != null:
return receivedSignature(_that.signatureFromWallet,_that.signatureFromBk,_that.walletAddress,_that.message);case _WalletPaymentPendingState() when paymentPending != null:
return paymentPending(_that.txHash,_that.message);case _WalletPaymentSuccessState() when paymentSuccess != null:
return paymentSuccess(_that.txHash,_that.walletAddress,_that.amount,_that.receipt,_that.message);case WalletPaymentFailedState() when paymentFailed != null:
return paymentFailed(_that.message);case _WalletErrorState() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( String message)  initializing,required TResult Function( String message)  initialized,required TResult Function( String message)  authorized,required TResult Function( String signatureFromWallet,  String signatureFromBk,  String walletAddress,  String message)  receivedSignature,required TResult Function( String txHash,  String? message)  paymentPending,required TResult Function( String txHash,  String walletAddress,  String amount,  String? receipt,  String? message)  paymentSuccess,required TResult Function( String message)  paymentFailed,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case WalletInitialState():
return initial();case _WalletInitializingState():
return initializing(_that.message);case _WalletInitializedState():
return initialized(_that.message);case _WalletAuthorizedState():
return authorized(_that.message);case _WalletReceivedSignatureState():
return receivedSignature(_that.signatureFromWallet,_that.signatureFromBk,_that.walletAddress,_that.message);case _WalletPaymentPendingState():
return paymentPending(_that.txHash,_that.message);case _WalletPaymentSuccessState():
return paymentSuccess(_that.txHash,_that.walletAddress,_that.amount,_that.receipt,_that.message);case WalletPaymentFailedState():
return paymentFailed(_that.message);case _WalletErrorState():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( String message)?  initializing,TResult? Function( String message)?  initialized,TResult? Function( String message)?  authorized,TResult? Function( String signatureFromWallet,  String signatureFromBk,  String walletAddress,  String message)?  receivedSignature,TResult? Function( String txHash,  String? message)?  paymentPending,TResult? Function( String txHash,  String walletAddress,  String amount,  String? receipt,  String? message)?  paymentSuccess,TResult? Function( String message)?  paymentFailed,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case WalletInitialState() when initial != null:
return initial();case _WalletInitializingState() when initializing != null:
return initializing(_that.message);case _WalletInitializedState() when initialized != null:
return initialized(_that.message);case _WalletAuthorizedState() when authorized != null:
return authorized(_that.message);case _WalletReceivedSignatureState() when receivedSignature != null:
return receivedSignature(_that.signatureFromWallet,_that.signatureFromBk,_that.walletAddress,_that.message);case _WalletPaymentPendingState() when paymentPending != null:
return paymentPending(_that.txHash,_that.message);case _WalletPaymentSuccessState() when paymentSuccess != null:
return paymentSuccess(_that.txHash,_that.walletAddress,_that.amount,_that.receipt,_that.message);case WalletPaymentFailedState() when paymentFailed != null:
return paymentFailed(_that.message);case _WalletErrorState() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class WalletInitialState implements WalletState {
  const WalletInitialState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletInitialState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WalletState.initial()';
}


}




/// @nodoc


class _WalletInitializingState implements WalletState {
  const _WalletInitializingState({required this.message});
  

 final  String message;

/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalletInitializingStateCopyWith<_WalletInitializingState> get copyWith => __$WalletInitializingStateCopyWithImpl<_WalletInitializingState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalletInitializingState&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'WalletState.initializing(message: $message)';
}


}

/// @nodoc
abstract mixin class _$WalletInitializingStateCopyWith<$Res> implements $WalletStateCopyWith<$Res> {
  factory _$WalletInitializingStateCopyWith(_WalletInitializingState value, $Res Function(_WalletInitializingState) _then) = __$WalletInitializingStateCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$WalletInitializingStateCopyWithImpl<$Res>
    implements _$WalletInitializingStateCopyWith<$Res> {
  __$WalletInitializingStateCopyWithImpl(this._self, this._then);

  final _WalletInitializingState _self;
  final $Res Function(_WalletInitializingState) _then;

/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_WalletInitializingState(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _WalletInitializedState implements WalletState {
  const _WalletInitializedState({required this.message});
  

 final  String message;

/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalletInitializedStateCopyWith<_WalletInitializedState> get copyWith => __$WalletInitializedStateCopyWithImpl<_WalletInitializedState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalletInitializedState&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'WalletState.initialized(message: $message)';
}


}

/// @nodoc
abstract mixin class _$WalletInitializedStateCopyWith<$Res> implements $WalletStateCopyWith<$Res> {
  factory _$WalletInitializedStateCopyWith(_WalletInitializedState value, $Res Function(_WalletInitializedState) _then) = __$WalletInitializedStateCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$WalletInitializedStateCopyWithImpl<$Res>
    implements _$WalletInitializedStateCopyWith<$Res> {
  __$WalletInitializedStateCopyWithImpl(this._self, this._then);

  final _WalletInitializedState _self;
  final $Res Function(_WalletInitializedState) _then;

/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_WalletInitializedState(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _WalletAuthorizedState implements WalletState {
  const _WalletAuthorizedState({required this.message});
  

 final  String message;

/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalletAuthorizedStateCopyWith<_WalletAuthorizedState> get copyWith => __$WalletAuthorizedStateCopyWithImpl<_WalletAuthorizedState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalletAuthorizedState&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'WalletState.authorized(message: $message)';
}


}

/// @nodoc
abstract mixin class _$WalletAuthorizedStateCopyWith<$Res> implements $WalletStateCopyWith<$Res> {
  factory _$WalletAuthorizedStateCopyWith(_WalletAuthorizedState value, $Res Function(_WalletAuthorizedState) _then) = __$WalletAuthorizedStateCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$WalletAuthorizedStateCopyWithImpl<$Res>
    implements _$WalletAuthorizedStateCopyWith<$Res> {
  __$WalletAuthorizedStateCopyWithImpl(this._self, this._then);

  final _WalletAuthorizedState _self;
  final $Res Function(_WalletAuthorizedState) _then;

/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_WalletAuthorizedState(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _WalletReceivedSignatureState implements WalletState {
  const _WalletReceivedSignatureState({required this.signatureFromWallet, required this.signatureFromBk, required this.walletAddress, required this.message});
  

 final  String signatureFromWallet;
 final  String signatureFromBk;
 final  String walletAddress;
 final  String message;

/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalletReceivedSignatureStateCopyWith<_WalletReceivedSignatureState> get copyWith => __$WalletReceivedSignatureStateCopyWithImpl<_WalletReceivedSignatureState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalletReceivedSignatureState&&(identical(other.signatureFromWallet, signatureFromWallet) || other.signatureFromWallet == signatureFromWallet)&&(identical(other.signatureFromBk, signatureFromBk) || other.signatureFromBk == signatureFromBk)&&(identical(other.walletAddress, walletAddress) || other.walletAddress == walletAddress)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,signatureFromWallet,signatureFromBk,walletAddress,message);

@override
String toString() {
  return 'WalletState.receivedSignature(signatureFromWallet: $signatureFromWallet, signatureFromBk: $signatureFromBk, walletAddress: $walletAddress, message: $message)';
}


}

/// @nodoc
abstract mixin class _$WalletReceivedSignatureStateCopyWith<$Res> implements $WalletStateCopyWith<$Res> {
  factory _$WalletReceivedSignatureStateCopyWith(_WalletReceivedSignatureState value, $Res Function(_WalletReceivedSignatureState) _then) = __$WalletReceivedSignatureStateCopyWithImpl;
@useResult
$Res call({
 String signatureFromWallet, String signatureFromBk, String walletAddress, String message
});




}
/// @nodoc
class __$WalletReceivedSignatureStateCopyWithImpl<$Res>
    implements _$WalletReceivedSignatureStateCopyWith<$Res> {
  __$WalletReceivedSignatureStateCopyWithImpl(this._self, this._then);

  final _WalletReceivedSignatureState _self;
  final $Res Function(_WalletReceivedSignatureState) _then;

/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? signatureFromWallet = null,Object? signatureFromBk = null,Object? walletAddress = null,Object? message = null,}) {
  return _then(_WalletReceivedSignatureState(
signatureFromWallet: null == signatureFromWallet ? _self.signatureFromWallet : signatureFromWallet // ignore: cast_nullable_to_non_nullable
as String,signatureFromBk: null == signatureFromBk ? _self.signatureFromBk : signatureFromBk // ignore: cast_nullable_to_non_nullable
as String,walletAddress: null == walletAddress ? _self.walletAddress : walletAddress // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _WalletPaymentPendingState implements WalletState {
  const _WalletPaymentPendingState({required this.txHash, this.message});
  

 final  String txHash;
 final  String? message;

/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalletPaymentPendingStateCopyWith<_WalletPaymentPendingState> get copyWith => __$WalletPaymentPendingStateCopyWithImpl<_WalletPaymentPendingState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalletPaymentPendingState&&(identical(other.txHash, txHash) || other.txHash == txHash)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,txHash,message);

@override
String toString() {
  return 'WalletState.paymentPending(txHash: $txHash, message: $message)';
}


}

/// @nodoc
abstract mixin class _$WalletPaymentPendingStateCopyWith<$Res> implements $WalletStateCopyWith<$Res> {
  factory _$WalletPaymentPendingStateCopyWith(_WalletPaymentPendingState value, $Res Function(_WalletPaymentPendingState) _then) = __$WalletPaymentPendingStateCopyWithImpl;
@useResult
$Res call({
 String txHash, String? message
});




}
/// @nodoc
class __$WalletPaymentPendingStateCopyWithImpl<$Res>
    implements _$WalletPaymentPendingStateCopyWith<$Res> {
  __$WalletPaymentPendingStateCopyWithImpl(this._self, this._then);

  final _WalletPaymentPendingState _self;
  final $Res Function(_WalletPaymentPendingState) _then;

/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? txHash = null,Object? message = freezed,}) {
  return _then(_WalletPaymentPendingState(
txHash: null == txHash ? _self.txHash : txHash // ignore: cast_nullable_to_non_nullable
as String,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _WalletPaymentSuccessState implements WalletState {
  const _WalletPaymentSuccessState({required this.txHash, required this.walletAddress, required this.amount, this.receipt, this.message});
  

 final  String txHash;
 final  String walletAddress;
 final  String amount;
 final  String? receipt;
 final  String? message;

/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalletPaymentSuccessStateCopyWith<_WalletPaymentSuccessState> get copyWith => __$WalletPaymentSuccessStateCopyWithImpl<_WalletPaymentSuccessState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalletPaymentSuccessState&&(identical(other.txHash, txHash) || other.txHash == txHash)&&(identical(other.walletAddress, walletAddress) || other.walletAddress == walletAddress)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.receipt, receipt) || other.receipt == receipt)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,txHash,walletAddress,amount,receipt,message);

@override
String toString() {
  return 'WalletState.paymentSuccess(txHash: $txHash, walletAddress: $walletAddress, amount: $amount, receipt: $receipt, message: $message)';
}


}

/// @nodoc
abstract mixin class _$WalletPaymentSuccessStateCopyWith<$Res> implements $WalletStateCopyWith<$Res> {
  factory _$WalletPaymentSuccessStateCopyWith(_WalletPaymentSuccessState value, $Res Function(_WalletPaymentSuccessState) _then) = __$WalletPaymentSuccessStateCopyWithImpl;
@useResult
$Res call({
 String txHash, String walletAddress, String amount, String? receipt, String? message
});




}
/// @nodoc
class __$WalletPaymentSuccessStateCopyWithImpl<$Res>
    implements _$WalletPaymentSuccessStateCopyWith<$Res> {
  __$WalletPaymentSuccessStateCopyWithImpl(this._self, this._then);

  final _WalletPaymentSuccessState _self;
  final $Res Function(_WalletPaymentSuccessState) _then;

/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? txHash = null,Object? walletAddress = null,Object? amount = null,Object? receipt = freezed,Object? message = freezed,}) {
  return _then(_WalletPaymentSuccessState(
txHash: null == txHash ? _self.txHash : txHash // ignore: cast_nullable_to_non_nullable
as String,walletAddress: null == walletAddress ? _self.walletAddress : walletAddress // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,receipt: freezed == receipt ? _self.receipt : receipt // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class WalletPaymentFailedState implements WalletState {
  const WalletPaymentFailedState({required this.message});
  

 final  String message;

/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalletPaymentFailedStateCopyWith<WalletPaymentFailedState> get copyWith => _$WalletPaymentFailedStateCopyWithImpl<WalletPaymentFailedState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletPaymentFailedState&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'WalletState.paymentFailed(message: $message)';
}


}

/// @nodoc
abstract mixin class $WalletPaymentFailedStateCopyWith<$Res> implements $WalletStateCopyWith<$Res> {
  factory $WalletPaymentFailedStateCopyWith(WalletPaymentFailedState value, $Res Function(WalletPaymentFailedState) _then) = _$WalletPaymentFailedStateCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$WalletPaymentFailedStateCopyWithImpl<$Res>
    implements $WalletPaymentFailedStateCopyWith<$Res> {
  _$WalletPaymentFailedStateCopyWithImpl(this._self, this._then);

  final WalletPaymentFailedState _self;
  final $Res Function(WalletPaymentFailedState) _then;

/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(WalletPaymentFailedState(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _WalletErrorState implements WalletState {
  const _WalletErrorState({required this.message});
  

 final  String message;

/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalletErrorStateCopyWith<_WalletErrorState> get copyWith => __$WalletErrorStateCopyWithImpl<_WalletErrorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalletErrorState&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'WalletState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$WalletErrorStateCopyWith<$Res> implements $WalletStateCopyWith<$Res> {
  factory _$WalletErrorStateCopyWith(_WalletErrorState value, $Res Function(_WalletErrorState) _then) = __$WalletErrorStateCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$WalletErrorStateCopyWithImpl<$Res>
    implements _$WalletErrorStateCopyWith<$Res> {
  __$WalletErrorStateCopyWithImpl(this._self, this._then);

  final _WalletErrorState _self;
  final $Res Function(_WalletErrorState) _then;

/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_WalletErrorState(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
