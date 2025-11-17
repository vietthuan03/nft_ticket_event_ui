import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'widgets/ticket_card.dart';
import 'bloc/reserve_bloc.dart';
import 'bloc/reserve_state.dart';

class ReserveView extends StatelessWidget {
  const ReserveView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReserveBloc, ReserveState>(
      builder: (context, state) {
        final isDark = state.isDark;

        return Scaffold(
          drawer: _buildMenu(context),
          appBar: AppBar(
            title: const Text("Reserve"),
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          backgroundColor: isDark
              ? const Color(0xFF0D1117)
              : const Color(0xFFF3F6FD),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () =>
                context.read<ReserveBloc>().add(ReserveEvent.toggleTheme()),
            label: Text(isDark ? "Light Mode" : "Dark Mode"),
            icon: Icon(isDark ? Icons.wb_sunny : Icons.nightlight_round),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: isDark ? const Color(0xFF161B22) : Colors.white,
            selectedItemColor: Colors.blueAccent,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.qr_code_2),
                label: 'Scan',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
          body: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Your Ticket",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (state.ticket != null)
                        TicketCard(ticket: state.ticket!),
                    ],
                  ),
                ),
        );
      },
    );
  }

  Drawer _buildMenu(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.purpleAccent],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(Icons.confirmation_number, color: Colors.white, size: 40),
                SizedBox(height: 10),
                Text(
                  "NFT Ticket",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Your digital ticket wallet",
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => context.go('/reserve'),
          ),
          ListTile(
            leading: const Icon(Icons.qr_code),
            title: const Text('My Tickets'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
