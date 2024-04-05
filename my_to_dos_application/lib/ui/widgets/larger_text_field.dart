//Note
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_to_dos_application/ui/theme.dart';

class LargerInputField extends StatelessWidget {
  //final String task;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  const LargerInputField({
    Key? key,
    //required this.task,
    required this.hint,
    this.controller,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 16),
        child: Column(
          children: [
            Container(
                height: 150,
                margin: EdgeInsets.only(top: 8.0),
                padding: EdgeInsets.only(left: 14),
                decoration: BoxDecoration(
                    //color: Colors.grey[100],
                    color: inputFieldClr,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                            //minLines: 1,
                            maxLines: 10, //weird line disappeared
                            keyboardType: TextInputType.multiline,
                            autofocus: false,
                            cursorColor: Get.isDarkMode
                                ? Colors.grey[100]
                                : Colors.grey[700],
                            controller: controller,
                            style: inputTextStyle,
                            decoration: InputDecoration(
                              hintText: hint,
                              hintStyle: inputHintStyle,
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: context.theme.backgroundColor,
                                      width: 0)),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: context.theme.backgroundColor,
                                  width: 0,
                                ),
                              ),
                            )))
                  ],
                ))
          ],
        ));
  }
}
