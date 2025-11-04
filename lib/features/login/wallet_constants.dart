import '../../models/chain_metadata.dart';

class WalletConstants {
  static const mainChainMetaData = ChainMetadata(
    type: "eip155",
    chainId: 'eip155:1',
    name: 'Ethereum',
    method: "personal_sign",
    events: ["chainChanged", "accountsChanged"],
    relayUrl: "wss://relay.walletconnect.com",
    projectId: "7ef0a1cec762b458b8e8e74709eb323f",
    redirectUrl: "metamask://com.example.nft_ticket_event_ui",
    walletConnectUrl: "https://walletconnect.com",
  );
  static const deepLinkMetamask = "metamask://wc?uri=";
}
