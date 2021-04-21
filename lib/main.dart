import 'package:flutter/material.dart';
import 'package:custom_reminders/CustomReminders.dart';

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
          TextButton(
              onPressed:() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CustomReminders()),
                );
              },
              child: Icon(Icons.add, color: Colors.white,),
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
