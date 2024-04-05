import 'package:flutter/material.dart';
import 'package:my_to_dos_application/ui/theme.dart';

class MyInputField extends StatelessWidget {
  final String hint;
  final double height;
  final TextEditingController? controller;
  final Widget? widget;
  const MyInputField({
    Key? key,
    required this.hint,
    required this.height,
    this.controller,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: height,
              decoration: BoxDecoration(
                color: inputFieldClr,
                border: Border.all(color: inputFieldClr),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    autofocus: false,
                    controller: controller,
                    style: inputTextStyle,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: inputHintStyle,
                      contentPadding: EdgeInsets.only(left: 20),
                      border: InputBorder.none,
                    ),
                  ))
                ],
              )),
        ],
      ),
    );
  }
}
