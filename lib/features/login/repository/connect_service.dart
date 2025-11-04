import 'package:get_it/get_it.dart';
import 'package:nft_ticket_event_ui/features/login/repository/metamask_connector_impl.dart';
import 'package:nft_ticket_event_ui/features/login/repository/wallet_connector_service.dart';

final getIt = GetIt.instance;
initServices() {
  getIt.registerSingleton<WalletConnectorRepo>(MetamaskConnectorRepoImpl());
}

WalletConnectorRepo get walletConnectorService => getIt.get();
