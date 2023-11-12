import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:group_project/model/postDTO.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../model/CommentDTO.dart';

class PostRepo {
  static Future<void> addPost(PostDTO postdata, List<XFile> imageList) async {
    var inputData = postdata.toMap();
    final collectionReference = FirebaseFirestore.instance.collection('posts');

    final documentReference = await collectionReference.add(inputData);
    final String documentId = documentReference.id;
    inputData['postUid'] = documentId;

    List<String> imageinputList = [];
    for (int i = 0; i < imageList.length; i++) {
      File file = File(imageList[i].path);
      String fileName =
          "${DateTime.now().millisecondsSinceEpoch.toString()}_$i";
      imageinputList.add(fileName);
      try {
        // 이미지를 Firebase Storage에 업로드
        await firebase_storage.FirebaseStorage.instance
            .ref('images/$documentId/$fileName.jpg')
            .putFile(file);

        print('Uploaded: $fileName.jpg');
      } on firebase_storage.FirebaseException catch (e) {
        print('Error uploading image: $e');
      }
    }
    inputData['imageList'] = imageinputList;

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

static Future<List<String>> loadImageUrls(String teamUid) async {
    try {
      // Firebase Storage 경로 설정

      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('images/$teamUid/');

      // 해당 경로에 있는 모든 파일 및 폴더 목록을 가져옴
      firebase_storage.ListResult result = await ref.listAll();
      List<String> urls = [];

      // 가져온 목록에서 파일만 필터링하여 URL 목록에 추가
      for (var item in result.items) {
        String url = await item.getDownloadURL();
        urls.add(url);
      }
      print("이미지리스트${urls}");
          return urls;


    } catch (e) {
      print('Error loading image URLs: $e');
      return [];
    }
  }

static Future<void> deleteComment(String commentUid) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    _firestore.collection('comments').doc(commentUid).delete().then((_) {
      print("댓글 삭제 완료.");
    }).catchError((error) {
      print("댓글 삭제 중 오류 발생: $error");
      
    });
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

  static Future<void> deletePost(String postUid) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    Query querypost =
        _firestore.collection('comments').where('postUid', isEqualTo: postUid);

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

    _firestore.collection('posts').doc(postUid).delete().then((_) {
      print("포스트 삭제 완료.");
    }).catchError((error) {
      print("포스트 삭제 중 오류 발생: $error");
    });
  }
}
