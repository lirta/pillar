import 'dart:convert';

import 'package:pillar_app/Network/AppDataManager.dart';
import 'package:pillar_app/Network/NetworkUtils.dart';
import 'package:pillar_app/base/BasePresenter.dart';
import 'package:pillar_app/model/Menu.dart';
import 'package:pillar_app/module/menu/pattern/MenuView.dart';

class MenuPresenter extends BasePresenter<MenuView> {
  Map data;

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

  Future getCat() async {
    checkViewAttached();
    var response = await appDataManager.apiHelper.getCat();
    data = json.decode(response.body);
    if (NetworkUtils.isReqSuccess(response)) {
      isViewAttached ? getView().onSuccessGetCat(data) : null;
    } else {
      isViewAttached ? getView().onFaildGetCat(data) : null;
    }
  }

  Future getDetailMenu(String id) async {
    checkViewAttached();
    var response = await appDataManager.apiHelper.getDetailMenu(id);
    data = json.decode(response.body);
    if (NetworkUtils.isReqSuccess(response)) {
      isViewAttached ? getView().onSuccessGetDetailMenu(data) : null;
    } else {
      isViewAttached ? getView().onFailedGetDetailMenu(data) : null;
    }
  }

  Future hapusMenu(String id) async {
    checkViewAttached();
    var response = await appDataManager.apiHelper.hapusMenu(id);
    print(response.body);
    data = json.decode(response.body);
    if (NetworkUtils.isReqSuccess(response)) {
      isViewAttached ? getView().onSuccesshapusMenu(data) : null;
    } else {
      isViewAttached ? getView().onFailedhapusMenu(data) : null;
    }
  }

  Future addMenu(Menu menu) async {
    print("pre product");
    print(menu.toAddMenu());
    print(menu.foto);
    checkViewAttached();
    var response = await appDataManager.apiHelper.addMenu(menu);
    response.stream.transform(utf8.decoder).listen((value) async {
      // print(value);
      data = await json.decode(value);
      print("masuk sini add product");
      print(data);
      if (NetworkUtils.isReqSuccessBody(value)) {
        isViewAttached ? getView().onSuccessAddMenu(data) : null;
      } else {
        isViewAttached ? getView().onFailedAddMenu(data) : null;
      }
    });
  }

  Future editMenu(Menu menu) async {}
}
