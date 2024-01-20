import 'package:appetizer/app_theme.dart';
import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/domain/repositories/feedback_repository.dart';
import 'package:appetizer/presentation/components/app_formfield.dart';
import 'package:appetizer/presentation/components/black_button.dart';
import 'package:appetizer/presentation/feedback/bloc/feedback_page_bloc.dart';
import 'package:appetizer/presentation/feedback/components/FeedbackTile/feedback_tile.dart';
import 'package:appetizer/presentation/feedback/components/feedback_banner.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class FeedbackScreen extends StatelessWidget {
  FeedbackScreen({super.key});
  final TextEditingController textController = TextEditingController();
  static const List<String> feedbackHeadings = [
    "Ambience",
    "Hygiene and Cleanliness",
    "Weekly Menu",
    "Worker and Services",
    "Diet and Nutrition",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: BlocProvider(
        create: (context) =>
            FeedbackPageBloc(repo: context.read<FeedbackRepository>()),
        child: BlocBuilder<FeedbackPageBloc, FeedbackPageState>(
          builder: (context, state) {
            return Column(
              children: [
                const FeedbackBanner(),
                // TODO: fix the top edge of SCSV where top elements get hidden
                Expanded(
                  child: SingleChildScrollView(
                    padding: 24.toHorizontalPadding,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kindly provide us with your feedback to improve your mess experienWeekly Menuce.',
                          style: TextStyle(
                            color: const Color(0xFF5A5A5A),
                            fontSize: 14.toAutoScaledFont,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        6.toVerticalSizedBox,
                        ...List.generate(feedbackHeadings.length, (ind) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 2.toAutoScaledHeight),
                            child: FeedbackTile(
                              parentState: state,
                              title: feedbackHeadings[ind],
                              index: ind,
                            ),
                          );
                        }, growable: false),
                        2.toVerticalSizedBox,
                        Text(
                          'If any other feeback, please describe below',
                          style: TextStyle(
                            color: const Color(0xFF111111),
                            fontSize: 16.toAutoScaledFont,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        AppFormField(
                          hintText: "",
                          title: "Description",
                          controller: textController,
                          titleStyle: TextStyle(
                            color: Colors.black.withOpacity(0.5400000214576721),
                            fontSize: 12.toAutoScaledFont,
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w400,
                          ),
                          onChanged: (value) => context
                              .read<FeedbackPageBloc>()
                              .add(FeedbackPageDescriptionChangedEvent(
                                  description: value)),
                          maxLength: 200,
                          maxLines: 5,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0.5.toAutoScaledWidth,
                              color: const Color.fromARGB(37, 0, 0, 0),
                            ),
                          ),
                        ),
                        19.toVerticalSizedBox,
                        Align(
                          alignment: Alignment.bottomRight,
                          child: BlackIconButton(
                            onTap: context.router.pop,
                            // onTap: () => context.read<FeedbackPageBloc>().add(
                            //     FeedbackPageSubmitEvent(
                            //         rating: state.rating,
                            //         description: state.description)),
                            title: "SUBMIT",
                            width: 102.toAutoScaledWidth,
                            icon: Icons.keyboard_double_arrow_right_sharp,
                          ),
                        ),
                        43.toVerticalSizedBox,
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
