import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_to_dos_application/controllers/reminder_controller.dart';
import 'package:my_to_dos_application/models/reminder.dart';
import 'package:my_to_dos_application/ui/theme.dart';
import 'package:my_to_dos_application/ui/widgets/button.dart';
import 'package:my_to_dos_application/ui/widgets/input_field.dart';
import 'package:my_to_dos_application/ui/widgets/larger_text_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final ReminderController _reminderController = Get.put(ReminderController());
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime =
      TimeOfDay.fromDateTime(DateTime.now().add(Duration(hours: 1)));
  int _isPinned = 0;
  int _selectedColor = 0;

  Color dateIconColor = Colors.grey;
  Color timeIconColor = Colors.grey;
  Color pinIconColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyInputField(
                hint: "Task",
                height: 58,
                controller: _taskController,
              ),
              LargerInputField(
                hint: "Note",
                controller: _noteController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _datePickerButton(),
                  _timePickerButton(),
                  _pinButton(),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: _colorPallete(),
              ),
              SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyButton(
                      icon: null,
                      label: "Add Reminder", //<<<<<not centered
                      onTap: () => _validateData())
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _validateData() {
    if (_taskController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      //add to database
      _addReminderToDB();
      Get.back();
    } else if (_taskController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar("Required", "All fields are required",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.isDarkMode ? Colors.white : inputFieldClr,
          colorText: primaryClr,
          icon: Icon(
            Icons.warning_amber_rounded,
            color: Colors.amber,
          ));
    }
  }

  _addReminderToDB() async {
    int value = await _reminderController.addReminder(
        reminder: Reminder(
            task: _taskController.text.toString(),
            note: _noteController.text.toString(),
            date: DateFormat.yMd().format(_selectedDate),
            time: _selectedTime.format(context),
            color: _selectedColor,
            isPinned: _isPinned,
            isCompleted: 0));
    print("My id is " + "$value");
  }

  _colorPallete() {
    return Wrap(
      children: List<Widget>.generate(5, (int index) {
        return GestureDetector(
          onTap: () {
            setState(
              () {
                _selectedColor = index;
                print("$index");
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: CircleAvatar(
              radius: 14,
              backgroundColor: index == 0
                  ? pinkClr
                  : index == 1
                      ? orangeClr
                      : index == 2
                          ? purpleClr
                          : index == 3
                              ? blueClr
                              : greenClr,
              child: _selectedColor == index
                  ? (Icon(Icons.done_rounded, color: Colors.white, size: 16)
                      as Widget?)
                  : Container(),
            ),
          ),
        );
      }),
    );
  }

  ///cannot put the original icon to center, so change it and put it to the left
  _appBar(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () => Get.back(),
        child: Icon(
          Icons.arrow_back_ios_rounded,
          color: primaryClr,
          size: 20,
        ),
      ),
    );
  }

  _datePickerButton() {
    return Container(
      margin: EdgeInsets.only(
          top: 30.0), // Add margin to the top (adjust as needed)
      child: ElevatedButton(
        onPressed: _handleDatePick,
        style: ElevatedButton.styleFrom(
          foregroundColor: inputHintClr,
          backgroundColor: inputFieldClr, // Button color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 52,
              height: 156,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Date'),
                  Icon(
                    Icons.calendar_month,
                    color: dateIconColor,
                    size: 30,
                  ), // Icon with color based on state
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handleDatePick() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2024, 12, 31),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        dateIconColor =
            primaryClr; // Change color to green on selection (example)
      });
    }
  }

  _timePickerButton() {
    return Container(
      margin: EdgeInsets.only(
          top: 30.0), // Add margin to the top (adjust as needed)
      child: ElevatedButton(
        onPressed: _handleTimePick,
        style: ElevatedButton.styleFrom(
          foregroundColor: inputHintClr,
          backgroundColor: inputFieldClr, // Button color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 52,
              height: 156,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Time'),
                  Icon(
                    Icons.access_time_rounded,
                    color: timeIconColor,
                    size: 30,
                  ), // Icon with color based on state
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleTimePick() async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
        timeIconColor =
            primaryClr; // Change color to green on selection (example)
      });
    }
  }

  _pinButton() {
    return Container(
      margin: EdgeInsets.only(
          top: 30.0), // Add margin to the top (adjust as needed)
      child: ElevatedButton(
        onPressed: _togglePin,
        style: ElevatedButton.styleFrom(
          foregroundColor: inputHintClr,
          backgroundColor: inputFieldClr, // Button color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 52,
              height: 156,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Pin'),
                  Icon(
                    Icons.push_pin_rounded,
                    color: (_isPinned == 1)
                        ? primaryClr
                        : Colors.grey, // Change color based on state
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _togglePin() {
    setState(() {
      _isPinned = (_isPinned == 1) ? 0 : 1;
    });
  }
}
