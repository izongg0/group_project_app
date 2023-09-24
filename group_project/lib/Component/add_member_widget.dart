import 'package:flutter/material.dart';

class MemberWidget extends StatelessWidget {

  String memberName;

  Function() delectMember;
  MemberWidget({super.key,required this.memberName,required this.delectMember});
// ${controller.items.value[index].userName!} 
  @override
  Widget build(BuildContext context) {
    return Padding(
                    padding: const EdgeInsets.only(left:5.0,bottom: 7.0),
                    child: IntrinsicWidth(
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Text(memberName),GestureDetector(
                                  onTap: delectMember,
                                  child: Text(' x',style: TextStyle(color: Colors.grey),))
                              ],
                            )),
                        )),
                    ),
                  );
  }
}