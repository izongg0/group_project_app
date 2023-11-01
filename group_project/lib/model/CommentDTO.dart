import 'package:cloud_firestore/cloud_firestore.dart';

class CommentDTO {
  final String? commentUid;
  final String? masterUid;
  final String? masterName;
  final String? postUid;
  final String? userThumb;
  final String? comment;
  final DateTime? date;

  CommentDTO({
    this.commentUid,
    this.masterUid,
    this.masterName,
    this.postUid,
    this.userThumb,
    this.comment,
    this.date,
  });

  factory CommentDTO.fromJson(Map<String, dynamic> json) {
    return CommentDTO(
      commentUid:
          json['commentUid'] == null ? '' : json['commentUid'] as String,
      masterUid: json['masterUid'] == null ? '' : json['masterUid'] as String,
      masterName:
          json['masterName'] == null ? '' : json['masterName'] as String,
      postUid: json['postUid'] == null ? '' : json['postUid'] as String,
      userThumb: json['userThumb'] == null ? '' : json['userThumb'] as String,
      comment: json['comment'] == null ? '' : json['comment'] as String,
      date: json['date'] == null ? DateTime.now() : json['date'].toDate(),
    );
  }

  factory CommentDTO.DtofromJson(
      QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return CommentDTO(
      commentUid:
          json['commentUid'] == null ? '' : json['commentUid'] as String,
      masterUid: json['masterUid'] == null ? '' : json['masterUid'] as String,
      masterName:
          json['masterName'] == null ? '' : json['masterName'] as String,
      postUid: json['postUid'] == null ? '' : json['postUid'] as String,
      userThumb: json['userThumb'] == null ? '' : json['userThumb'] as String,
      comment: json['comment'] == null ? '' : json['comment'] as String,
      date: json['date'] == null ? DateTime.now() : json['date'].toDate(),
    );
  }

  // 미리 생성된 현재 로그인한 사용자의 정보가 담긴 Post객체에다가 새로 등록할 게시글의 내용을 담아주기 위해서.
  CommentDTO copyWith({
    String? commentUid,
    String? masterUid,
    String? masterName,
    String? postUid,
    String? userThumb,
    String? comment,
    DateTime? date,
  }) {
    return CommentDTO(
      commentUid: commentUid ?? this.commentUid,
      masterUid: masterUid ?? this.masterUid,
      masterName: masterName ?? this.masterName,
      postUid: postUid ?? this.postUid,
      userThumb: userThumb ?? this.userThumb,
      comment: comment ?? this.comment,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'commentUid': commentUid,
      'masterUid': masterUid,
      'masterName': masterName,
      'postUid': postUid,
      'userThumb': userThumb,
      'comment': comment,
      'date': date,
    };
  }
}
