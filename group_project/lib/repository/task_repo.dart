import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:group_project/model/taskDTO.dart';

import '../model/userDTO.dart';
import 'user_repo.dart';

class TaskRepo {
  static Future<void> addTask(TaskDTO taskData) async {
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc()
        .set(taskData.toMap());
  }

  static Future<List<TaskDTO>> getMyTask() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('tasks')
        .where('masterUid', isEqualTo: auth.currentUser!.uid)
        .get();
    List<TaskDTO> taskList = [];

    for (var doc in querySnapshot.docs) {
      var transdata = TaskDTO.DtofromJson(
          doc as QueryDocumentSnapshot<Map<String, dynamic>>);

      taskList.add(transdata);
    }
    taskList.sort((a, b) => a.endDate!.compareTo(b.endDate!));

    return taskList;
  }

  static Future<List<TaskDTO>> getTeamTask(String teamUid) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('tasks')
        .where('teamUid', isEqualTo: teamUid)
        .get();
    List<TaskDTO> teamTaskList = [];

    for (var doc in querySnapshot.docs) {
      var transdata = TaskDTO.DtofromJson(
          doc as QueryDocumentSnapshot<Map<String, dynamic>>);

      teamTaskList.add(transdata);
    }
    teamTaskList.sort((a, b) => a.endDate!.compareTo(b.endDate!));

    return teamTaskList;
  }


}
