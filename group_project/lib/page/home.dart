import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  Widget _myWork() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 38),
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('나의 할일'), Icon(Icons.more_horiz)],
            ),
            SizedBox(height: 8,),
            ...List.generate(
                3,
                (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        height: 50,
                        width: 400,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.9),
                                spreadRadius: 0,
                                blurRadius: 2.0,
                                offset:
                                    Offset(0, 1), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffE6E7FB)),
                        child: Text("aaa"),
                      ),
                    ))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: 80,
        ),
        Text(
          
          "LOGO",
          style: TextStyle(
            
              color: Color(0xff8875FF),
              fontSize: 35,
              fontWeight: FontWeight.w900),
        ),
        SizedBox(height: 20,),
        _myWork()
      ]),
    );
  }
}
