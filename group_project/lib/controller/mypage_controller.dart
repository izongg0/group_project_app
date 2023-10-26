import 'package:get/get.dart';
import 'package:group_project/repository/user_repo.dart';

import '../model/userDTO.dart';

class MyPageController extends GetxController {

  var currentMan = UserDTO().obs;


 void onInit() {
    super.onInit();
  getCurrentUser();
  }


  Future<void> getCurrentUser() async {
  
  
      currentMan(await UserRepo.getCurrentUserDTOByUid());

      
  }

}