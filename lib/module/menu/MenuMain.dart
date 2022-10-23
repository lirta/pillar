import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pillar_app/model/User.dart';
import 'package:pillar_app/module/menu/MenuForm.dart';
import 'package:pillar_app/module/menu/pattern/MenuPresenter.dart';
import 'package:pillar_app/module/menu/pattern/MenuView.dart';
import 'package:pillar_app/module/menu/pattern/MenuWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuMain extends StatefulWidget {
  const MenuMain({Key key}) : super(key: key);

  @override
  State<MenuMain> createState() => _MenuMainState();
}

class _MenuMainState extends State<MenuMain>
    with TickerProviderStateMixin
    implements MenuView {
  MenuPresenter menuPresenter;
  List dataMenuCat;
  TabController tabController;
  User user;
  @override
  void initState() {
    super.initState();
    menuPresenter = new MenuPresenter();
    menuPresenter.attachView(this);
    getCredential();
  }

  getCredential() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map data = jsonDecode(prefs.getString("user"));
    // setState(() {
    //   user = User.fromJson(data['user']);
    // });
    menuPresenter.getMenu();
  }

  getDataTabBar() async {
    if (tabController != null) {
      tabController = new TabController(
          vsync: this,
          length: dataMenuCat.length,
          initialIndex: tabController.index);
    } else {
      tabController =
          new TabController(vsync: this, length: dataMenuCat.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Menu"),
          centerTitle: true,
          actions: <Widget>[
            InkWell(
              onTap: () async {
                final newmenu = await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) => MenuForm(type: "add"),
                        settings: RouteSettings(name: "Menu add From")));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(FontAwesomeIcons.plus, size: 20),
              ),
            ),
            SizedBox(
              width: 10,
            )
          ],
          bottom: dataMenuCat != null && tabController != null
              ? TabBar(
                  isScrollable: true,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white,
                  controller: tabController,
                  indicatorColor: Colors.amber,
                  indicatorWeight: 4.0,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    color: Colors.grey,
                  ),
                  tabs: dataMenuCat
                      .map((cat) => Container(
                            margin: EdgeInsets.only(left: 6, right: 6),
                            child: Tab(text: cat['nama_ket'].toString()),
                          ))
                      .toList(),
                )
              : null,
        ),
        body: dataMenuCat != null && tabController != null
            ? TabBarView(
                controller: tabController,
                children: dataMenuCat
                    .map((cat) => RefreshIndicator(
                          onRefresh: onRefresh,
                          child: displayCatList(context, cat),
                        ))
                    .toList(),
              )
            : Center(
                child: CircularProgressIndicator(
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(Color(0xff000000)),
                ),
              ));
  }

  Future<Null> onRefresh() async {
    await menuPresenter.getMenu();
  }

  @override
  onFaildGetMenu(Map data) {
    // TODO: implement onFaildGetMenu
    // throw UnimplementedError();
  }

  @override
  onSuccessGetMenu(Map data) {
    // TODO: implement onSuccessGetMenu
    // throw UnimplementedError();
    if (this.mounted) {
      setState(() {
        dataMenuCat = data['message'];
        getDataTabBar();
      });
    }
  }

  @override
  onFaildGetCat(Map data) {
    // TODO: implement onFaildGetCat
    throw UnimplementedError();
  }

  @override
  onSuccessGetCat(Map data) {
    // TODO: implement onSuccessGetCat
    throw UnimplementedError();
  }

  @override
  onFailedAddMenu(Map data) {
    // TODO: implement onFailedAddMenu
    throw UnimplementedError();
  }

  @override
  onSuccessAddMenu(Map data) {
    // TODO: implement onSuccessAddMenu
    throw UnimplementedError();
  }

  @override
  onFailedGetDetailMenu(Map data) {
    // TODO: implement onFailedGetDetailMenu
    throw UnimplementedError();
  }

  @override
  onSuccessGetDetailMenu(Map data) {
    // TODO: implement onSuccessGetDetailMenu
    throw UnimplementedError();
  }

  @override
  onFailedhapusMenu(Map data) {
    // TODO: implement onFailedhapusMenu
    throw UnimplementedError();
  }

  @override
  onSuccesshapusMenu(Map data) {
    // TODO: implement onSuccesshapusMenu
    throw UnimplementedError();
  }
}
