import 'dart:convert';

import 'package:pillar_app/Network/AppDataManager.dart';
import 'package:pillar_app/Network/NetworkUtils.dart';
import 'package:pillar_app/base/BasePresenter.dart';
import 'package:pillar_app/module/login/pattren/LoginView.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPresenter extends BasePresenter<LoginView> {
  Map data;
  Future signIn({String username, String password}) async {
    checkViewAttached();
    print(username + password + " presenter data");
    var response = await appDataManager.apiHelper.signIn(username, password);
    data = json.decode(response.body);
    if (NetworkUtils.isReqSuccess(response)) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("IS_LOGIN", true);
      prefs.setString("user", response.body);
      isViewAttached ? getView().onSuccessLogin(data) : null;
    } else {
      isViewAttached ? getView().onFailLogin(data) : null;
    }
  }
}
