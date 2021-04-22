import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'CustomReminderDetails.dart';
import 'CustomReminderView.dart';

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
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return new AlertDialog(
                        title: Text('Delete Reminder (${customReminder.description})'),

                        actions: <Widget>[
                          new TextButton(
                              child: new Text('Cancel'),
                              onPressed: () => Navigator.of(context).pop()
                          ),
                          new TextButton(
                              child: new Text('Delete'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                customReminders.remove(customReminder);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) =>
                                      CustomReminderView()),
                                );
                              },
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(Icons.delete),
            ),
          ],
      ),
    );
  }
}
