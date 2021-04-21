import 'package:flutter/material.dart';

class CustomReminderDetails {
  String description;
  DateTime reminderDate;
  TimeOfDay reminderTime;
  bool alarmRequired;

  CustomReminderDetails(this.description, this.reminderDate, this.reminderTime, this.alarmRequired);
}