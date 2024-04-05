import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:my_to_dos_application/controllers/reminder_controller.dart';
import 'package:my_to_dos_application/models/reminder.dart';
import 'package:my_to_dos_application/ui/widgets/reminder_tile.dart';

class MyHistoryPage extends StatefulWidget {
  const MyHistoryPage({super.key});

  @override
  State<MyHistoryPage> createState() => _MyHistoryPageState();
}

class _MyHistoryPageState extends State<MyHistoryPage> {
  final _reminderController = Get.put(ReminderController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
      ),
      body: Container(
        child: Column(
          children: [
            _showReminders(),
          ],
        ),
      ),
    );
  }

  _showReminders() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
            itemCount: _reminderController.reminderList.length,
            itemBuilder: (_, index) {
              Reminder reminder = _reminderController.reminderList[index];
              print(reminder.toJson());

              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                      child: FadeInAnimation(
                          child: Row(
                    children: [
                      ReminderTile(_reminderController.reminderList[index]),
                    ],
                  ))));
            });
      }),
    );
  }
}
