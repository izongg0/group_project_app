import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:group_project/model/postDTO.dart';

class PostRepo{

static Future<void> addTask(PostDTO postdata) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc()
        .set(postdata.toMap());
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