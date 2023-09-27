import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/teamDTO.dart';

class TeamRepo {
  static Future<void> addTeam(TeamDTO teamData) async {
    await FirebaseFirestore.instance
        .collection('teams')
        .doc()
        .set(teamData.toMap());
  }
}
