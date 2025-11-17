part of 'metamask_auth_bloc.dart';
// part 'wallet_event.freezed.dart';
@freezed
class WalletEvent with _$WalletEvent {
  const factory WalletEvent.metamaskAuth({
    required String signatureFromBackend,
  }) = _MetamaskAuthEvent;
  
  const factory WalletEvent.metamaskPayment({
    required String toAddress,
    required String amount,
    String? data,
    @Default(false) bool isTestnet,
  }) = _MetamaskPaymentEvent;
  
  const factory WalletEvent.disconnect() = _DisconnectEvent;
}