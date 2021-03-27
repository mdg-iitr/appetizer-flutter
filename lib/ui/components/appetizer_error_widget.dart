import 'package:appetizer/app_theme.dart';
import 'package:flutter/material.dart';

class AppetizerErrorWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetryPressed;

  const AppetizerErrorWidget({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              errorMessage ?? 'Something Wrong Occured !!',
              textAlign: TextAlign.center,
              style: AppTheme.headline6,
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: onRetryPressed,
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
              child: Text(
                'RETRY',
                style: AppTheme.bodyText1.copyWith(
                  color: AppTheme.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
