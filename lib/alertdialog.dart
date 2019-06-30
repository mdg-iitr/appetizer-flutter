import 'package:flutter/material.dart';

import 'colors.dart';

void showCustomDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    child: new SimpleDialog(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: new CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(appiYellow),
                ),
              ),
              new Expanded(child: new Container()),
              Padding(
                padding: const EdgeInsets.only(right: 30.0),
                child: new Text(
                  message,
                  style: new TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
