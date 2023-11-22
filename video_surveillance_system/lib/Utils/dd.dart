import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:video_surveillance_system/Notifications/notificationService.dart';
import 'package:http/http.dart' as http;

class NotificationDemoScreen extends StatefulWidget {
  const NotificationDemoScreen({super.key});

  @override
  State<NotificationDemoScreen> createState() => _NotificationDemoScreenState();
}

class _NotificationDemoScreenState extends State<NotificationDemoScreen> {
  NotificationServices services = NotificationServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    services.requestNotificationPermission();
    services.firebaseInit(context);
    services.setupInteractMessage(context);
    services.isTokenRefresh();
    services.getDeviceToken().then((value) {
      print("MY DEVICE TOKEN");
      print(value);
    });
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Notification"),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            services.getDeviceToken().then((value) async {
              var data = {
                'to': value.toString(),
                'priority': "high",
                'notification': {
                  'title': "Video Surveillance System ",
                  'body': "Video Surveillance System",
                },
                'data': {'type': 'message', 'id': "zain12345"}
              };
              await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
                  body: jsonEncode(data),
                  headers: {
                    'Content-Type': 'application/json; charset=UTF-8',
                    'Authorization':
                        'key=AAAALL1qi4o:APA91bEy4NlxYW3OM0LxcLpfYHLpVGt6sy7E-BvCYJh-nU7nOS1Gs_yvEg18fTpJ6rPnjlCwJMUqi94poMTwtR6rBI9Dpo56LEiG8aFl11RVieUr5rcETcCxOYBzQSFUyxzTWGP93Bch'
                  });
            });
          },
          child: Text(
            "Send Notification",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
