import 'package:custom_reminders/CustomReminderAddNew.dart';
import 'package:flutter/material.dart';
import 'CustomReminderView.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xff235790),
        accentColor: Color(0xffE28F22),
        splashColor: Color(0xff588297),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          PopupMenuButton(
            child: Icon(Icons.add, color: Colors.white,),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Text("New Reminder"),
              ),
              PopupMenuItem(
                value: 2,
                child: Text("View Reminders"),
              ),
            ],
            onSelected: (value) {
              if (value == 1) {
                showDialog(context: context, builder: (context) {
                  return CustomReminderAddNew();
                });
              }
              if (value == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CustomReminderView()),
                );
              }
            },
          ),
          TextButton(
              onPressed:() {
                print("bell clicked");
              },
              child: Icon(Icons.notifications, color: Colors.white,),
          ),
        ],
      ),
    );
  }
}
