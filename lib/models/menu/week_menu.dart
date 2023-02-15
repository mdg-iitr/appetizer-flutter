import 'dart:convert';

import 'package:appetizer/enums/enum_values.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/utils/date_time_utils.dart';
import 'package:intl/intl.dart';

class WeekMenu {
  int weekId;
  int year;
  dynamic name;
  String? hostelName;
  DailyItems dailyItems;
  List<DayMenu> dayMenus;
  bool isApproved;

  WeekMenu({
    required this.weekId,
    required this.year,
    required this.name,
    this.hostelName,
    required this.dailyItems,
    required this.dayMenus,
    required this.isApproved,
  });

  factory WeekMenu.fromJson(Map<String, dynamic> json) => WeekMenu(
        weekId: json['week_id'],
        year: json['year'],
        name: json['name'],
        hostelName: json['hostel_name'],
        dailyItems: DailyItems.fromJson(json['daily_items']),
        dayMenus:
            List<DayMenu>.from(json['days'].map((x) => DayMenu.fromJson(x))),
        isApproved: json['is_approved'],
      );

  Map<String, dynamic> toJson() => {
        'week_id': weekId,
        'year': year,
        'name': name,
        'hostel_name': hostelName,
        'daily_items': dailyItems.toJson(),
        'days': List<dynamic>.from(dayMenus.map((x) => x.toJson())),
        'is_approved': isApproved,
      };
}

class DailyItems {
  int id;
  List<MealItem> breakfast;
  List<MealItem> lunch;
  List<MealItem> dinner;
  List<MealItem> snack;

  DailyItems({
    required this.id,
    required this.breakfast,
    required this.lunch,
    required this.dinner,
    required this.snack,
  });

