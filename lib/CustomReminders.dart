import 'package:custom_reminders/CustomReminderCard.dart';
import 'package:custom_reminders/CustomReminderDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomReminders extends StatefulWidget {
  @override
  _CustomRemindersState createState() => _CustomRemindersState();
}
List<CustomReminderDetails> customReminders = [CustomReminderDetails('descrip', DateTime.now(), false)];

class _CustomRemindersState extends State<CustomReminders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom Reminders"),
      ),
      body: ListView.builder(
        itemCount: customReminders.length,
        itemBuilder: (context, index) {
          return CustomReminderCard(
            customReminder: customReminders[index],
          );
        },
      ),
    );
  }
}
