import 'package:custom_reminders/CustomReminderView.dart';
import 'package:flutter/material.dart';

import 'CustomReminderDetails.dart';
import 'Notifications.dart';

class CustomReminderAddNew extends StatefulWidget {
  @override
  _CustomReminderAddNewState createState() => _CustomReminderAddNewState();
}

class _CustomReminderAddNewState extends State<CustomReminderAddNew> {

  final myController = TextEditingController();
  DateTime selectedDate;
  TimeOfDay selectedTime;
  DateTime selectedDateTime;
  String userDescription = "";
  bool getNotif = true;
  int uid = 0;

  void initState() {
    super.initState();
    notifications.setOnNotificationClick(onNotificationClick);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Set Reminder"),
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
        SwitchListTile(
          title: Text("Get Notified"),
            value: getNotif,
            onChanged: (newValue) {
              setState(() {
                getNotif = newValue;
              });
            },
        ),
        TextButton(
          child: Text('Next', style: TextStyle(color: Color(0xff235790)),),
          onPressed: () async {
            userDescription = myController.text;
            selectedDate = await _selectDate(context);
            selectedTime = await _selectTime(context);
            selectedDateTime = new DateTime(selectedDate.year, selectedDate.month, selectedDate.day, selectedTime.hour, selectedTime.minute);
            customReminders.add(CustomReminderDetails(userDescription, selectedDateTime, getNotif));
            if(getNotif) {
              //await notifications.showNotification(); //can be used for testing
              await notifications.scheduleNotification(uid, selectedDateTime, userDescription);
              ++ uid;
            }
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
      initialEntryMode: DatePickerEntryMode.calendar,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xff588297),
            accentColor: Color(0xffE28F22),
            colorScheme: ColorScheme.light(primary: Color(0xff235790),),
            buttonTheme: ButtonThemeData(
                textTheme: ButtonTextTheme.primary
            ),
          ),
          child: child,
        );
      },
    );
    return pickedDate;
  }

  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
        context: context,
        helpText: "Time of Reminder",
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.dial,
        builder: (BuildContext context, Widget child) {
          /*return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );*/
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Color(0xff588297),
              accentColor: Color(0xffE28F22),
              colorScheme: ColorScheme.light(primary: Color(0xff235790),),
              buttonTheme: ButtonThemeData(
                  textTheme: ButtonTextTheme.primary
              ),
            ),
            child: child,
          );
        }
    );
    return pickedTime;
  }

  onNotificationClick(String payload) {
    print('Payload $payload');
  }
}
