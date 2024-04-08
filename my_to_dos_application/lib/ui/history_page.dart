import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_to_dos_application/controllers/reminder_controller.dart';
import 'package:my_to_dos_application/database/db_helper.dart';
import 'package:my_to_dos_application/models/reminder.dart';
import 'package:my_to_dos_application/ui/home_page.dart';
import 'package:my_to_dos_application/ui/theme.dart';
import 'package:my_to_dos_application/ui/widgets/reminder_tile.dart';

class MyHistoryPage extends StatefulWidget {
  const MyHistoryPage({super.key});

  @override
  State<MyHistoryPage> createState() => _MyHistoryPageState();
}

class _MyHistoryPageState extends State<MyHistoryPage> {
  final List color = [0, 1, 2, 3, 4];

  List SelectedCategories = [];

  final _reminderController = Get.put(ReminderController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 20),
            _showReminders(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: primaryClr,
            size: 20,
          ),
          onTap: () async {
            await Get.to(() => HomePage());
            _reminderController.getReminders();
          }),
      title: Text("History", style: TextStyle(color: redClr, fontSize: 15)),
      centerTitle: true,
    );
  }

  _showReminders() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
            itemCount: _reminderController.reminderCompletedList.length,
            itemBuilder: (_, index) {
              Reminder reminder =
                  _reminderController.reminderCompletedList[index];
              print(reminder.toJson());

              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                      child: FadeInAnimation(
                          child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showBottomSheet(context,
                              _reminderController.reminderCompletedList[index]);
                        },
                        child: ReminderTile(
                            _reminderController.reminderCompletedList[index]),
                      ),
                    ],
                  ))));
            });
      }),
    );
  }

  _showBottomSheet(BuildContext context, Reminder reminder) {
    Get.bottomSheet(Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Get.isDarkMode ? lightGreyClr : Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        height: MediaQuery.of(context).size.height * 0.20,
        child: Column(
          children: [
            Spacer(),
            reminder.isCompleted == 1
                ? Container()
                : _bottomSheetButton(
                    label: "Mark as Complete",
                    labelClr: Colors.black,
                    onTap: () {
                      _reminderController.markAsCompleted(reminder.id!);
                      Get.back();
                    },
                    clr: inputFieldClr,
                    context: context,
                  ),
            SizedBox(height: 20),
            _bottomSheetButton(
              label: "Delete Reminder",
              labelClr: Colors.white,
              onTap: () {
                _reminderController.deleteCompletedReminder(reminder);
                Get.back();
              },
              clr: primaryClr,
              context: context,
            ),
            Spacer(),
          ],
        )));
  }

  _bottomSheetButton(
      {required String label,
      required Color labelClr,
      required Function()? onTap,
      required Color clr,
      required BuildContext? context}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: 60,
          width: MediaQuery.of(context!).size.width * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: clr,
            boxShadow: [
              Get.isDarkMode
                  ? BoxShadow(color: Colors.transparent)
                  : BoxShadow(
                      color: Colors.grey
                          .withOpacity(0.5), // Shadow color with transparency
                      offset: Offset(-1, 5.0), // Offset the shadow slightly
                      blurRadius:
                          14.0, // Blur radius to control the softness of the shadow
                    )
            ],
          ),
          child: Center(
            child: Text(label,
                style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        color: labelClr,
                        fontSize: 18,
                        fontWeight: FontWeight.bold))),
          )),
    );
  }
}
