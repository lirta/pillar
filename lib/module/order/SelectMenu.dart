import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pillar_app/module/order/pettern/OrderPresenter.dart';
import 'package:pillar_app/module/order/pettern/OrderView.dart';
import 'package:pillar_app/module/order/pettern/OrderWidget.dart';

class SelectMenu extends StatefulWidget {
  const SelectMenu({Key key}) : super(key: key);

  @override
  State<SelectMenu> createState() => _SelectMenuState();
}

class _SelectMenuState extends State<SelectMenu>
    with TickerProviderStateMixin
    implements OrderView {
  OrderPresener orderPresener;
  TabController tabController;
  List dataMenuCat;

  @override
  void initState() {
    super.initState();
    orderPresener = new OrderPresener();
    orderPresener.attachView(this);
    getCredential();
  }

  getCredential() async {
    if (!mounted) return;
    await orderPresener.getMenu();
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
          title: Text("Pilih Menu"),
          centerTitle: true,
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
                          child: displayCatList(context, cat, setMenu),
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

  void setMenu(String value) async {
    Navigator.of(context).pop(value);
  }

  Future<Null> onRefresh() async {
    await orderPresener.getMenu();
  }

  @override
  onFailGetOrder(Map data) {
    // TODO: implement onFailGetOrder
    throw UnimplementedError();
  }

  @override
  onNetworkError() {
    // TODO: implement onNetworkError
    throw UnimplementedError();
  }

  @override
  onSuccessGetOrder(Map data) {
    // TODO: implement onSuccessGetOrder
    throw UnimplementedError();
  }

  @override
  onFailetMenu(Map data) {
    // TODO: implement onFailetMenu
    throw UnimplementedError();
  }

  @override
  onSuccessGetMenu(Map data) {
    // TODO: implement onSuccessGetMenu
    // throw UnimplementedError();
    setState(() {
      dataMenuCat = data['message'];
      getDataTabBar();
    });
  }

  @override
  onFaildGetMenu(Map data) {
    // TODO: implement onFaildGetMenu
    throw UnimplementedError();
  }
}
