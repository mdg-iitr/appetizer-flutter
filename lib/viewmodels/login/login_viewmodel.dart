import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/user/oauth_user.dart';
import 'package:appetizer/models/user/user.dart';
import 'package:appetizer/services/api/user_api.dart';
import 'package:appetizer/services/dialog_service.dart';
import 'package:appetizer/ui/home_view.dart';
import 'package:appetizer/ui/password/choose_new_password_view.dart';
import 'package:appetizer/utils/snackbar_utils.dart';
import 'package:appetizer/viewmodels/base_model.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class LoginViewModel extends BaseModel {
  final UserApi _userApi = locator<UserApi>();
  final DialogService _dialogService = locator<DialogService>();

  User _user;

  User get user => _user;

  set user(User user) {
    _user = user;
    notifyListeners();
  }

  bool _isLoginSuccessful = false;

  bool get isLoginSuccessful => _isLoginSuccessful;

  set isLoginSuccessful(bool isLoginSuccessful) {
    _isLoginSuccessful = isLoginSuccessful;
    notifyListeners();
  }

  bool _areCredentialsCorrect;

  bool get areCredentialsCorrect => _areCredentialsCorrect;

  set areCredentialsCorrect(bool areCredentialsCorrect) {
    _areCredentialsCorrect = areCredentialsCorrect;
    notifyListeners();
  }

  var _oauthUser;

  OAuthUser get oauthUser => _oauthUser;

  set oauthUser(OAuthUser oauthUser) {
    _oauthUser = oauthUser;
    notifyListeners();
  }

  Future loginWithEnrollmentAndPassword(
      {String enrollment, String password}) async {
    setState(ViewState.Busy);
    try {
      user = await _userApi.userLogin(enrollment, password);
      isLoginSuccessful = true;
      token = user.token;
      isLoggedIn = true;
      isCheckedOut = user.isCheckedOut;
      currentUser = user;
      var fcm = FirebaseMessaging();
      await fcm.subscribeToTopic('release-' + user.hostelCode);
      setState(ViewState.Idle);
    } on Failure catch (f) {
      setState(ViewState.Error);
      setErrorMessage(f.message);
      isLoginSuccessful = false;
    }
  }

  Future getOAuthResponse(String code) async {
    try {
      oauthUser = await _userApi.oAuthRedirect(code);
    } on Failure catch (f) {
      setState(ViewState.Error);
      setErrorMessage(f.message);
      SnackBarUtils.showDark(f.message);
    }
  }

  Future verifyUser(String code) async {
    _dialogService.showCustomProgressDialog(title: 'Fetching Details');
    await getOAuthResponse(code);
    _dialogService.popDialog();

    if (oauthUser != null) {
      var studentData = oauthUser.studentData;
      if (oauthUser.isNew) {
        _dialogService.showCustomProgressDialog(title: 'Redirecting');
        await Future.delayed(Duration(milliseconds: 500));
        _dialogService.popDialog();
        await Get.offNamed(ChooseNewPasswordView.id, arguments: studentData);
      } else if (oauthUser.token != null) {
        _dialogService.showCustomProgressDialog(title: 'Logging You In');
        token = oauthUser.token;
        isLoggedIn = true;
        currentUser = studentData;
        await Future.delayed(const Duration(milliseconds: 500));
        _dialogService.popDialog();
        await Get.offAllNamed(HomeView.id);
      }
    }
  }
}
