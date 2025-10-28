import 'package:get_it/get_it.dart';
import 'package:nft_ticket_event_ui/features/login/service/metamask_connector_impl.dart';
import 'package:nft_ticket_event_ui/features/login/service/wallet_connector_service.dart';

final getIt = GetIt.instance;
initServices() {
  getIt.registerSingleton<WalletConnectorService>(MetamaskConnectorImpl());
}

WalletConnectorService get walletConnectorService => getIt.get();
