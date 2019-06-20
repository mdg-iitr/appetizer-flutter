import 'package:flutter/material.dart';

import 'notification.dart';
import 'package:appetizer/services/user.dart';
import 'package:appetizer/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:appetizer/timestampToDateTime.dart';

class NotificationHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: const Color.fromRGBO(255, 193, 7, 1),
            onPressed: () => Navigator.pop(context, false),
          ),
          title: Text(
            "Notification History",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromRGBO(121, 85, 72, 1),
        ),
        body: notificationList());
  }
}

Widget notificationList() {
  getToken().then((token) {
    return FutureBuilder(
        future: getNotifications(token),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                  child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(appiYellow),
              )),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return MessNotification(
                      snapshot.data[index].title,
                      snapshot.data[index].message,
                      dateTime(snapshot.data[index].dateCreated));
                });
          }
        });
  });

  return Container(
    height: 0.0,
    width: 0.0,
  );
}

Future<String> getToken() async {
  String token;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  token = prefs.getString("token");
  return token;
}
