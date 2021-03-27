import 'package:appetizer/utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget getDayAndDateForCard(DateTime mealStartDateTime) {
  var dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  var mealDateTimeString =
      mealStartDateTime.toString().substring(0, 10) + ' 00:00:00';
  var mealDateTime = dateFormat.parse(mealDateTimeString);

  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 8,
    ),
    child: Column(
      children: <Widget>[
        Text(
          DateTimeUtils.getWeekDayName(mealDateTime),
        ),
        Text(
          DateTimeUtils.getMonthName(mealDateTime) +
              ' ' +
              mealDateTime.day.toString() +
              ',' +
              mealDateTime.year.toString(),
        ),
      ],
    ),
  );
}