  factory DailyItems.fromJson(Map<String, dynamic> json) => DailyItems(
        id: json['id'],
        breakfast: List<MealItem>.from(
          json['breakfast'].map((x) => MealItem.fromJson(x)),
        ),
        lunch: List<MealItem>.from(
          json['lunch'].map((x) => MealItem.fromJson(x)),
        ),
        dinner: List<MealItem>.from(
          json['dinner'].map((x) => MealItem.fromJson(x)),
        ),
        snack: List<MealItem>.from(
          json['snack'].map((x) => MealItem.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'breakfast': List<dynamic>.from(breakfast.map((x) => x.toJson())),
        'lunch': List<dynamic>.from(lunch.map((x) => x.toJson())),
        'dinner': List<dynamic>.from(dinner.map((x) => x.toJson())),
        'snack': List<dynamic>.from(snack.map((x) => x.toJson())),
      };
}

List<MealItem> mealItemFromJson(String str) =>
    List<MealItem>.from(json.decode(str).map((x) => MealItem.fromJson(x)));

String mealItemToJson(List<MealItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MealItem {
  int id;
  MealItemType type;
  String name;

  MealItem({
    required this.id,
    required this.type,
    required this.name,
  });

  factory MealItem.fromJson(Map<String, dynamic> json) => MealItem(
        id: json['id'],
        type: breakfastTypeValues.map[json['type']]!,
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': breakfastTypeValues.reverse[type],
        'name': name,
      };
}

enum MealItemType { MCL, SLD, EXT, MCD, STR, SNK, CPN }

final breakfastTypeValues = EnumValues({
  'ext': MealItemType.EXT,
  'mcd': MealItemType.MCD,
  'mcl': MealItemType.MCL,
  'sld': MealItemType.SLD,
  'snk': MealItemType.SNK,
  'str': MealItemType.STR,
  'cpn': MealItemType.CPN,
});

class DayMenu {
  int id;
  int dayId;
  DateTime date;
  List<Meal> meals;
  late Map<MealType, Meal> mealMap;

  DayMenu({
    required this.id,
    required this.dayId,
    required this.date,
    required this.meals,
  }) {
    mealMap = {};
    meals.forEach((meal) {
      mealMap[meal.type] = meal;
    });
  }

  factory DayMenu.fromJson(Map<String, dynamic> json) => DayMenu(
        id: json['id'],
        dayId: json['day_id'],
        date: DateTime.parse(json['date']),
        meals: List<Meal>.from(
          json['meals'].map(
            (meal) => Meal.fromJson(meal, DateTime.parse(json['date'])),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'day_id': dayId,
        'date': DateTimeUtils.getDashedDate(date),
        'meals': List<dynamic>.from(meals.map((x) => x.toJson())),
      };
}

class Meal {
  int id;
  MealType type;
  CostType? costType;
  List<MealItem> items;
  DateTime startTime;
  DateTime endTime;
  LeaveStatus leaveStatus;
  CouponStatus couponStatus;
  dynamic wastage;
  bool isSwitchable;
  SwitchStatus switchStatus;
  String? hostelName;
  String? secretCode;
  bool isOutdated;
  bool isLeaveToggleOutdated;
  bool isCouponOutdated;
  DateTime startDateTime;
  DateTime endDateTime;

  Meal({
    required this.id,
    required this.type,
    this.costType,
    required this.items,
    required this.startTime,
    required this.endTime,
    required this.leaveStatus,
    required this.wastage,
    required this.isSwitchable,
    required this.switchStatus,
    this.hostelName,
    this.secretCode,
    required this.isOutdated,
    required this.isLeaveToggleOutdated,
    required this.isCouponOutdated,
    required this.startDateTime,
    required this.endDateTime,
    required this.couponStatus,
  });

  factory Meal.fromJson(Map<String, dynamic> json, DateTime date) => Meal(
        id: json['id'],
        type: mealTypeValues.map[json['type']]!,
        costType: costTypeValues.map[json['cost_type']],
        items:
            List<MealItem>.from(json['items'].map((x) => MealItem.fromJson(x))),
        startTime: DateFormat('HH:mm:ss').parse(json['start_time']),
        endTime: DateFormat('HH:mm:ss').parse(json['end_time']),
        leaveStatus: LeaveStatus.fromJson(json['leave_status']),
        couponStatus: CouponStatus.fromJson(json['coupon_status']),
        wastage: json['wastage'],
        isSwitchable: json['is_switchable'] ?? false,
        switchStatus: SwitchStatus.fromJson(json['switch_status']),
        hostelName: json['hostel_name'],
        secretCode: json['secret_code'],
        isOutdated:
            !DateTimeUtils.getDateTimeFromDateAndTime(date, json['start_time'])
                .isAfter(DateTime.now()),
        isLeaveToggleOutdated:
            !DateTimeUtils.getDateTimeFromDateAndTime(date, json['start_time'])
                .subtract(outdatedTime)
                .isAfter(DateTime.now()),
        isCouponOutdated:
            !DateTimeUtils.getDateTimeFromDateAndTime(date, json['start_time'])
                .subtract(outdatedTime * 2)
                .isAfter(DateTime.now()),
        startDateTime:
            DateTimeUtils.getDateTimeFromDateAndTime(date, json['start_time']),
        endDateTime:
            DateTimeUtils.getDateTimeFromDateAndTime(date, json['end_time']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': mealTypeValues.reverse[type],
        'cost_type': costTypeValues.reverse[costType],
        'items': List<dynamic>.from(items.map((x) => x.toJson())),
        'start_time': startTime,
        'end_time': endTime,
        'leave_status': leaveStatus.toJson(),
        'wastage': wastage,
        'is_switchable': isSwitchable,
        'switch_status': switchStatus.toJson(),
        'hostel_name': hostelName,
        'secret_code': secretCode,
      };

  Meal copyWith({
    int? id,
    MealType? type,
    CostType? costType,
    List<MealItem>? items,
    DateTime? startTime,
    DateTime? endTime,
    LeaveStatus? leaveStatus,
    CouponStatus? couponStatus,
    dynamic wastage,
    bool? isSwitchable,
    SwitchStatus? switchStatus,
    String? hostelName,
    String? secretCode,
    bool? isOutdated,
    bool? isLeaveToggleOutdated,
    bool? isCouponOutdated,
    DateTime? startDateTime,
    DateTime? endDateTime,
  }) {
    return Meal(
      id: id ?? this.id,
      type: type ?? this.type,
      costType: costType ?? this.costType,
      items: items ?? this.items,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      leaveStatus: leaveStatus ?? this.leaveStatus,
      couponStatus: couponStatus ?? this.couponStatus,
      wastage: wastage ?? this.wastage,
      isSwitchable: isSwitchable ?? this.isSwitchable,
      switchStatus: switchStatus ?? this.switchStatus,
      hostelName: hostelName ?? this.hostelName,
      secretCode: secretCode ?? this.secretCode,
      isLeaveToggleOutdated:
          isLeaveToggleOutdated ?? this.isLeaveToggleOutdated,
      isOutdated: isOutdated ?? this.isOutdated,
      isCouponOutdated: isCouponOutdated ?? this.isCouponOutdated,
      startDateTime: startDateTime ?? this.startDateTime,
      endDateTime: endDateTime ?? this.endDateTime,
    );
  }

  String get title {
    switch (type) {
      case MealType.B:
        return 'Breakfast';
      case MealType.L:
        return 'Lunch';
      case MealType.S:
        return 'Snacks';
      case MealType.D:
        return 'Dinner';
      default:
        return 'Meal';
    }
  }
}

class LeaveStatus {
  int? id;
  LeaveStatusEnum status;

  LeaveStatus({
    this.id,
    required this.status,
  });

  factory LeaveStatus.fromJson(Map<String, dynamic>? json) => LeaveStatus(
        id: json != null ? json['id'] : null,
        status: json != null
            ? leaveStatusValues.map[json['status'] ?? 'N']!
            : LeaveStatusEnum.N,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': leaveStatusValues.reverse[status],
      };
}

class CouponStatus {
  int? id;
  CouponStatusEnum status;

  CouponStatus({
    this.id,
    required this.status,
  });

  factory CouponStatus.fromJson(Map<String, dynamic>? json) => CouponStatus(
        id: json?['id'],
        status: couponStatusValues.map[json?['status'] ?? 'N']!,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': couponStatusValues.reverse[status],
      };
}

class SwitchStatus {
  int id;
  SwitchStatusEnum status;

  SwitchStatus({
    required this.id,
    required this.status,
  });

  factory SwitchStatus.fromJson(Map<String, dynamic>? json) => SwitchStatus(
        id: json != null ? (json['id'] ?? 0) : 0,
        status: json != null
            ? switchStatusValues.map[json['status'] ?? 'N']!
            : SwitchStatusEnum.N,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': switchStatusValues.reverse[status],
      };
}

enum LeaveStatusEnum { N, A, D, P, U }

enum CouponStatusEnum { N, A }

final couponStatusValues = EnumValues({
  'N': CouponStatusEnum.N,
  'A': CouponStatusEnum.A,
});

final leaveStatusValues = EnumValues({
  'N': LeaveStatusEnum.N,
  'A': LeaveStatusEnum.A,
  'D': LeaveStatusEnum.D,
  'P': LeaveStatusEnum.P,
  'U': LeaveStatusEnum.U
});

enum SwitchStatusEnum { N, A, D, F, T, U }

final switchStatusValues = EnumValues({
  'N': SwitchStatusEnum.N,
  'A': SwitchStatusEnum.A,
  'D': SwitchStatusEnum.D,
  'F': SwitchStatusEnum.F,
  'T': SwitchStatusEnum.T,
  'U': SwitchStatusEnum.U
});

enum CostType { N, S }

final costTypeValues = EnumValues({'N': CostType.N, 'S': CostType.S});

enum MealType { B, L, S, D }

final mealTypeValues = EnumValues(
    {'B': MealType.B, 'D': MealType.D, 'L': MealType.L, 'S': MealType.S});
