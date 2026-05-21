import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:nft_ticket_event_ui/presentation/home/pages/home_screen.dart';
import 'package:nft_ticket_event_ui/presentation/profile/pages/profile.dart';

import '../../booking/pages/my_tickets_page.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  late final List<Widget> pages;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    pages = [HomeScreen(), MyTicketsPage(), Profile()];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: theme.colorScheme.surface,
        color: theme.primaryColor,
        buttonBackgroundColor: theme.primaryColor,
        animationDuration: const Duration(milliseconds: 500),
        items: [
          Icon(
            Icons.home_outlined,
            color: theme.colorScheme.onPrimary,
            size: 30,
          ),
          Icon(Icons.book_online, color: theme.colorScheme.onPrimary, size: 30),
          Icon(Icons.person, color: theme.colorScheme.onPrimary, size: 30),
        ],
        onTap: (index) {
          setState(() => currentIndex = index);
        },
      ),
    );
  }
}
