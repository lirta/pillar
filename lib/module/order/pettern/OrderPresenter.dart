import 'dart:convert';

import 'package:pillar_app/Network/AppDataManager.dart';
import 'package:pillar_app/Network/NetworkUtils.dart';
import 'package:pillar_app/base/BasePresenter.dart';
import 'package:pillar_app/module/order/pettern/OrderView.dart';

class OrderPresener extends BasePresenter<OrderView> {
  Map data;
  Future getOrdersList() async {
    checkViewAttached();
    var response = await appDataManager.apiHelper.getOrderDay();
    data = json.decode(response.body);
    if (NetworkUtils.isReqSuccess(response)) {
      isViewAttached ? getView().onSuccessGetOrder(data) : null;
    } else {
      isViewAttached ? getView().onFailGetOrder(data) : null;
    }
  }

  Future getMenu() async {
    checkViewAttached();
    var response = await appDataManager.apiHelper.getMenu();
    data = json.decode(response.body);
    if (NetworkUtils.isReqSuccess(response)) {
      isViewAttached ? getView().onSuccessGetMenu(data) : null;
    } else {
      isViewAttached ? getView().onFaildGetMenu(data) : null;
    }
  }
}
