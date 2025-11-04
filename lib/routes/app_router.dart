import 'package:go_router/go_router.dart';
import 'package:nft_ticket_event_ui/features/login/screens/metamask_login_screen.dart';
import 'package:nft_ticket_event_ui/features/login/screens/splash_screen.dart';
import 'package:nft_ticket_event_ui/features/tickets/ticket_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../features/home/reserve_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  redirect: (context, state) async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool("isLoggedIn") ?? false;

    // Nếu chưa login → vào màn hình Metamask
    if (!isLoggedIn && state.fullPath != '/metamaskLogin') {
      return '/metamaskLogin';
    }

    // Nếu đã login → luôn vào reserve
    if (isLoggedIn && state.fullPath == '/metamaskLogin') {
      return '/reserve';
    }

    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => const SplashScreen(),
    ),
    GoRoute(
      path: '/metamaskLogin',
      builder: (_, __) => const MetaMaskLoginScreen(),
    ),
    GoRoute(
      path: '/reserve',
      builder: (_, __) => const ReserveView(),
    ),
    // GoRoute(
    //   path: '/scan',
    //   builder: (_, __) => const TicketView(),
    // ),
  ],
);

