import 'package:flutter/material.dart';

import '../component/popup_widget.dart';
import '../component/purple_button.dart';

class AddSchedule extends StatefulWidget {
  AddSchedule({super.key});

  @override
  State<AddSchedule> createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  DateTime _endSelectedDate = DateTime.now();

  TimeOfDay endSelectedTime = TimeOfDay.now();

  void unfocusKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

// https://api.flutter.dev/flutter/cupertino/CupertinoDatePicker-class.html

  Future<void> _endSelectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: _endSelectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
        locale: const Locale('ko', 'KR'));

    if (pickedDate != null && pickedDate != _endSelectedDate) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: endSelectedTime,
      );

      if (pickedTime != null) {
        setState(() {
          _endSelectedDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: unfocusKeyboard,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          elevation: 0,
          backgroundColor: Color(0xffF9F8F8),
          title: Text(
            '업무 생성',
            style: TextStyle(color: Colors.black, fontSize: 17),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                '업무',
              ),
              SizedBox(
                height: 7,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffD9D9D9)),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '마감일',
              ),
              SizedBox(
                height: 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xffD9D9D9)),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      height: 30,
                      width: 230,
                      child: Text(_endSelectedDate.toString())),
                  SizedBox(
                    // width: 250,
                    height: 30,
                    child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Color(0xffE6E7FB)),
                        onPressed: () {
                          _endSelectDateTime(context);
                        },
                        child: Text(
                          '날짜 선택',
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '담당자',
              ),
              SizedBox(
                height: 7,
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: PurpleButton(
                    ontap: () {
                      showDialog(
                          context: context,
                          builder: (context) => PopupWidget(
                              content: '생성 하시겠습니까?',
                              okfunc: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              nofunc: () {
                                Navigator.pop(context);
                              }));
                    },
                    buttonText: '생성',
                    buttonWidth: 300),
              )
            ],
          ),
        ),
      ),
    );
  }
}
