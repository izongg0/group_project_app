

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:group_project/model/teamDTO.dart';

class UserDTO {
  String? uid;
  String? email;
  String? userName;
  String? thumbnail;
  String? school;
  String? major;
  String? classnum;

  bool? emailVerified;
  List<String>? teams; // 팀 정보를 저장하는 리스트

  UserDTO({
    this.uid,
    this.email,
    this.userName,
    this.thumbnail,
    this.school,
    this.major,
    this.emailVerified,
    this.classnum,
    this.teams, // 팀 정보를 저장하는 리스트 필드 추가
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
      uid: json['uid'] == null ? '' : json['uid'] as String,
      email: json['email'] == null ? '' : json['email'] as String,
      userName: json['userName'] == null ? '' : json['userName'] as String,
      thumbnail: json['thumbnail'] == null ? '' : json['thumbnail'] as String,
      school: json['school'] == null ? '' : json['school'] as String,
      major: json['major'] == null ? '' : json['major'] as String,
      classnum: json['classnum'] == null ? '' : json['classnum'] as String,
      emailVerified:
          json['emailVerified'] == null ? false : json['emailVerified'] as bool,
      teams: json['teams'] == null ? [] : List<String>.from(json['teams']),
    );
  }
  factory UserDTO.DtofromJson(
      QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return UserDTO(
      uid: json['uid'] == null ? '' : json['uid'] as String,
      email: json['email'] == null ? '' : json['email'] as String,
      userName: json['userName'] == null ? '' : json['userName'] as String,
      thumbnail: json['thumbnail'] == null ? '' : json['thumbnail'] as String,
      school: json['school'] == null ? '' : json['school'] as String,
      major: json['major'] == null ? '' : json['major'] as String,
      classnum: json['classnum'] == null ? '' : json['classnum'] as String,
      emailVerified:
          json['emailVerified'] == null ? false : json['emailVerified'] as bool,
      teams: json['teams'] == null ? [] : List<String>.from(json['teams']),
    );
  }



  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'userName': userName,
      'thumbnail': thumbnail,
      'school' : school,
      'major' : major,
      'classnum':classnum,
      'emailVerified': emailVerified,
      'teams': teams, // 팀 정보를 저장하는 리스트 필드 추가
    };
  }

  UserDTO copyWith({
    String? uid,
    String? email,
    String? userName,
    String? thumbnail,
    String ? school,
    String? major,
    String? classnum,
    bool? emailVerified,
    List<String>? teams, // 팀 정보를 저장하는 리스트 필드 추가
  }) {
    return UserDTO(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      userName: userName ?? this.userName,
      thumbnail: thumbnail ?? this.thumbnail,
      school: school?? this.school,
      major: major?? this.major,
      classnum: classnum?? this.classnum,
      emailVerified: emailVerified ?? this.emailVerified,
      teams: teams ?? this.teams, 
    );
  }
}

  FirebaseAuth auth = FirebaseAuth.instance;


