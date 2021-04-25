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
      appBar: PreferredSize(preferredSize: Size.fromHeight(65),
        child: AppBar(
          title: Text("Custom Reminders", style: TextStyle( color: Color(0xffCADBE4), fontSize: 32,),),
          backgroundColor: Color(0xff588297),
        ),
      ),
      body: ListView.builder(
        itemCount: customReminders.length,
        itemBuilder: (context, index) {
          //(DateTime.now().add(Duration(days: 2)).isBefore(customReminders[index].reminderDateTime))
          //(customReminders[index].reminderDateTime.isBefore(DateTime.now().add(const Duration(days: 2))))
          if (customReminders[index].reminderDateTime.add(const Duration(days: 2)).isBefore(DateTime.now())){
            customReminders.removeAt(index);
            return null;
          }
          else {
            return CustomReminderCard(
              customReminder: customReminders[index],
            );
          }
        },
      ),
    );
  }
}
