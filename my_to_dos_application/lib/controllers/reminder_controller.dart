import 'package:get/get.dart';
import 'package:my_to_dos_application/database/db_helper.dart';
import 'package:my_to_dos_application/models/reminder.dart';

class ReminderController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  var reminderList = <Reminder>[].obs;

  Future<int> addReminder({Reminder? reminder}) async {
    return await DBHelper.insert(reminder);
  }

  void getReminders() async {
    List<Map<String, dynamic>> reminders = await DBHelper.query();
    reminderList.assignAll(
        reminders.map((data) => new Reminder.fromJson(data)).toList());
  }

  void deleteReminder(Reminder reminder) {
    DBHelper.delete(reminder);
    getReminders();
  }

  void markAsCompleted(int id) async {
    await DBHelper.update(id);
    getReminders();
  }
}
