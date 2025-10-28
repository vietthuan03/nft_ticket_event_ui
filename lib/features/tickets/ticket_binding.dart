import 'package:get/get.dart';
import 'package:nft_ticket_event_ui/controllers/reserve_controller.dart';

class TicketBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReserveController>(() => ReserveController());
  }
}