import 'package:custom_reminders/CustomReminderCard.dart';
import 'package:custom_reminders/CustomReminderDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomReminderView extends StatefulWidget {
  @override
  _CustomReminderViewState createState() => _CustomReminderViewState();
}
List<CustomReminderDetails> customReminders = [];

class _CustomReminderViewState extends State<CustomReminderView> {
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
