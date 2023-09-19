import 'package:flutter/material.dart';
import 'package:group_project/component/board_item.dart';

class TeamBoard extends StatelessWidget {
  const TeamBoard({super.key});

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
          '게시판',
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height-120,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('팀 이름'),
                      SizedBox(
                        height: 30,
                      ),
                      ...List.generate(
                          4,
                          (index) => BoardItem(
                              title: '오ㅏ이어프레임 제작',
                              nickname: 'izongg',
                              date: '9/15')),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                                width: 1.0,
                                color: const Color.fromARGB(
                                    255, 194, 194, 194)), // 위쪽 테두리
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: []),
                        ),
                      )
                    ]),
              ),
            ),
          ),
          Positioned(
              right: 13,
              bottom: 50,
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.add_box_outlined),
                iconSize: 35,
              ))
        ],
      ),
    );
  }
}
