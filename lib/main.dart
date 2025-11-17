import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nft_ticket_event_ui/features/login/bloc/metamask_auth_bloc.dart';
import 'package:nft_ticket_event_ui/features/login/repository/connect_service.dart';
import 'features/home/bloc/reserve_bloc.dart';
import 'features/home/repository/ticket_repository_impl.dart';
import 'routes/app_router.dart';
import 'themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initServices();
  runApp(const NFTTicketApp());
}
class NFTTicketApp extends StatelessWidget {
  const NFTTicketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MetaMaskAuthBloc()),
        BlocProvider(
          create: (_) => ReserveBloc(
            TicketRepositoryImpl(), // ← inject repo vào bloc
          )..add(ReserveEvent.loadTicket()), // ← event khởi tạo data
        ),
      ],
      child: MaterialApp.router(
        title: 'NFT Ticket',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
