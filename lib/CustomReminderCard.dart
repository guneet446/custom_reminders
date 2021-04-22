import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'CustomReminderDetails.dart';

class CustomReminderCard extends StatelessWidget {
  final CustomReminderDetails customReminder;
  CustomReminderCard({this.customReminder});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(36, 16, 36, 0),
      child: Column(
          children: <Widget>[
            Text(customReminder.description),
            Text(DateFormat('dd-MM-yyyy – HH:mm').format(customReminder.reminderDateTime)),
            Text(customReminder.alarmRequired.toString()),
          ],
      ),
    );
  }
}
