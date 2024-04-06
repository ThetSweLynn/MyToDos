import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_to_dos_application/controllers/reminder_controller.dart';
import 'package:my_to_dos_application/database/db_helper.dart';
import 'package:my_to_dos_application/models/reminder.dart';
import 'package:my_to_dos_application/services/notification_services.dart';
import 'package:my_to_dos_application/services/theme_services.dart';
import 'package:my_to_dos_application/ui/add_task_page.dart';
import 'package:my_to_dos_application/ui/history_page.dart';
import 'package:my_to_dos_application/ui/theme.dart';
import 'package:my_to_dos_application/ui/widgets/button.dart';
import 'package:my_to_dos_application/ui/widgets/reminder_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _reminderController = Get.put(ReminderController());
  var notifyHelper;

  @override
  void initState() {
    super.initState();
    DBHelper.initDb();
    _reminderController.onReady();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        foregroundColor: Colors.white,
        backgroundColor: primaryClr,
        label: const Text(
          "View History",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        icon: const Icon(Icons.history),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: () {
          Get.to(() => MyHistoryPage());
        },
      ),
      appBar: _appBar(),
      body: Column(
        children: [
          _addTaskBar(context),
          SizedBox(height: 30),
          _showReminders(),
          SizedBox(height: 100),
        ],
      ),
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
        height: reminder.isCompleted == 1
            ? MediaQuery.of(context).size.height * 0.24
            : MediaQuery.of(context).size.height * 0.32,
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
                _reminderController.deleteReminder(reminder);
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

  _showReminders() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
            itemCount: _reminderController.reminderList.length,
            itemBuilder: (_, index) {
              Reminder reminder = _reminderController.reminderList[index];

              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                      child: FadeInAnimation(
                          child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showBottomSheet(
                              context, _reminderController.reminderList[index]);
                        },
                        child: ReminderTile(
                            _reminderController.reminderList[index]),
                      ),
                    ],
                  ))));
            });
      }),
    );
  }

  _addTaskBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Today",
                  style: subHeadingStyle,
                ),
                Text(DateFormat.yMMMMd().format(DateTime.now())),
              ],
            ),
          ),
          MyButton(
              icon: Icons.add,
              label: " Add Reminder",
              onTap: () async {
                await Get.to(() => AddTaskPage());
                _reminderController.getReminders();
              }),
        ],
      ),
    );
  }

  /*_appBar() {
    return AppBar(
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          ThemeService().switchTheme();
          /*NotifyHelper notifyHelper = NotifyHelper();
          notifyHelper.displayNotification(
              title: "Theme Changed",
              body: Get.isDarkMode
                  ? "Activated Dark Theme"
                  : "Activated Light Theme");
          notifyHelper.scheduledNotification();*/
        },
        child: Icon(
          Get.isDarkMode ? Icons.wb_sunny_rounded : Icons.nightlight_round,
          size: 20,
        ),
      ),
    );
  } */

  _appBar() {
    return AppBar(
        backgroundColor: context.theme.backgroundColor,
        leading: GestureDetector(
            onTap: () {
              ThemeService().switchTheme();
            },
            child: Icon(
              Get.isDarkMode ? Icons.wb_sunny_rounded : Icons.dark_mode_rounded,
            )));
  } //modified
}
