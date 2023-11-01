import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:group_project/model/postDTO.dart';

import '../model/CommentDTO.dart';

class PostRepo {
  static Future<void> addTask(PostDTO postdata) async {
    var inputData = postdata.toMap();
    final collectionReference = FirebaseFirestore.instance.collection('posts');

    final documentReference = await collectionReference.add(inputData);
    final String documentId = documentReference.id;
    inputData['postUid'] = documentId;

    await documentReference.update(inputData);
  }

  static Future<void> addComment(CommentDTO commentdata) async {
    var inputData = commentdata.toMap();
    final collectionReference =
        FirebaseFirestore.instance.collection('comments');

    final documentReference = await collectionReference.add(inputData);
    final String documentId = documentReference.id;
    inputData['commentUid'] = documentId;

    await documentReference.update(inputData);
  }

  static Future<List<CommentDTO>> getComment(String postUid) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('comments')
        .where('postUid', isEqualTo: postUid)
        .get();

    List<CommentDTO> commentList = [];

    for (var doc in querySnapshot.docs) {
      var transdata = CommentDTO.DtofromJson(
          doc as QueryDocumentSnapshot<Map<String, dynamic>>);

      commentList.add(transdata);
    }
    commentList.sort((a, b) => a.date!.compareTo(b.date!));

    return commentList;
  }

  static Future<List<PostDTO>> getTeamPost(String teamUid) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('posts')
        .where('teamUid', isEqualTo: teamUid)
        .get();

    List<PostDTO> teamTaskList = [];

    for (var doc in querySnapshot.docs) {
      var transdata = PostDTO.DtofromJson(
          doc as QueryDocumentSnapshot<Map<String, dynamic>>);

      teamTaskList.add(transdata);
    }
    teamTaskList.sort((a, b) => b.postDate!.compareTo(a.postDate!));

    return teamTaskList;
  }
}
