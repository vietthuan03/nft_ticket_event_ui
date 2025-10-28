import 'package:get/get.dart';
import 'package:nft_ticket_event_ui/features/login/screen/splash_screen.dart';
import 'package:nft_ticket_event_ui/features/tickets/ticket_view.dart';
import '../features/reserve/reserve_binding.dart';
import '../features/reserve/reserve_view.dart';
import '../features/tickets/ticket_binding.dart';

class AppPages {
  static const initial = Routes.splashRoute;

  static final routes = [
    GetPage(
      name: Routes.splashRoute,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.reserveRoute,
      page: () => const ReserveView(),
      binding: ReserveBinding(),
    ),
    GetPage(
      name: Routes.scanRoute,
      page: () => const TicketView(),
      binding: TicketBinding(),
    ),
  ];
}

abstract class Routes {
  static const splashRoute = '/splash';
  static const reserveRoute = '/reserve';
  static const scanRoute  = '/scan';
}
