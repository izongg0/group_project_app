import 'package:flutter/material.dart';
import 'package:group_project/Component/purple_button.dart';

class ProfileSelect extends StatelessWidget {
  ProfileSelect({
    super.key,
  });

  final List<String> items = [
    'cat',
    'duck',
    'elephant',
    'fox',
    'frog',
    'giraffe',
    'hippo',
    'koala',
    'lion',
    'monkey',
    'owl',
    'panda',
    'penguin',
    'polar',
    'rabbit',
    'rhinoceros',
    'tiger',
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            // 창 둥글게
            borderRadius: BorderRadius.circular(20),
            child: Container(
                alignment: Alignment.center,
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20),
                // width: MediaQuery.of(context).size.width * 0.7,
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    
                        ...List.generate(items.length, (index) => GestureDetector(
                          onTap: (){ Navigator.of(context).pop('assets/${items[index]}.png');},
                          child: Image.asset('assets/${items[index]}.png',width: 40,)))
                      ],
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
