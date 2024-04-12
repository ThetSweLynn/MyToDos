import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_to_dos_application/models/reminder.dart';
import 'package:my_to_dos_application/ui/theme.dart';

class ReminderTile extends StatelessWidget {
  final Reminder? reminder;
  const ReminderTile(this.reminder, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 10),
      child: Container(
        padding: EdgeInsets.all(16),
        //  width: SizeConfig.screenWidth * 0.78,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: _getBGClr(reminder?.color ?? 0),
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 7,
                ),
                Text(
                  reminder?.task ?? "",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: Colors.grey[200],
                      size: 18,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${reminder!.time}",
                      style: GoogleFonts.lato(
                        textStyle:
                            TextStyle(fontSize: 13, color: Colors.grey[100]),
                      ),
                    ),
                    SizedBox(width: 15),
                    Text(
                      "|",
                      style: GoogleFonts.lato(
                        textStyle:
                            TextStyle(fontSize: 13, color: Colors.grey[100]),
                      ),
                    ),
                    SizedBox(width: 15),
                    Icon(
                      Icons.calendar_month,
                      color: Colors.grey[200],
                      size: 18,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${reminder!.date}",
                      style: GoogleFonts.lato(
                        textStyle:
                            TextStyle(fontSize: 13, color: Colors.grey[100]),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  reminder?.note ?? "",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(fontSize: 15, color: Colors.grey[100]),
                  ),
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
          //pinned
          reminder!.isPinned == 1
              ? Container(
                  child: Icon(
                    Icons.push_pin_rounded,
                    color: Colors.amberAccent,
                    size: 20,
                  ),
                )
              : SizedBox(),
          Icon(Icons.more_vert, color: Colors.white, size: 25),
        ]),
      ),
    );
  }

  _getBGClr(int no) {
    switch (no) {
      case 0:
        return pinkClr;
      case 1:
        return orangeClr;
      case 2:
        return purpleClr;
      case 3:
        return blueClr;
      case 4:
        return greenClr;
      default:
        return pinkClr;
    }
  }
}
