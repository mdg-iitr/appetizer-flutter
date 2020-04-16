import 'package:appetizer/services/analytics_service.dart';
import 'package:appetizer/services/api/feedback.dart';
import 'package:appetizer/services/api/leave.dart';
import 'package:appetizer/services/api/menu.dart';
import 'package:appetizer/services/api/multimessing.dart';
import 'package:appetizer/services/api/transaction.dart';
import 'package:appetizer/services/api/user.dart';
import 'package:appetizer/services/api/version_check.dart';
import 'package:appetizer/services/dialog_service.dart';
import 'package:appetizer/services/local_storage_service.dart';
import 'package:appetizer/services/navigation_service.dart';
import 'package:appetizer/services/push_notification_service.dart';
import 'package:appetizer/services/remote_config_service.dart';
import 'package:appetizer/viewmodels/faq_models/faq_model.dart';
import 'package:appetizer/viewmodels/feedback_models/new_feedback_model.dart';
import 'package:appetizer/viewmodels/feedback_models/user_feedback_model.dart';
import 'package:appetizer/viewmodels/home_model.dart';
import 'package:appetizer/viewmodels/leaves_models/leave_status_card_model.dart';
import 'package:appetizer/viewmodels/leaves_models/leave_timeline_model.dart';
import 'package:appetizer/viewmodels/leaves_models/my_leaves_model.dart';
import 'package:appetizer/viewmodels/login_models/login_model.dart';
import 'package:appetizer/viewmodels/menu_models/menu_cards_model.dart';
import 'package:appetizer/viewmodels/menu_models/other_menu_model.dart';
import 'package:appetizer/viewmodels/menu_models/your_menu_model.dart';
import 'package:appetizer/viewmodels/multimessing_models/qr_genrator_model.dart';
import 'package:appetizer/viewmodels/multimessing_models/switchable_meals_model.dart';
import 'package:appetizer/viewmodels/notification_models/notifications_model.dart';
import 'package:appetizer/viewmodels/password_models/forgot_password_model.dart';
import 'package:appetizer/viewmodels/password_models/new_password_model.dart';
import 'package:appetizer/viewmodels/password_models/reset_password_model.dart';
import 'package:appetizer/viewmodels/rebates_models/my_rebates_model.dart';
import 'package:appetizer/viewmodels/rebates_models/rebate_history_model.dart';
import 'package:appetizer/viewmodels/settings_models/edit_profile_model.dart';
import 'package:appetizer/viewmodels/settings_models/settings_model.dart';
import 'package:appetizer/viewmodels/startup_view_model.dart';
import 'package:appetizer/viewmodels/switch_models/confirm_switch_popup_model.dart';
import 'package:appetizer/viewmodels/switch_models/my_switches_model.dart';
import 'package:appetizer/viewmodels/switch_models/switch_status_card_model.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => FeedbackApi());
  locator.registerLazySingleton(() => LeaveApi());
  locator.registerLazySingleton(() => MenuApi());
  locator.registerLazySingleton(() => MultimessingApi());
  locator.registerLazySingleton(() => TransactionApi());
  locator.registerLazySingleton(() => UserApi());
  locator.registerLazySingleton(() => VersionCheckApi());

  locator.registerLazySingleton(() => PushNotificationService());
  locator.registerLazySingleton(() => AnalyticsService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());

  var remoteConfigService = await RemoteConfigService.getInstance();
  locator.registerSingleton(remoteConfigService);

  var localStorageService = await LocalStorageService.getInstance();
  locator.registerSingleton<LocalStorageService>(localStorageService);

  locator.registerFactory(() => StartUpViewModel());
  locator.registerFactory(() => FaqModel());
  locator.registerFactory(() => NewFeedbackModel());
  locator.registerFactory(() => UserFeedbackModel());
  locator.registerFactory(() => LeaveStatusCardModel());
  locator.registerFactory(() => LeaveTimelineModel());
  locator.registerFactory(() => MyLeavesModel());
  locator.registerFactory(() => LoginModel());
  locator.registerFactory(() => MenuCardsModel());
  locator.registerFactory(() => OtherMenuModel());
  locator.registerFactory(() => YourMenuModel());
  locator.registerFactory(() => QRGeneratorModel());
  locator.registerFactory(() => SwitchableMealsModel());
  locator.registerFactory(() => NotificationsModel());
  locator.registerFactory(() => ForgotPasswordModel());
  locator.registerFactory(() => NewPasswordModel());
  locator.registerFactory(() => ResetPasswordModel());
  locator.registerFactory(() => MyRebatesModel());
  locator.registerFactory(() => RebateHistoryModel());
  locator.registerFactory(() => EditProfileModel());
  locator.registerFactory(() => SettingsModel());
  locator.registerFactory(() => ConfirmSwitchPopupModel());
  locator.registerFactory(() => MySwitchesModel());
  locator.registerFactory(() => SwitchStatusCardModel());
  locator.registerFactory(() => HomeModel());
}
