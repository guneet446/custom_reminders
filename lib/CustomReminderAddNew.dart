import 'package:custom_reminders/CustomReminderView.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import 'CustomReminderDetails.dart';

class CustomReminderAddNew extends StatefulWidget {
  @override
  _CustomReminderAddNewState createState() => _CustomReminderAddNewState();
}

class _CustomReminderAddNewState extends State<CustomReminderAddNew> {

  final myController = TextEditingController();
  DateTime selectedDate;
  TimeOfDay selectedTime;
  String userDescription = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Description"),
      content: TextFormField(
        controller: myController,
        decoration: InputDecoration(
            labelText: 'Description of the reminder'
        ),
        validator: (val) {
          return val.isEmpty ? 'Enter the description' : null;
        },
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Next'),
          onPressed: () async {
            userDescription = myController.text;
            selectedDate = await _selectDate(context);
            selectedTime = await _selectTime(context);
            customReminders.add(CustomReminderDetails(userDescription, selectedDate, selectedTime, false));
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Future<DateTime> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.input,
    );
    return pickedDate;
  }

  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
        context: context,
        helpText: "Time of Reminder",
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        }
    );
    return pickedTime;
  }
}
