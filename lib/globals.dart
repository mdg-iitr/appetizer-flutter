import 'package:flutter/material.dart';

var menuScaffoldKey = new GlobalKey<ScaffoldState>();
bool isCheckedOut = false;
bool isCheckedLoading = false;

Duration outdatedTime = Duration(hours: 8);
