import 'dart:ui';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class Notifications {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject = BehaviorSubject<ReceivedNotification>();
  var initializationSettings;

  Notifications(){
    init();
  }
  init() async{
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    initializePlatformSpecifics();
  }

  initializePlatformSpecifics() {
    var initializationSettingsAndroid = AndroidInitializationSettings('notif_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        ReceivedNotification receivedNotification = ReceivedNotification(id: id, title: title, body: body, payload: payload);
        didReceiveLocalNotificationSubject.add(receivedNotification);
      },
    );
    initializationSettings = InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
  }

  setOnNotificationClick(Function onNotificationClick) async{
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async{
          onNotificationClick(payload);
        }
    );
  }
  //Can be used for testing
  /*Future<void> showNotification() async {
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      'CHANNEL_DESCRIPTION',
      importance: Importance.Max,
      priority: Priority.High,
      playSound: true,
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(androidChannelSpecifics, iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.show('0', "test", "test body", platformChannelSpecifics, payload: "Test payload");
  }*/

  Future<void> scheduleNotification(int uid, DateTime selectedDateTime, String description) async {
    DateTime scheduleNotificationDateTime = selectedDateTime;
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID 1',
      'CHANNEL_NAME 1',
      "CHANNEL_DESCRIPTION 1",
      //icon: 'secondary_icon',
      //sound: RawResourceAndroidNotificationSound('my_sound'),
      //largeIcon: DrawableResourceAndroidBitmap('large_notf_icon'),
      enableLights: true,
      color: Color.fromARGB(255, 255, 0, 0),
      ledColor: Color.fromARGB(255, 255, 0, 0),
      ledOnMs: 1000,
      ledOffMs: 500,
      importance: Importance.Max,
      priority: Priority.High,
      playSound: true,
      //timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
    );
    var iosChannelSpecifics = IOSNotificationDetails(
      sound: 'my_sound.aiff',
    );
    var platformChannelSpecifics = NotificationDetails(
      androidChannelSpecifics,
      iosChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.schedule(
      uid,
      'Reminder',
      description,
      scheduleNotificationDateTime,
      platformChannelSpecifics,
      payload: 'Test Payload',
    );
  }

  Future<void> cancelNotification(int uid) async {
    await flutterLocalNotificationsPlugin.cancel(uid);
  }
}

Notifications notifications = Notifications(); //Note: object so we can access the functions everywhere

class ReceivedNotification {
  int id;
  String title;
  String body;
  String payload;

  ReceivedNotification({this.id, this.title, this.body, this.payload});
}