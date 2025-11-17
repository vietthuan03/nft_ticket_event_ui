part of 'metamask_auth_bloc.dart';

@freezed
class WalletState with _$WalletState {
  const factory WalletState.initial() = WalletInitialState;

  const factory WalletState.initializing({
    required String message,
  }) = _WalletInitializingState;

  const factory WalletState.initialized({
    required String message,
  }) = _WalletInitializedState;

  const factory WalletState.authorized({
    required String message,
  }) = _WalletAuthorizedState;

  const factory WalletState.receivedSignature({
    required String signatureFromWallet,
    required String signatureFromBk,
    required String walletAddress,
    required String message,
  }) = _WalletReceivedSignatureState;

  const factory WalletState.paymentPending({
    required String txHash,
    String? message,
  }) = _WalletPaymentPendingState;
  
  const factory WalletState.paymentSuccess({
    required String txHash,
    required String walletAddress,
    required String amount,
    String? receipt,
    String? message,
  }) = _WalletPaymentSuccessState;
  
  const factory WalletState.paymentFailed({
    required String message,
  }) = WalletPaymentFailedState;

  const factory WalletState.error({
    required String message,
  }) = _WalletErrorState;
}
