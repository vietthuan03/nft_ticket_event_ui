import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReserveController extends GetxController {
  final announcement = "We are going live in July!".obs;
  final ticketTitle = "The Garden City".obs;
  final ticketDesc = "Bengaluru, the Silicon Valley of India.".obs;
  final ticketDate = "10/06/2022".obs;
  final ticketImage = "assets/images/ticket.png".obs;
  var isDarkMode = false.obs;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(
      isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
