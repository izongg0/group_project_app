import 'package:get/get.dart';
import 'package:group_project/controller/addteam_controller.dart';

import '../controller/nav_controller.dart';

class InitBining extends Bindings {
  void dependencies() {
    Get.put(BottomNavController(),
        // 앱이 종료되기 전까지 이 인스턴스는 살아있음.
        permanent: true);

  }
}