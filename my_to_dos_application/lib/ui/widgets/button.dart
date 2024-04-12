import 'package:flutter/material.dart';
import 'package:my_to_dos_application/ui/theme.dart';

class MyButton extends StatelessWidget {
  final IconData? icon;
  final String label;
  final Function()? onTap;
  const MyButton(
      {Key? key, this.icon, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 185,
        height: 60,
        padding: EdgeInsets.all(17),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: primaryClr,
        ),
        child: Row(
          children: [
            Icon(
              icon as IconData?,
              color: Colors.white,
            ),
            Text(
              label,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
