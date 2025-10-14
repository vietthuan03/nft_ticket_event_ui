import 'package:get/get.dart';

import '../../controllers/reserve_controller.dart';

class ReserveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReserveController>(() => ReserveController());
  }
  

}
