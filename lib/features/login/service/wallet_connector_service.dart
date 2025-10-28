import 'package:reown_walletkit/reown_walletkit.dart';

abstract class WalletConnectorService {
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

}
