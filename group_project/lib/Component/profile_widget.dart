import 'package:flutter/material.dart';

enum ProfileType { TYPE1, TYPE2 }

class ProfileImage extends StatelessWidget {
  String animal;
  double? width;
  String? nickname;
  ProfileType type;
  ProfileImage({super.key, required this.animal, this.width = 55, required this.type,this.nickname});

  Widget _type1() {
    return Image.asset('${animal}', width: width);
  }

  Widget _type2() {
    return Container(
      child: Column(
        
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('${animal}', width: width),
          SizedBox(height: 8,),
          Text(nickname!)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ProfileType.TYPE1:
        return _type1();
      case ProfileType.TYPE2:
        return _type2();
    }
  }
}
