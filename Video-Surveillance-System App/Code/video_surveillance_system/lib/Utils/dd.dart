import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:video_surveillance_system/Notifications/notificationService.dart';

class NotificationDemoScreen extends StatefulWidget {
  const NotificationDemoScreen({Key? key}) : super(key: key);

  @override
  State<NotificationDemoScreen> createState() => _NotificationDemoScreenState();
}

class _NotificationDemoScreenState extends State<NotificationDemoScreen> {
  NotificationServices services = NotificationServices();

  @override
  void initState() {
    super.initState();
    // _startTimer();
    services.requestNotificationPermission();
    services.firebaseInit(context);
    services.setupInteractMessage(context);
    services.isTokenRefresh();
    services.getDeviceToken().then((value) {
      print("MY DEVICE TOKEN");
      print(value);
    });
  }

  void _sendNotification() {
    services.getDeviceToken().then((value) async {
      var data = {
        'to': value.toString(),
        'priority': "high",
        'notification': {
          'title': "Video Surveillance System ",
          'body': "Video Surveillance System",
        },
        'data': {'type': 'message', 'id': "Detected Frame History"}
      };
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'key=AAAALL1qi4o:APA91bEy4NlxYW3OM0LxcLpfYHLpVGt6sy7E-BvCYJh-nU7nOS1Gs_yvEg18fTpJ6rPnjlCwJMUqi94poMTwtR6rBI9Dpo56LEiG8aFl11RVieUr5rcETcCxOYBzQSFUyxzTWGP93Bch'
        },
      );
    });
  }

  @override
  void dispose() {
    //_stopTimer();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text("Flutter Notification"),
        backgroundColor: Colors.white70,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _sendNotification,
              child: Text(
                "Notification On",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            SizedBox(height: 20), // Add spacing between buttons
            ElevatedButton(
              onPressed: () {},
              child: Text(
                "Notification Off",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
