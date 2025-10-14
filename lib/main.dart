import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'routes/app_page.dart';
import 'themes/app_theme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const NFTTicketApp());
}
class NFTTicketApp extends StatelessWidget {
  const NFTTicketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'NFT Ticket',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}