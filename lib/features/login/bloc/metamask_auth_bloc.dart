import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nft_ticket_event_ui/features/login/repository/connect_service.dart';
import 'package:nft_ticket_event_ui/utils/constants/app_constants.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'metamask_auth_bloc.freezed.dart';
part 'wallet_event.dart';
part 'wallet_state.dart';

class MetaMaskAuthBloc extends Bloc<WalletEvent, WalletState> {
  MetaMaskAuthBloc() : super(const WalletState.initial()) {
    on<_MetamaskAuthEvent>(_onMetamaskAuth);
    on<_DisconnectEvent>(_onDisconnect);
  }
  // Auth handler
  Future <void> _onMetamaskAuth(_MetamaskAuthEvent event, Emitter<WalletState> emit) async{
    try {
      debugPrint("🔵 Signature from backend: ${event.signatureFromBackend}");
      emit(_WalletInitializingState(message: AppConstants.initializing));

      final isInitialize = await walletConnectorRepo.initialize();
      if(!isInitialize) {
        emit(const WalletState.error(message: AppConstants.walletConnectError));
        return;
      }

      emit(const WalletState.initialized(
        message: AppConstants.initialized,
      ));

      final connectResponse = await _connectWallet();
      if (connectResponse == null) {
        emit(const WalletState.error(
          message: AppConstants.connectResponse,
        ));
        return;
      }

      final sessionData = await _authorizeWallet(
        connectResponse,
        event.signatureFromBackend,
        emit,
      );
      
      if (sessionData != null) {
        await _handleSignature(
          connectResponse,
          sessionData,
          event.signatureFromBackend,
          emit,
        );
      }
    } catch (e) {
      debugPrint("❌ Auth error: $e");
      emit(WalletState.error(message: "Lỗi xác thực: $e"));
    }
  }

  Future<void> _onDisconnect(
    _DisconnectEvent event,
    Emitter<WalletState> emit,
  ) async {
    // Implement disconnect logic if needed
    emit(const WalletState.initial());
  }
  
  // Helper methods
  Future<bool> _initializeWallet() async {
    final isInitialized = await walletConnectorRepo.initialize();
    debugPrint("🟢 initialize() result: $isInitialized");
    return isInitialized;
  }

  Future<ConnectResponse?> _connectWallet() async {
    final response = await walletConnectorRepo.connect();
    debugPrint("🟢 connect() response: $response");
    return response;
  }

  Future<SessionData?> _authorizeWallet(
    ConnectResponse connectResponse,
    String signatureFromBackend,
    Emitter<WalletState> emit,
  ) async {
    final uri = connectResponse.uri;
    if (uri == null) return null;

    final canLaunch = await walletConnectorRepo.onDisplayUri(uri);
    debugPrint("🟢 canLaunch MetaMask: $canLaunch");

    if (!canLaunch) {
      emit(const WalletState.error(
        message: AppConstants.metamaskNotInstalled,
      ));
      return null;
    }

    final sessionData = await walletConnectorRepo.authorize(
      connectResponse,
      signatureFromBackend,
    );
    
    debugPrint("🟢 authorize() result: $sessionData");
    
    if (sessionData != null) {
      emit(const WalletState.authorized(
        message: AppConstants.connectionSuccessful,
      ));
    } else {
      emit(const WalletState.error(
        message: AppConstants.userDeniedConnectionRequest,
      ));
    }
    
    return sessionData;
  }

  Future<void> _handleSignature(
    ConnectResponse connectResponse,
    SessionData sessionData,
    String signatureFromBackend,
    Emitter<WalletState> emit,
  ) async {
    if (!connectResponse.session.isCompleted) return;

    final walletAddress = NamespaceUtils.getAccount(
      sessionData.namespaces.values.first.accounts.first,
    );
    debugPrint("💰 Wallet Address: $walletAddress");

    final uri = connectResponse.uri;
    if (uri == null) return;

    final canLaunch = await walletConnectorRepo.onDisplayUri(uri);
    debugPrint("🔁 Re-launch MetaMask for signing: $canLaunch");

    if (!canLaunch) {
      emit(const WalletState.error(
        message: AppConstants.metamaskNotInstalled,
      ));
      return;
    }

    final signatureFromWallet = await walletConnectorRepo.sendMessageForSigned(
      connectResponse,
      walletAddress,
      sessionData.topic,
      signatureFromBackend,
    );

    debugPrint("📝 Signature from wallet: $signatureFromWallet");

    if (signatureFromWallet != null && signatureFromWallet.isNotEmpty) {
      emit(WalletState.receivedSignature(
        signatureFromWallet: signatureFromWallet,
        signatureFromBk: signatureFromBackend,
        walletAddress: walletAddress,
        message: AppConstants.authenticatingPleaseWait,
      ));
      debugPrint("✅ Signature received successfully.");
    } else {
      emit(const WalletState.error(
        message: AppConstants.userDeniedMessageSignature,
      ));
      debugPrint("❌ User denied message signature.");
    }

    await _disconnectWallet(sessionData.topic);
  }
  
  Future<void> _disconnectWallet(String topic) async {
    await walletConnectorRepo.disconnectWallet(topic: topic);
    debugPrint("🔚 Wallet disconnected.");
  }

  String _shortenAddress(String address) {
    if (address.length < 10) return address;
    return '${address.substring(0, 6)}...${address.substring(address.length - 4)}';
  }

  String _shortenHash(String hash) {
    if (hash.length < 10) return hash;
    return '${hash.substring(0, 10)}...${hash.substring(hash.length - 8)}';
  }
}