import 'dart:ui';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:nft_ticket_event_ui/data/data_provider.dart';
import 'package:nft_ticket_event_ui/presentation/home/pages/bottomnav.dart';
import 'package:nft_ticket_event_ui/presentation/home/pages/home_screen.dart';
import 'package:nft_ticket_event_ui/presentation/home/provider/event_provider.dart';
import 'package:nft_ticket_event_ui/presentation/login_screen/pages/login_screen.dart';
import 'package:nft_ticket_event_ui/presentation/login_screen/pages/onboarding.dart';
import 'package:nft_ticket_event_ui/presentation/login_screen/provider/user_provider.dart';
import 'package:nft_ticket_event_ui/presentation/login_screen/pages/signUp_screen.dart';
import 'package:nft_ticket_event_ui/ticket_main.dart';
import 'utility/app_theme.dart';
import 'utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataProvider()),
        ChangeNotifierProvider(
          create: (context) => UserProvider(context.dataProvider),
        ),

      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = context.userProvider.isLoggedIn;
  
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
      ),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: isLoggedIn ? Bottomnav() : const Onboarding(),
    );
  }
}
