import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nft_ticket_event_ui/features/login/bloc/metamask_auth_bloc.dart';
import 'package:nft_ticket_event_ui/features/login/service/connect_service.dart';
import 'routes/app_page.dart';
import 'themes/app_theme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  initServices();
  runApp(const NFTTicketApp());
}
class NFTTicketApp extends StatelessWidget {
  const NFTTicketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MetaMaskAuthBloc(),
      child: GetMaterialApp(
        title: 'NFT Ticket',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        initialRoute: AppPages.initial,
        getPages: AppPages.routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}