import 'package:flutter/material.dart';
import 'package:group_project/Component/purple_button.dart';
import 'package:group_project/page/home.dart';

class AddTeam extends StatefulWidget {
  const AddTeam({super.key});

  @override
  State<AddTeam> createState() => _AddTeamState();
}

class _AddTeamState extends State<AddTeam> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  DateTime _endSelectedDate = DateTime.now();
  TimeOfDay endSelectedTime = TimeOfDay.now();

  Future<void> _StartSelectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
        locale: const Locale('ko', 'KR'));

    if (pickedDate != null && pickedDate != _selectedDate) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime,
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDate = DateTime(
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
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Color(0xffF9F8F8),
        title: Text(
          '팀 생성',
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '팀명',
            ),
            SizedBox(
              height: 7,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffD9D9D9)),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5)),
              height: 30,
              width: 300,
              child: TextField(
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '과제 설명',
            ),
            SizedBox(
              height: 7,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffD9D9D9)),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5)),
              height: 150,
              width: 300,
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 7,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '시작일',
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
                    child: Text(_selectedDate.toString())),
                SizedBox(
                  // width: 250,
                  height: 30,
                  child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Color(0xffE6E7FB)),
                      onPressed: () {
                        _StartSelectDateTime(context);
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
              '팀원',
            ),
            SizedBox(
              height: 15,
            ),
            PurpleButton(
              ontap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Home()));
              },
              buttonText: '생성',
              buttonWidth: 100,
              buttonHeight: 25,
            )
          ],
        ),
      ),
    );
  }
}
