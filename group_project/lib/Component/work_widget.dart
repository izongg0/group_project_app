import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';

enum WorkType { MY_WORK, GROUP_WORK }

class WorkCard extends StatelessWidget {
  final String teamName;
  final String description;
  final DateTime endDate;
  String? worker;
  final WorkType workType;
  bool? ismytask;
  final Function()? deletefunc;

  WorkCard({
    super.key,
    required String this.teamName,
    required String this.description,
    required DateTime this.endDate,
    this.worker = '홍길동',
    required this.workType,
    this.ismytask = false,
    this.deletefunc
  });

  Widget _mywork() {
    var currentTime = DateTime.now();
    var akrka = currentTime.difference(endDate);

    if (currentTime.day == endDate.day) {
      akrka = Duration.zero;
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        // height: 65,
        width: 400,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.9),
            spreadRadius: 0,
            blurRadius: 2.0,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ], borderRadius: BorderRadius.circular(10), color: Color(0xffE6E7FB)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                teamName,
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(
                height: 3,
              ),
              Text(description),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (currentTime.day == endDate.day &&
                          currentTime.month == endDate.month &&
                          currentTime.year == endDate.year) ...[
                        Text('Today',
                            style: TextStyle(
                              fontSize: 10,
                            ))
                      ] else ...[
                        Text('마감 ${-(akrka.inDays - 1)}일 전',
                            style: TextStyle(
                              fontSize: 10,
                            )),
                      ],
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _groupWork() {
    var currentTime = DateTime.now();
    var akrka = currentTime.difference(endDate);
    var dday = -(akrka.inDays - 1);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
      child: Container(
        // height: 65,
        width: 400,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 33, 32, 32).withOpacity(0.9),
            spreadRadius: 0,
            blurRadius: 2.0,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ], borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '담당자 : ${worker}',
                    style: TextStyle(fontSize: 13),
                  ),
                  if(ismytask == true)
                  GestureDetector(
                    onTap: deletefunc,
                    child: Text(
                      'x',
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 7,
              ),
              Text(description),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('~ ${DateFormat('yyyy-MM-dd  HH:mm:ss').format(endDate)}',
                      style: TextStyle(
                        fontSize: 12,
                      )),
                  SizedBox(
                    width: 7,
                  ),
                  if (currentTime.day == endDate.day &&
                      currentTime.month == endDate.month &&
                      currentTime.year == endDate.year) ...[
                    Text('Today',
                        style: TextStyle(
                          fontSize: 12,
                        ))
                  ] else ...[
                    if(dday < 0)
                    Text('마감',
                        style: TextStyle(
                          fontSize: 12,
                        ))
                    else
                    Text('마감 ${dday}일 전',
                        style: TextStyle(
                          fontSize: 12,
                        )),
                  ],
                  // Text('마감 ${-(akrka.inDays-1)}일 전',
                  //     style: TextStyle(
                  //       fontSize: 12,
                  //     )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (workType) {
      case WorkType.MY_WORK:
        return _mywork();
      case WorkType.GROUP_WORK:
        return _groupWork();
    }
  }
}
