import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:group_project/model/taskDTO.dart';

import '../model/userDTO.dart';
import 'user_repo.dart';

class TaskRepo {
  static Future<void> addTask(TaskDTO taskData) async {
    

    var inputData = taskData.toMap();
    final collectionReference = FirebaseFirestore.instance.collection('tasks');

    final documentReference = await collectionReference.add(inputData);
    final String documentId = documentReference.id;
    inputData['taskUid'] = documentId;

    await documentReference.update(inputData);
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

  static Future<void> deleteTask(String taskUid) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    _firestore.collection('tasks').doc(taskUid).delete().then((_) {
      print("포스트 삭제 완료.");
    }).catchError((error) {
      print("포스트 삭제 중 오류 발생: $error");
      
    });
  }
}
