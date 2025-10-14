import 'package:get/get.dart';

import '../views/reserve/reserve_binding.dart';
import '../views/reserve/reserve_view.dart';

class AppPages {
  static const initial = Routes.reserve;

  static final routes = [
    GetPage(
      name: Routes.reserve,
      page: () => const ReserveView(),
      binding: ReserveBinding(),
    ),
  ];
}

abstract class Routes {
  static const reserve = '/reserve';
}
