import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:group_project/model/taskDTO.dart';

class TaskRepo{

  static Future<void> addTask(TaskDTO taskData) async {
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc()
        .set(taskData.toMap());
  }
}