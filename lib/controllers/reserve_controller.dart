import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nft_ticket_event_ui/themes/app_theme.dart';

class ReserveController extends GetxController {
  final announcement = "We are going live in July!".obs;
  final ticketTitle = "The Garden City".obs;
  final ticketLocation = "Bengaluru, the Silicon Valley of India.".obs;
  final ticketDesc = "Bengaluru (also called Bangalore) is the center of India's high-tech industry. The city is also known for its parks and nightlife".obs;
  final ticketDate = "10/06/2022".obs;
  final ticketImage = "assets/images/ticket.png".obs;
  var isDarkMode = false.obs;

  var currentIndex = 0.obs;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeTheme( isDarkMode.value ? AppTheme.darkTheme : AppTheme.lightTheme);
  }
}
