// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/reserve_controller.dart';
import '../widgets/ticket_card.dart';

class ReserveView extends GetView<ReserveController> {
  const ReserveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = controller.isDarkMode.value;

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
        backgroundColor: isDark ? const Color(0xFF0D1117) : const Color(0xFFF3F6FD),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _announcementCard(isDark),
              const SizedBox(height: 20),
              const Text("Your Ticket",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
              const SizedBox(height: 10),
              // _ticketCard(isDark),
              Obx(() => TicketCard(
                title: controller.ticketTitle.value,
                description: controller.ticketDesc.value,
                date: controller.ticketDate.value,
                imageUrl: controller.ticketImage.value, location: '',
              )),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: controller.toggleTheme,
          label: Text(isDark ? "Light Mode" : "Dark Mode"),
          icon: Icon(isDark ? Icons.wb_sunny : Icons.nightlight_round),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: isDark ? const Color(0xFF161B22) : Colors.white,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.qr_code_2), label: 'Scan'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      );
    });
  }
  Widget _announcementCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [Colors.blueAccent.withOpacity(0.3), Colors.deepPurpleAccent.withOpacity(0.3)]
              : [Colors.lightBlue.shade100, Colors.blue.shade50],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.campaign, color: Colors.blueAccent),
          const SizedBox(width: 10),
          Expanded(
            child: Obx(() => Text(
                  controller.announcement.value,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                )),
          ),
          const Icon(Icons.close, size: 16, color: Colors.grey),
        ],
      ),
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
                Text("NFT Ticket",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                Text("Your digital ticket wallet",
                    style: TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => Get.back(),
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
