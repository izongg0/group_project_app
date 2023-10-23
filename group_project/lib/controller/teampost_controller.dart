import 'package:get/get.dart';
import 'package:group_project/repository/task_repo.dart';

import '../model/postDTO.dart';
import '../model/taskDTO.dart';
import '../model/teamDTO.dart';
import '../repository/post_repo.dart';

class TeamPostController extends GetxController {
  RxList<PostDTO> teamPost = RxList<PostDTO>();
  var currentTeam = TeamDTO();

  Future<List<PostDTO>> getTeamPost(String teamUid) async {
    List<TaskDTO> teamTask = [];
    teamPost(await PostRepo.getTeamPost(teamUid));
    return teamPost;
  }
}
