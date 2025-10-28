import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/reserve_controller.dart';
import '../widgets/ticket_card.dart';

class TicketView extends GetView<ReserveController> {
  const TicketView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Tickets'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: theme.iconTheme.color),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() => SingleChildScrollView(
              child: TicketCard(
                title: controller.ticketTitle.value,
                description: controller.ticketDesc.value,
                location: controller.ticketLocation.value,
                date: controller.ticketDate.value,
                imageUrl: controller.ticketImage.value,
                showBuyButton: true,
              ),
            )),
      ),
    );
  }
}
