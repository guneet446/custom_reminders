import 'package:flutter/material.dart';

class CustomReminderDetails {
  String description;
  DateTime reminderDateTime;
  bool alarmRequired;

  CustomReminderDetails(this.description, this.reminderDateTime, this.alarmRequired);
}