import 'dart:convert';

import 'package:appetizer/constants.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/feed_back/feed_back.dart';
import 'package:appetizer/models/feed_back/responses.dart';
import 'package:appetizer/models/feed_back/submitted_feedbacks.dart';
import 'package:appetizer/utils/api_utils.dart';
import 'package:http/http.dart' as http;

class FeedbackApi {
  var headers = {"Content-Type": "application/json"};
  http.Client client = new http.Client();

  Future<List<Feedbacks>> submittedFeedBacks() async {
    String endpoint = "/api/feedback/all/";
    String uri = url + endpoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(uri, headers: headers);
      SubmittedFeedbacksList list =
          new SubmittedFeedbacksList.fromJson(jsonResponse);
      return list.feedbacks;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<List<Response>> responseOfFeedBacks() async {
    String endpoint = "/api/feedback/response/list/";
    String uri = url + endpoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(uri, headers: headers);
      List<Response> list = responseFromJson(json.encode(jsonResponse));
      return list;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<Feedback> newFeedBack(
      String type, String title, String message, DateTime dateIssue) async {
    String endpoint = "/api/feedback/";
    String uri = url + endpoint;
    var json = {
      "type": type,
      "title": title,
      "message": message,
      "date_issue": dateIssue.millisecondsSinceEpoch.toString()
    };

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.post(uri, headers: headers, body: json);
      Feedback feedback = new Feedback.fromJson(jsonResponse);
      return feedback;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  static resolveFeedbackTypeCode(String str) {
    switch (str) {
      case "gn":
        return "General";
      case "am":
        return "Ambience";
      case "hc":
        return "Hygiene and Cleanliness";
      case "tm":
        return "Mess Timings";
      case "wm":
        return "Weekly Menu";
      case "ws":
        return "Worker and Services";
      case "dn":
        return "Diet and Nutrition";
    }
  }
}
