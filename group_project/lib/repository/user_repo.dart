import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:group_project/model/teamDTO.dart';

import '../model/userDTO.dart';

class UserRepo {
  static Future<List<UserDTO>> loadUserList() async {
    var document = FirebaseFirestore.instance.collection('users');
    var data = await document.get();
    return data.docs.map<UserDTO>((e) => UserDTO.fromJson(e.data())).toList();
  }

  static Future<List<UserDTO>> loadUserListByEmail(String email) async {
    var query = FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email);
    var querySnapshot = await query.get();

    return querySnapshot.docs
        .map<UserDTO>((e) => UserDTO.fromJson(e.data()))
        .toList();
  }

  static Future<UserDTO> getCurrentUserDTOByUid() async {
    var query = FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: auth.currentUser!.uid);
    var querySnapshot = await query.get();
    var currentUser = querySnapshot.docs
        .map<UserDTO>((e) => UserDTO.fromJson(e.data()))
        .toList();
    print(currentUser);

    return currentUser.first;
  }
}
  FirebaseAuth auth = FirebaseAuth.instance;
