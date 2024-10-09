import 'package:appetizer/app_theme.dart';
import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/presentation/components/app_banner.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class FeedbackBanner extends StatelessWidget {
  const FeedbackBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBanner(
      height: 140.toAutoScaledHeight,
      child: Row(
        children: [
          IconButton(
            onPressed: context.router.maybePop,
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          Text(
            "Feedback",
            style: AppTheme.headline1,
          ),
        ],
      ),
      // ),
    );
  }
}
