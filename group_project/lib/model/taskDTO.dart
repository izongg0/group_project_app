import 'package:cloud_firestore/cloud_firestore.dart';

class TaskDTO {
  final String? masterUid;
  final String? masterName;
  final String? taskUid;

  final String? teamUid;
  final String? teamName;
  final String? description;
  final DateTime? endDate;
  List<String>? members;

  TaskDTO(
      {this.masterUid,
      this.masterName,
      this.taskUid,
      this.teamUid,
      this.teamName,
      this.description,
      this.endDate,
      this.members});

  factory TaskDTO.fromJson(Map<String, dynamic> json) {
    return TaskDTO(
      masterUid: json['masterUid'] == null ? '' : json['masterUid'] as String,
      masterName:
          json['masterName'] == null ? '' : json['masterName'] as String,
      taskUid: json['taskUid'] == null ? '' : json['taskUid'] as String,
      teamUid: json['teamUid'] == null ? '' : json['teamUid'] as String,
      teamName: json['teamName'] == null ? '' : json['teamName'] as String,
      description:
          json['description'] == null ? '' : json['description'] as String,
      endDate:
          json['endDate'] == null ? DateTime.now() : json['endDate'].toDate(),
      members:
          json['members'] == null ? [] : List<String>.from(json['members']),
    );
  }

  factory TaskDTO.DtofromJson(
      QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return TaskDTO(
      masterUid: json['masterUid'] == null ? '' : json['masterUid'] as String,
      masterName:
          json['masterName'] == null ? '' : json['masterName'] as String,
      taskUid: json['taskUid'] == null ? '' : json['taskUid'] as String,
      teamUid: json['teamUid'] == null ? '' : json['teamUid'] as String,
      teamName: json['teamName'] == null ? '' : json['teamName'] as String,
      description:
          json['description'] == null ? '' : json['description'] as String,
      endDate:
          json['endDate'] == null ? DateTime.now() : json['endDate'].toDate(),
      members:
          json['members'] == null ? [] : List<String>.from(json['members']),
    );
  }

  // 미리 생성된 현재 로그인한 사용자의 정보가 담긴 Post객체에다가 새로 등록할 게시글의 내용을 담아주기 위해서.
  TaskDTO copyWith(
      {String? masterUid,
      String? masterName,
      String? teamUid,
      String? teamName,
      String? description,
      DateTime? endDate,
      List<String>? members}) {
    return TaskDTO(
      masterUid: masterUid ?? this.masterUid,
      masterName: masterName ?? this.masterName,
      teamUid: teamUid ?? this.teamUid,
      teamName: teamName ?? this.teamName,
      description: description ?? this.description,
      endDate: endDate ?? this.endDate,
      members: members ?? this.members,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'masterUid': masterUid,
      'masterName': masterName,
      'taskUid': taskUid,
      'teamUid': teamUid,
      'teamName': teamName,
      'description': description,
      'endDate': endDate,
      'members': members,
    };
  }
}
