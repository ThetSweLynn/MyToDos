import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_to_dos_application/controllers/reminder_controller.dart';
import 'package:my_to_dos_application/database/db_helper.dart';
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
      child: FutureBuilder(
        future: DBHelper.getCompletedTasks(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final completedTasks = snapshot.data as List<Map<String, dynamic>>;
            return ListView.builder(
              itemCount: completedTasks.length,
              itemBuilder: (_, index) {
                final reminder = Reminder.fromJson(completedTasks[index]);
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          ReminderTile(reminder),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
                    "Error fetching completed tasks")); //if-elseifgemini's source
          } //ifno, (no-history-->error)
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
