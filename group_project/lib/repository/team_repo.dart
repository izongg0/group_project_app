import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:group_project/model/userDTO.dart';

import '../model/teamDTO.dart';
import 'user_repo.dart';

class TeamRepo {
  static Future<void> addTeam(TeamDTO teamData) async {
    var inputData = teamData.toMap();
    final collectionReference = FirebaseFirestore.instance.collection('teams');

    final documentReference = await collectionReference.add(inputData);
    final String documentId = documentReference.id;
    inputData['teamUid'] = documentId;

    await documentReference.update(inputData);

    // await FirebaseFirestore.instance
    //     .collection('teams')
    //     .doc()
    //     .set(teamData.toMap());
  }

  static Future<void> updateMemberData(
      String teamUid, List<String> members) async {
    // Firestore 인스턴스 초기화
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // 'members' 컬렉션의 문서 이름이 'aaa'인 데이터를 수정
      await firestore.collection('teams').doc(teamUid).update({
        'members': members, // 필드 이름과 업데이트할 값으로 변경
      });

      print('Document updated successfully!');
    } catch (e) {
      print('Error updating document: $e');
    }
  }

  static Future<TeamDTO> getTeamfromUid(String teamUid) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('teams')
        .where('teamUid', isEqualTo: teamUid)
        .get();
    List<TeamDTO> teamList = [];

    for (var doc in querySnapshot.docs) {
      var transdata = TeamDTO.DtofromJson(
          doc as QueryDocumentSnapshot<Map<String, dynamic>>);

      teamList.add(transdata);
    }

    return teamList.first;
  }

  // 자기가 속해있는 팀 리스트를 가져오는 함수
  static Future<Map<String, TeamDTO>> getYourTeams() async {
    // 'teams' 컬렉션에서 'members' 배열에 본인의 UID가 포함된 문서를 쿼리합니다.
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('teams')
        .where('members', arrayContains: auth.currentUser!.uid)
        .get();
    // List<TeamDTO> teamList = [];
    Map<String, TeamDTO> teamMap = {};
    // List<String> teamUidList = [];
    // List<dynamic> teamSet = [teamList,teamUidList];
    for (var doc in querySnapshot.docs) {
      var transdata = TeamDTO.DtofromJson(
          doc as QueryDocumentSnapshot<Map<String, dynamic>>);
      teamMap[doc.id] = transdata;
      // teamList.add(transdata);
      // print(teamList);
    }
    // print(teamMap);
    return teamMap;
  }

  static Future<List<UserDTO>> getTeamMembers(List<String> memberList) async {
    List<UserDTO> userList = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', whereIn: memberList)
        .get();

    for (var doc in querySnapshot.docs) {
      var transdata = UserDTO.DtofromJson(
          doc as QueryDocumentSnapshot<Map<String, dynamic>>);
      userList.add(transdata);
    }
    // print(userList);

    return userList;
  }

  static Future<void> editNotice(String teamUid, String notice) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    _firestore.collection('teams').doc(teamUid).update({
      'notice': notice,
      // 다른 필드 업데이트도 추가할 수 있습니다.
    }).then((_) {
      print("문서 업데이트 성공");
    }).catchError((error) {
      print("문서 업데이트 실패: $error");
    });
  }

  static Future<void> deleteTeam(String teamUid) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    Query querypost =
        _firestore.collection('posts').where('teamUid', isEqualTo: teamUid);

    querypost.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((document) {
        // 각 문서를 삭제합니다.
        document.reference.delete().then((_) {
          print("포스트가 성공적으로 삭제되었습니다.");
        }).catchError((error) {
          print("데이터 삭제 중 오류 발생: $error");
        });
      });
    }).catchError((error) {
      print("데이터 조회 중 오류 발생: $error");
    });

    Query querytask =
        _firestore.collection('tasks').where('teamUid', isEqualTo: teamUid);

    querytask.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((document) {
        // 각 문서를 삭제합니다.
        document.reference.delete().then((_) {
          print("과업가 성공적으로 삭제되었습니다.");
        }).catchError((error) {
          print("데이터 삭제 중 오류 발생: $error");
        });
      });
    }).catchError((error) {
      print("데이터 조회 중 오류 발생: $error");
    });

    _firestore.collection('teams').doc(teamUid).delete().then((_) {
      print("팀 삭제 완료.");
    }).catchError((error) {
      print("팀 삭제 중 오류 발생: $error");
    });
  }

// 문서 업데이트
  void updateData() {}
}
