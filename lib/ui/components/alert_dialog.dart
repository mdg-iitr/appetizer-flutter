import 'package:flutter/material.dart';
import 'package:appetizer/colors.dart';

void showCustomDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(36, 10, 36, 10),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(appiYellow),
                ),
                Center(
                  child: new Text(
                    message,
                    style: new TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
