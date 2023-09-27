import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:group_project/app.dart';
import 'package:group_project/controller/home_controller.dart';

import '../component/popup_widget.dart';
import '../model/teamDTO.dart';
import '../model/userDTO.dart';
import '../page/home.dart';
import '../repository/team_repo.dart';
import '../repository/user_repo.dart';

class AddTeamController extends GetxController {
  // 날짜 선택
  Rx<DateTime> selectedDate = DateTime.now().obs; // 이거사용
  Rx<TimeOfDay> selectedTime = TimeOfDay.now().obs;

  Rx<DateTime> endSelectedDate = DateTime.now().obs; // 이거사용
  Rx<TimeOfDay> endSelectedTime = TimeOfDay.now().obs;

  TextEditingController inputTeamNameController = TextEditingController();
  TextEditingController inputDesController = TextEditingController();
  // 날짜 선택 끝

  RxList<UserDTO> items = RxList<UserDTO>();
  RxList<String> uidList = RxList<String>();
  TextEditingController inputMember = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  @override // stateless의 initState 대신 사용함.
  void onInit() {
    super.onInit();
    items.clear();
    uidList.clear();
    uidList = [auth.currentUser!.uid].obs;
  }

  @override
  Future<List<UserDTO>> searchMember(String email) async {
    var resultSearch = await UserRepo.loadUserListByEmail(email);
    if (resultSearch.isNotEmpty) {
      if (uidList.contains(resultSearch.first.uid)) {
        Fluttertoast.showToast(
          msg: "이미 추가한 팀원입니다.",
          toastLength: Toast
              .LENGTH_SHORT, // Toast 메시지 표시 시간 설정 (Toast.LENGTH_SHORT 또는 Toast.LENGTH_LONG)
          gravity:
              ToastGravity.BOTTOM, // Toast 메시지의 위치 설정 (TOP, CENTER, BOTTOM)
          timeInSecForIosWeb: 1, // iOS 및 웹 플랫폼에서 Toast 메시지를 표시하는 시간 설정
          backgroundColor: Colors.black, // 배경색 설정
          textColor: Colors.white, // 텍스트 색상 설정
          fontSize: 16.0, // 폰트 크기 설정
        );
      } else {
        uidList.add(resultSearch.first.uid!);
        items.add(resultSearch.first);
      }
    } else {
      Fluttertoast.showToast(
        msg: "존재하지 않는 이메일입니다.",
        toastLength: Toast
            .LENGTH_SHORT, // Toast 메시지 표시 시간 설정 (Toast.LENGTH_SHORT 또는 Toast.LENGTH_LONG)
        gravity: ToastGravity.BOTTOM, // Toast 메시지의 위치 설정 (TOP, CENTER, BOTTOM)
        timeInSecForIosWeb: 1, // iOS 및 웹 플랫폼에서 Toast 메시지를 표시하는 시간 설정
        backgroundColor: Colors.black, // 배경색 설정
        textColor: Colors.white, // 텍스트 색상 설정
        fontSize: 16.0, // 폰트 크기 설정
      );
    }

    return await UserRepo.loadUserListByEmail(email);
  }

  void unfocusKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Future<void> StartSelectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
        locale: const Locale('ko', 'KR'));

    if (pickedDate != null && pickedDate != selectedDate.value) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime.value,
      );

      if (pickedTime != null) {
        selectedDate(DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        ));
      }
    }
  }

  Future<void> ismake() async {
    showDialog(
        context: Get.context!,
        builder: (context) => PopupWidget(
            content: '생성 하시겠습니까?',
            okfunc: () async {
              print(items);
              var teamData = TeamDTO(
                  masterUid: auth.currentUser?.uid,
                  teamName: inputTeamNameController.text,
                  description: inputDesController.text,
                  startDate: selectedDate.value,
                  endDate: endSelectedDate.value,
                  members: uidList);

              await TeamRepo.addTeam(teamData);
              Navigator.pop(context);
              

              Get.until((route) => Get.currentRoute == '/');
            },
            nofunc: () {
              Navigator.pop(context);
            }));
  }

  Future<void> endSelectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: endSelectedDate.value,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
        locale: const Locale('ko', 'KR'));

    if (pickedDate != null && pickedDate != endSelectedDate.value) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: endSelectedTime.value,
      );

      if (pickedTime != null) {
        endSelectedDate(DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        ));
      }
    }
  }
}
