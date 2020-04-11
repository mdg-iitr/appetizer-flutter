import 'dart:io' show Platform;

import 'package:appetizer/models/version_check.dart';
import 'package:appetizer/utils/api_utils.dart';
import 'package:http/http.dart' as http;

class VersionCheckApi {
  String url = "https://appetizer-mdg.herokuapp.com";
  var header = {"Content-Type": "application/json"};
  http.Client client = new http.Client();

  Future<VersionCheck> checkVersion(String versionNumber) async {
    String _platform = Platform.isAndroid ? "an" : "io";
    String endPoint = "/panel/version/expire/$_platform/$versionNumber";
    String uri = url + endPoint;

    try {
      var jsonResponse = await ApiUtils.get(uri, headers: header);
      VersionCheck versionCheck = new VersionCheck.fromJson(jsonResponse);
      return versionCheck;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }
}
