import 'package:appetizer_revamp_parts/app_theme.dart';
import 'package:appetizer_revamp_parts/locator.dart';
import 'package:appetizer_revamp_parts/models/transaction/paginated_yearly_rebate.dart';
import 'package:appetizer_revamp_parts/services/api/transaction_api.dart';
import 'package:appetizer_revamp_parts/ui/LeavesAndRebate/components/custom_divider.dart';
import 'package:appetizer_revamp_parts/ui/components/shadow_container.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class MonthlyRebates extends StatefulWidget {
  const MonthlyRebates(
      {super.key,
      required this.paginatedYearlyRebate,
      required this.currMonthIndex});
  final PaginatedYearlyRebate paginatedYearlyRebate;
  final int currMonthIndex; //1-indexed
  @override
  State<MonthlyRebates> createState() => _MonthlyRebatesState();
}

class _MonthlyRebatesState extends State<MonthlyRebates> {
  int? _currMonthIndex;
  PaginatedYearlyRebate? paginatedYearlyRebate;
  Map<String, num> _monthlyRebateMap = {};
  String? _currMonthName;
  num _totalRebate = 0;
  late int year;
  // final TransactionApi _transactionApi = locator<TransactionApi>();

  // @override
  // void initState() {
  //   _currMonthIndex = widget.currMonthIndex;
  //   _currMonthName = _monthList[_currMonthIndex];
  //   for (YearlyRebate yr in widget.paginatedYearlyRebate.results) {
  //     _monthlyRebateMap[_monthList[yr.monthId]] = yr.rebate;
  //     _totalRebate += yr.rebate;
  //   }
  //   _monthlyRebateMap["All"] = _totalRebate;
  //   super.initState();
  // }

  final _monthList = [
    'All',
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  @override
  Widget build(BuildContext context) {
    _currMonthIndex ??= widget.currMonthIndex;
    _currMonthName = _monthList[_currMonthIndex!];
    paginatedYearlyRebate ??= widget.paginatedYearlyRebate;
    for (YearlyRebate yr in paginatedYearlyRebate!.results) {
      _monthlyRebateMap[_monthList[yr.monthId]] = yr.rebate;
      _totalRebate += yr.rebate;
    }
    _monthlyRebateMap["All"] = _totalRebate;
    year = DateTime.now().year;
    return ShadowContainer(
      height: 134,
      width: 312,
      offset: 2,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Monthly Rebates",
                  style: AppTheme.headline3.copyWith(
                    color: AppTheme.black1e,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Container(
                  width: 87,
                  height: 24,
                  decoration: ShapeDecoration(
                    color: AppTheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      DateTime? newDateTime = await showMonthPicker(
                          context: context,
                          initialDate: DateTime(year, _currMonthIndex!),
                          lastDate: DateTime.now());
                      if (newDateTime != null &&
                          newDateTime.year == year &&
                          newDateTime.month != _currMonthIndex) {
                        setState(() {
                          _currMonthIndex = newDateTime.month;
                        });
                      }
                      // if (newDateTime != null && newDateTime.year != year) {
                      //   setState(() async {
                      //     year = newDateTime.year;
                      //     _currMonthIndex = newDateTime.month;
                      //     PaginatedYearlyRebate paginatedYearlyRebate =
                      //         await _transactionApi.getYearlyRebate(year);
                      //     _totalRebate = 0;
                      //     for (YearlyRebate yr
                      //         in paginatedYearlyRebate.results) {
                      //       _monthlyRebateMap[_monthList[yr.monthId]] = yr.rebate;
                      //       _totalRebate += yr.rebate;
                      //     }
                      //     _monthlyRebateMap["All"] = _totalRebate;
                      //   });
                      // }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_monthList[_currMonthIndex!].substring(0, 3),
                            style: AppTheme.bodyText1.copyWith(height: 1)),
                        const Icon(Icons.keyboard_arrow_down,
                            color: AppTheme.blackPrimary)
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Rebates",
                      style: AppTheme.headline2
                          .copyWith(color: AppTheme.primary, fontSize: 14)),
                  Text("- Rs. ${_monthlyRebateMap[_currMonthName] ?? 0}",
                      style: AppTheme.headline2
                          .copyWith(color: AppTheme.primary, fontSize: 14))
                ],
              ),
            ),
            SizedBox(height: 16),
            CustomDivider(),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total rebates till now",
                      style: AppTheme.bodyText1
                          .copyWith(height: 1, color: AppTheme.grey2e)),
                  Text("- Rs ${_totalRebate}",
                      style: AppTheme.bodyText1
                          .copyWith(height: 1, color: AppTheme.grey2e))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
