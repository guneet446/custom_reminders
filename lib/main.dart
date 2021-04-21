import 'package:flutter/material.dart';

import 'CustomReminders.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

              }
              if (value == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CustomReminders()),
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
