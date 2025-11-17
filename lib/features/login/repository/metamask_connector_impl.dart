import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:nft_ticket_event_ui/features/login/repository/wallet_connector_repo.dart';
import 'package:nft_ticket_event_ui/features/login/wallet_constants.dart';
import 'package:nft_ticket_event_ui/features/login/models/chain_metadata.dart';
import 'package:nft_ticket_event_ui/utils/helper/helper_functions.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MetamaskConnectorRepoImpl implements WalletConnectorRepo {
  late ReownSignClient _wcClient;
  final ChainMetadata _chainMetadata = WalletConstants.mainChainMetaData;
  @override
  ReownSignClient get wClient => _wcClient;

  @override
  Future<bool> initialize() async {
    bool isInitialize = false;
    try {
      _wcClient = await ReownSignClient.createInstance(
        relayUrl: _chainMetadata.relayUrl,
        projectId: _chainMetadata.projectId,
        metadata: PairingMetadata(
            name: "MetaMask",
            description: "MetaMask login",
            url: _chainMetadata.walletConnectUrl,
            icons: ["https://wagmi.sh/logo-light.svg"],
            redirect: Redirect(universal: _chainMetadata.redirectUrl)),
      );
      isInitialize = true;
    } catch (err) {
      debugPrint("Catch wallet initialize error $err");
    }
    return isInitialize;
  }

  @override
  Future<ConnectResponse?> connect() async {
    try {
      ConnectResponse? resp = await wClient.connect(optionalNamespaces: {
        _chainMetadata.type: RequiredNamespace(
          chains: [_chainMetadata.chainId], // Ethereum chain
          methods: [_chainMetadata.method], // Requestable Methods
          events: _chainMetadata.events, // Requestable Events
        )
      });

      return resp;
    } catch (err) {
      debugPrint("Catch wallet connect error $err");
    }
    return null;
  }

  @override
  Future<SessionData?> authorize(
      ConnectResponse resp, String unSignedMessage) async {
    SessionData? sessionData;
    try {
      sessionData = await resp.session.future;
    } catch (err) {
      debugPrint("Catch wallet authorize error $err");
    }
    return sessionData;
  }

  @override
  Future<String?> sendMessageForSigned(ConnectResponse resp,
      String walletAddress, String topic, String unSignedMessage) async {
    String? signature;
    try {
      Uri? uri = resp.uri;
      if (uri != null) {
        // Now that you have a session, you can request signatures
        final res = await wClient.request(
          topic: topic,
          chainId: _chainMetadata.chainId,
          request: SessionRequestParams(
            method: _chainMetadata.method,
            params: [unSignedMessage, walletAddress],
          ),
        );
        signature = res.toString();
      }
    } catch (err) {
      debugPrint("Catch SendMessageForSigned error $err");
    }
    return signature;
  }

  @override
  Future<bool> onDisplayUri(Uri? uri) async {
    final link =
        formatNativeUrl(WalletConstants.deepLinkMetamask, uri.toString());
    var url = link.toString();
    if (!await canLaunchUrlString(url)) {
      return false;
    }
    return await launchUrlString(url, mode: LaunchMode.externalApplication);
  }

  @override
  Future<void> disconnectWallet({required String topic}) async {
    final coreError = Errors.getSdkError(Errors.USER_DISCONNECTED);
    await wClient.disconnect(
        topic: topic, 
        reason: ReownSignError(
          code: coreError.code,
          message: coreError.message,
        )
    );
  }

  Future<void> handlePayWithMetaMask(BuildContext context) async {
    try {
      final initialized = await initialize();
      if(!initialized) {
        print("wallet init failed");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to initialize Metamask"))
        );
        return;
      }

      final connectResponse = await connect();
      if (connectResponse == null) {
        print("Connect response null");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Metamask connection failed')),
        );
        return;
      }
      // Mở MetaMask app để xác thực (deep link)
      await onDisplayUri(connectResponse.uri);
      // Chờ user xác nhận kết nối
      final session = await authorize(connectResponse, "Authorize login");
      if (session == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("MetaMask authorization failed")),
        );
        return;
      }
      final walletAddress = session.namespaces[_chainMetadata.type]?.accounts.first.split(':').last;
      final topic = session.topic;
      print("✅ Connected wallet: $walletAddress");
      // Chuẩn bị dữ liệu cần ký (transaction hoặc message)
      const message = "Pay for NFT ticket order #12345";

      // Gửi request ký message (sign)
      final signature = await sendMessageForSigned(
        connectResponse,
        walletAddress!,
        topic,
        message,
      );
      if(signature == null) {
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User rejected signature")),
        );
        return;
      }
      // Xử lý hậu ký (thanh toán)
      // Ở đây bạn có thể gửi signature + walletAddress lên server để xác thực payment
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Payment successful!\nSig: ${signature.substring(0, 10)}...")),
      );
      // 8️⃣ Ngắt kết nối sau khi thanh toán xong
      await disconnectWallet(topic: topic);
      print("🔌 Disconnected from MetaMask");
    } catch (e, st) {
      print("⚠️ MetaMask payment error: $e\n$st");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Payment failed: $e")),
      );
    } 
  }
}
