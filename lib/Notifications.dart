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

  Future<void> showNotification() async{
    var androidChannelSpecifics = AndroidNotificationDetails('CHANNEL_ID', 'CHANNEL_NAME', 'CHANNEL_DESCRIPTION');
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(androidChannelSpecifics, iosChannelSpecifics);
    flutterLocalNotificationsPlugin.show(0, "test", "test body", platformChannelSpecifics, payload: "Test payload");
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