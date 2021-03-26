import 'dart:convert';

import 'package:appetizer/constants.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/multimessing/meal_switch_from_your_meals.dart';
import 'package:appetizer/models/multimessing/remaining_switch_count.dart';
import 'package:appetizer/models/multimessing/switch_details.dart';
import 'package:appetizer/models/multimessing/switchable_hostels.dart';
import 'package:appetizer/utils/api_utils.dart';
import 'package:http/http.dart' as http;

class MultimessingApi {
  var headers = {"Content-Type": "application/json"};
  http.Client client = new http.Client();

  Future<List<SwitchableMealsForYourMeal>> listSwitchableMeals(int id) async {
    String endpoint = "/api/menu/switch_meal/$id";
    String uri = url + endpoint;
    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(uri, headers: headers);
      List<SwitchableMealsForYourMeal> switchableMeals =
          switchableMealsForYourMealFromJson(json.encode(jsonResponse));
      return switchableMeals;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<SwitchCount> remainingSwitches() async {
    String endPoint = "/api/leave/switch/count/remaining/";
    String uri = url + endPoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(uri, headers: headers);
      SwitchCount switchCount = new SwitchCount.fromJson(jsonResponse);
      return switchCount;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<bool> switchMeals(int mealId, String toHostel) async {
    String endPoint = "/api/leave/switch/";
    String uri = url + endPoint;
    var json = {
      "from_meal": mealId,
      "to_hostel": toHostel,
    };

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var response = await client.post(Uri.parse(uri),
          headers: headers, body: jsonEncode(json));
      if (response.statusCode == 201) {
        return true;
      }
      return false;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<bool> cancelSwitch(int id) async {
    String endPoint = "/api/leave/switch/$id";
    String uri = url + endPoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      final response = await client.delete(Uri.parse(uri), headers: headers);
      if (response.statusCode >= 200 && response.statusCode < 210) {
        return true;
      }
      return false;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<SwitchDetails> getSwitchDetails(int id) async {
    String endpoint = "/api/leave/switch/$id";
    String uri = url + endpoint;
    try {
      await ApiUtils.addTokenToHeaders(headers);
      final jsonResponse = await ApiUtils.get(uri, headers: headers);
      SwitchDetails switchDetails = SwitchDetails.fromJson(jsonResponse);
      return switchDetails;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<List<List<dynamic>>> switchableHostels() async {
    String endPoint = "/api/user/multimessing/hostels";
    String uri = url + endPoint;
    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(uri, headers: headers);
      List<List<dynamic>> switchableHostels =
          switchableHostelsFromJson(json.encode(jsonResponse));
      return switchableHostels;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }
}
