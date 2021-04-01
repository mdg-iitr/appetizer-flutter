import 'package:appetizer/app_theme.dart';
import 'package:flutter/material.dart';

class SwitchConfirmedView extends StatefulWidget {
  static const String id = 'switch_confirmed_view';

  @override
  _SwitchConfirmedViewState createState() => _SwitchConfirmedViewState();
}

class _SwitchConfirmedViewState extends State<SwitchConfirmedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.green,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/meals_switched.png',
              width: 150,
            ),
            SizedBox(height: 30),
            Text(
              'Switched Meals Successfully!',
              textAlign: TextAlign.center,
              style: AppTheme.headline1.copyWith(
                color: AppTheme.white,
                fontSize: 36.0,
                fontFamily: 'Lobster_Two',
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).popUntil((route) => route.isFirst);
    });
  }
}
