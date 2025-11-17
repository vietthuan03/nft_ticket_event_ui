import 'package:reown_walletkit/reown_walletkit.dart';

abstract class WalletConnectorRepo {
  ReownSignClient get wClient;
  Future<bool> initialize();
  Future<ConnectResponse?> connect();
  Future<SessionData?> authorize(
    ConnectResponse resp,
    String unSignedMessage,
  );
  Future<String?> sendMessageForSigned(
    ConnectResponse resp,
    String walletAddress,
    String topic,
    String unSignedMessage,
  );
  Future<bool> onDisplayUri(Uri? uri);
  Future<void> disconnectWallet({required String topic});

  Future<String?> sendTransaction({
    required String topic,
    required String fromAddress,
    required String toAddress,
    required String value,
    String? data,
    String chainId,
  });

  Future<Map<String, dynamic>?> getTransactionReceipt({
    required String topic,
    required String txHash,
    String chainId,
  });
}
