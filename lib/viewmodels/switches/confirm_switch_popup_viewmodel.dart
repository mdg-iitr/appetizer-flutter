import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/menu/week_menu.dart';
import 'package:appetizer/services/api/menu_api.dart';
import 'package:appetizer/services/api/multimessing_api.dart';
import 'package:appetizer/viewmodels/base_model.dart';

class ConfirmSwitchPopupViewModel extends BaseModel {
  final MultimessingApi _multimessingApi = locator<MultimessingApi>();
  final MenuApi _menuApi = locator<MenuApi>();

  bool _isMealSwitched;

  bool get isMealSwitched => _isMealSwitched;

  set isMealSwitched(bool isMealSwitched) {
    _isMealSwitched = isMealSwitched;
    notifyListeners();
  }

  WeekMenu _weekMenuMultimessing;

  WeekMenu get weekMenuMultimessing => _weekMenuMultimessing;

  set weekMenuMultimessing(WeekMenu weekMenuMultimessing) {
    _weekMenuMultimessing = weekMenuMultimessing;
    notifyListeners();
  }

  Future switchMeals(int id, String toHostel) async {
    setState(ViewState.Busy);
    try {
      isMealSwitched = await _multimessingApi.switchMeals(id, toHostel);
      setState(ViewState.Idle);
    } on Failure catch (f) {
      print(f.message);
      setErrorMessage(f.message);
      setState(ViewState.Error);
    }
  }

  Future getMenuWeekMultimessing(int weekId, String hostelCode) async {
    setState(ViewState.Busy);
    try {
      weekMenuMultimessing =
          await _menuApi.weekMenuMultiMessing(weekId, hostelCode);
      setState(ViewState.Idle);
    } on Failure catch (f) {
      print(f.message);
      setErrorMessage(f.message);
      setState(ViewState.Error);
    }
  }
}
