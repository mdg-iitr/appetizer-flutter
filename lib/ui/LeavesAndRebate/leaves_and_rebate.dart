import 'package:appetizer_revamp_parts/app_theme.dart';
import 'package:appetizer_revamp_parts/locator.dart';
import 'package:appetizer_revamp_parts/models/transaction/paginated_yearly_rebate.dart';
import 'package:appetizer_revamp_parts/services/api/leave_api.dart';
import 'package:appetizer_revamp_parts/services/api/transaction_api.dart';
import 'package:appetizer_revamp_parts/ui/LeavesAndRebate/bloc/leaves_and_rebate_bloc.dart';
import 'package:appetizer_revamp_parts/ui/LeavesAndRebate/components/custom_divider.dart';
import 'package:appetizer_revamp_parts/ui/LeavesAndRebate/components/leave_history.dart';
import 'package:appetizer_revamp_parts/ui/LeavesAndRebate/components/monthly_rebates.dart';
import 'package:appetizer_revamp_parts/ui/components/app_banner.dart';
import 'package:appetizer_revamp_parts/ui/components/loading_indicator.dart';
import 'package:appetizer_revamp_parts/ui/components/round_edge_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class LeavesAndRebate extends StatelessWidget {
  const LeavesAndRebate(
      {super.key,
      required this.isCheckedOut,
      required this.initialYearlyRebates});
  final bool isCheckedOut;
  final PaginatedYearlyRebate initialYearlyRebates;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LeavesAndRebateBloc(isCheckedOut: isCheckedOut),
        child: BlocBuilder<LeavesAndRebateBloc, LeavesAndRebateState>(
          builder: (context, state) {
            if (state is LeavesAndRebateLoadingState) {
              context
                  .read<LeavesAndRebateBloc>()
                  .add(const LeavesAndRebateGetInitialDataEvent());
              return const Center(child: LoadingIndicator());
            }
            if (state is LeavesAndRebateDisplayState) {
              return Column(
                children: [
                  AppBanner(
                      height: 85,
                      child: Text(
                        "Leaves & Rebates",
                        style: AppTheme.headline1,
                      )),
                  SizedBox(height: 40),
                  MonthlyRebates(
                      paginatedYearlyRebate: initialYearlyRebates,
                      currMonthIndex:
                          DateFormat('dd').format(DateTime.now()) as int),
                  SizedBox(height: 24),
                  Row(
                    children: [
                      Text("Remaining Leaves : ",
                          style: AppTheme.subtitle1
                              .copyWith(fontSize: 14, color: AppTheme.black2e)),
                      Text(state.remainingLeaves as String,
                          style: AppTheme.headline2
                              .copyWith(fontSize: 14, color: AppTheme.primary))
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Text("Meals Skipped : ",
                          style: AppTheme.subtitle1
                              .copyWith(fontSize: 14, color: AppTheme.black2e)),
                      Text(state.mealsSkipped as String,
                          style: AppTheme.headline2
                              .copyWith(fontSize: 14, color: AppTheme.primary))
                    ],
                  ),
                  SizedBox(height: 20),
                  CustomDivider(),
                  SizedBox(height: 24),
                  LeaveHistory(paginatedLeaves: state.paginatedLeaves),
                  SizedBox(height: 32),
                  GestureDetector(
                      child: RoundEdgeTextOnlyContainer(text: "CHECK OUT"))
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ));
  }
}
