import 'dart:math' as math;

import 'package:appetizer/change_notifiers/menu_model.dart';
import 'package:appetizer/colors.dart';
import 'package:appetizer/models/menu/week.dart';
import 'package:appetizer/services/menu.dart';
import 'package:appetizer/services/multimessing/switch_meals.dart';
import 'package:appetizer/ui/components/alert_dialog.dart';
import 'package:appetizer/ui/components/inherited_data.dart';
import 'package:appetizer/ui/components/switch_confirmation_meal_card.dart';
import 'package:appetizer/ui/multimessing/confirmed_switch_screen.dart';
import 'package:appetizer/utils/date_time_utils.dart';
import 'package:appetizer/utils/get_hostel_code.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';


//TODO: (nitish) Make this modular, take example from what I have dont with other widgets
class ConfirmSwitchPopupScreen extends StatefulWidget {
  final String token;
  final int id;
  final DateTime mealStartDateTime;
  final String title;
  final Map<CircleAvatar, String> menuToWhichToBeSwitched;
  final String dailyItemsToWhichToBeSwitched;
  final DateTime selectedDateTime;
  final String selectedHostelCode;
  final String hostelName;

  const ConfirmSwitchPopupScreen({
    Key key,
    this.token,
    this.id,
    this.mealStartDateTime,
    this.title,
    this.menuToWhichToBeSwitched,
    this.dailyItemsToWhichToBeSwitched,
    this.selectedDateTime,
    this.selectedHostelCode,
    this.hostelName
  }) : super(key: key);

  @override
  _ConfirmSwitchPopupScreenState createState() =>
      _ConfirmSwitchPopupScreenState();
}

class _ConfirmSwitchPopupScreenState extends State<ConfirmSwitchPopupScreen> {
  static final double _radius = 16;
  int currentHostelMealId;

  InheritedData inheritedData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (inheritedData == null) {
      inheritedData = InheritedData.of(context);
    }
  }

  List<CircleAvatar> mealFromWhichToBeSwitchedLeadingImageList = [];
  List<String> mealFromWhichToBeSwitchedItemsList = [];
  Map<CircleAvatar, String> mealFromWhichToBeSwitchedMap = {};
  String mealFromWhichToBeSwitchedDailyItems = '';

  void setLeadingMealImage(List<CircleAvatar> mealLeadingImageList) {
    var randomColor =
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
            .withOpacity(0.2);
    mealLeadingImageList.add(CircleAvatar(
      radius: _radius,
      backgroundColor: randomColor,
    ));
  }

  void setMealFromWhichToBeSwitchedComponents(Meal mealFromWhichToBeSwitched) {
    mealFromWhichToBeSwitchedItemsList = [];
    mealFromWhichToBeSwitchedLeadingImageList = [];
    for (var j = 0; j < mealFromWhichToBeSwitched.items.length; j++) {
      var mealItem = mealFromWhichToBeSwitched.items[j].name;
      mealFromWhichToBeSwitchedItemsList.add(mealItem);
      setLeadingMealImage(mealFromWhichToBeSwitchedLeadingImageList);
    }
  }

  Map<String, MealType> titleToMealTypeMap = {
    "Breakfast": MealType.B,
    "Lunch": MealType.L,
    "Snacks": MealType.S,
    "Dinner": MealType.D,
  };

  TextStyle getSwitchToOrFromStyle() {
    return TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Confirm Meal Switch",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: Container(),
        backgroundColor: appiBrown,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: menuWeekMultiMessing(
          widget.token,
          DateTimeUtils.getWeekNumber(widget.selectedDateTime),
          hostelCodeMap[widget.hostelName],
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(appiYellow),
                ),
              ),
            );
          } else {
            snapshot.data.days.forEach((dayMenu) {
              String mealDateString = dayMenu.date.toString().substring(0, 10);
              dayMenu.meals.forEach((mealMenu) {
                if (mealDateString ==
                        widget.mealStartDateTime.toString().substring(0, 10) &&
                    titleToMealTypeMap[widget.title] == mealMenu.type) {
                  currentHostelMealId = mealMenu.id;
                  setMealFromWhichToBeSwitchedComponents(mealMenu);
                  mealFromWhichToBeSwitchedMap = Map.fromIterables(
                    mealFromWhichToBeSwitchedLeadingImageList,
                    mealFromWhichToBeSwitchedItemsList,
                  );
                }
              });
            });

            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Switch From",
                          style: getSwitchToOrFromStyle(),
                        ),
                      ),
                      SwitchConfirmationMealCard(
                        token: widget.token,
                        id: widget.id,
                        title: widget.title,
                        menuItems: mealFromWhichToBeSwitchedMap,
                        dailyItems: mealFromWhichToBeSwitchedDailyItems,
                        mealStartDateTime: widget.mealStartDateTime,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Image.asset(
                            "assets/icons/switch_active.png",
                            scale: 1.5,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Switch To",
                          style: getSwitchToOrFromStyle(),
                        ),
                      ),
                      SwitchConfirmationMealCard(
                        token: widget.token,
                        id: widget.id,
                        title: widget.title,
                        menuItems: widget.menuToWhichToBeSwitched,
                        dailyItems: widget.dailyItemsToWhichToBeSwitched,
                        mealStartDateTime: widget.mealStartDateTime,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            child: Text(
                              "CANCEL",
                              style: TextStyle(
                                color: appiYellow,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          FlatButton(
                            child: Text(
                              "SWITCH",
                              style: TextStyle(
                                color: appiYellow,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () {
                              showCustomDialog(context, "Switching Meals");
                              switchMeals(
                                currentHostelMealId,
                                widget.selectedHostelCode,
                                widget.token,
                              ).then((switchResponse) {
                                Provider.of<OtherMenuModel>(context,
                                        listen: false)
                                    .getOtherMenu(DateTimeUtils.getWeekNumber(
                                        widget.mealStartDateTime));
                                Provider.of<YourMenuModel>(context,
                                        listen: false)
                                    .selectedWeekMenuYourMeals(
                                        DateTimeUtils.getWeekNumber(
                                            widget.mealStartDateTime));
                                if (switchResponse == true) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ConfirmedSwitchScreen(),
                                    ),
                                  );
                                } else {
                                  Navigator.pop(context);
                                  Fluttertoast.showToast(
                                      msg: "Cannot switch meals");
                                }
                              });
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
