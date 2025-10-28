import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nft_ticket_event_ui/features/login/service/connect_service.dart';
import 'package:nft_ticket_event_ui/utils/constants/app_constants.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'wallet_envet.dart';
import 'wallet_state.dart';

class MetaMaskAuthBloc extends Bloc<WalletEvent, WalletState> {
  MetaMaskAuthBloc() : super(WalletInitialState()) {
    //now send that signature to the metamask, but before this initialize metamask and approve sign-in request
    on<MetamaskAuthEvent>((event, emit) async {
      debugPrint("🔵 [MetaMaskAuthBloc] User tapped 'Connect Wallet' button.");
      debugPrint("🔵 Signature from backend: ${event.signatureFromBackend}");

      emit(WalletInitializedState(message: AppConstants.initializing));

      bool isInitialize = await walletConnectorService.initialize();
      debugPrint("🟢 initialize() result: $isInitialize");

      if (isInitialize) {
        emit(WalletInitializedState(message: AppConstants.initialized));

        ConnectResponse? resp = await walletConnectorService.connect();
        debugPrint("🟢 connect() response: $resp");

        if (resp != null) {
          Uri? uri = resp.uri;
          debugPrint("🟢 Wallet URI: $uri");

          if (uri != null) {
            bool canLaunch = await walletConnectorService.onDisplayUri(uri);
            debugPrint("🟢 canLaunch MetaMask: $canLaunch");

            if (!canLaunch) {
              emit(WalletErrorState(message: AppConstants.metamaskNotInstalled));
              debugPrint("❌ MetaMask app not installed or cannot open URI.");
            } else {
              SessionData? sessionData = await walletConnectorService.authorize(
                  resp, event.signatureFromBackend);
              debugPrint("🟢 authorize() result: $sessionData");

              if (sessionData != null) {
                emit(WalletAuthorizedState(
                    message: AppConstants.connectionSuccessful));
                debugPrint("✅ Wallet connection authorized successfully.");

                if (resp.session.isCompleted) {
                  final String walletAddress = NamespaceUtils.getAccount(
                    sessionData.namespaces.values.first.accounts.first,
                  );
                  debugPrint("💰 Wallet Address: $walletAddress");

                  bool canLaunch =
                      await walletConnectorService.onDisplayUri(uri);
                  debugPrint("🔁 Re-launch MetaMask for signing: $canLaunch");

                  if (!canLaunch) {
                    emit(WalletErrorState(
                        message: AppConstants.metamaskNotInstalled));
                  } else {
                    final signatureFromWallet =
                        await walletConnectorService.sendMessageForSigned(
                            resp,
                            walletAddress,
                            sessionData.topic,
                            event.signatureFromBackend);

                    debugPrint(
                        "📝 Signature from wallet: $signatureFromWallet");

                    if (signatureFromWallet != null &&
                        signatureFromWallet != "") {
                      emit(WalletReceivedSignatureState(
                          signatureFromWallet: signatureFromWallet,
                          signatureFromBk: event.signatureFromBackend,
                          walletAddress: walletAddress,
                          message: AppConstants.authenticatingPleaseWait));
                      debugPrint("✅ Signature received successfully.");
                    } else {
                      emit(WalletErrorState(
                          message: AppConstants.userDeniedMessageSignature));
                      debugPrint("❌ User denied message signature.");
                    }

                    walletConnectorService.disconnectWallet(
                        topic: sessionData.topic);
                    debugPrint("🔚 Wallet disconnected.");
                  }
                }
              } else {
                emit(WalletErrorState(
                    message: AppConstants.userDeniedConnectionRequest));
                debugPrint("❌ User canceled wallet connection request.");
              }
            }
          }
        }
      } else {
        emit(WalletErrorState(message: AppConstants.walletConnectError));
        debugPrint("❌ WalletConnect initialization failed.");
      }
    });

  }
}
