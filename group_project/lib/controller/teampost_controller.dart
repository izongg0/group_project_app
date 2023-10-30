import 'package:get/get.dart';

import '../model/postDTO.dart';
import '../model/taskDTO.dart';
import '../model/teamDTO.dart';
import '../repository/post_repo.dart';

class TeamPostController extends GetxController {
  RxList<PostDTO> teamPost = RxList<PostDTO>();
    var currentTeamUid = "".obs;

  var currentTeam = TeamDTO().obs;
@override
   void onInit() {
    getTeamPost();
    super.onInit();
  }

 
  Future<List<PostDTO>> getTeamPost() async {
    // List<TaskDTO> teamTask = [];
    teamPost(await PostRepo.getTeamPost(currentTeamUid.value));
    return teamPost;
  }
}
