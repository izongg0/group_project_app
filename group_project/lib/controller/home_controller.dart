import 'package:get/get.dart';
import 'package:group_project/model/teamDTO.dart';
import 'package:group_project/repository/user_repo.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin{

  // RxList<dynamic> myTeamList = RxList<dynamic>();
  RxMap<String,TeamDTO> myTeamMap = RxMap<String,TeamDTO>();

void onInit() {
    super.onInit();
    getMyTeam();
  }

Future<void> getMyTeam() async {

  myTeamMap(await UserRepo.getYourTeams());

}


}