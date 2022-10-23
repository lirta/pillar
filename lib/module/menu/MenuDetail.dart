import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pillar_app/model/Menu.dart';
import 'package:pillar_app/module/menu/MenuForm.dart';
import 'package:pillar_app/module/menu/MenuMain.dart';
import 'package:pillar_app/module/menu/pattern/MenuPresenter.dart';
import 'package:pillar_app/module/menu/pattern/MenuView.dart';
import 'package:pillar_app/module/menu/pattern/MenuWidget.dart';

class MenuDetail extends StatefulWidget {
  final String menuId;
  // const MenuDetail({Key key}) : super(key: key);
  MenuDetail({this.menuId});

  @override
  State<MenuDetail> createState() => _MenuDetailState();
}

class _MenuDetailState extends State<MenuDetail> implements MenuView {
  final GlobalKey _menuKey = new GlobalKey();
  MenuPresenter menuPresenter;
  List datadetailmenu;
  bool isFailed = false, isLoading = false;
  String errorMessage;
  File _fileImage;
  int _fileLength;
  List menuEdit;
  Menu datamenu;

  @override
  void initState() {
    menuPresenter = new MenuPresenter();
    menuPresenter.attachView(this);
    menuPresenter.getDetailMenu(widget.menuId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(245, 245, 245, 1),
        appBar: AppBar(
          title: Text("Detail Menu"),
          actions: <Widget>[
            InkWell(
                onTap: () async {
                  final newMenu = await Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) =>
                              MenuForm(type: "edit", menu: datadetailmenu),
                          settings: RouteSettings(name: "Menu add Form")));
                },
                child: Icon(Icons.edit)),
            SizedBox(width: 15),
            InkWell(
              onTap: () async {
                await menuPresenter
                    .hapusMenu(datadetailmenu[0]['id_item_menu'].toString());
              },
              child: Icon(
                Icons.delete,
              ),
            ),
            SizedBox(width: 15)
          ],
        ),
        body: RefreshIndicator(
          onRefresh: onRefresh,
          child: SingleChildScrollView(
              child: datadetailmenu == null || isLoading
                  ? isFailed
                      ? Container(
                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 100.0),
                          height: MediaQuery.of(context).size.height,
                          child: Center(
                            child:
                                Text(errorMessage, textAlign: TextAlign.center),
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 100.0),
                          height: MediaQuery.of(context).size.height,
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor:
                                  new AlwaysStoppedAnimation<Color>(Colors.red),
                            ),
                          ))
                  : Column(
                      children: <Widget>[
                        displayPhotoInfoMenu(context, datadetailmenu),
                        SizedBox(height: 15),
                        // displayDescMenu(context, datadetailmenu)
                      ],
                    )),
        ));
  }

  Future<Null> onRefresh() async {
    setState(() {
      datadetailmenu = null;
      menuPresenter.getDetailMenu(widget.menuId);
    });
  }

  @override
  onFaildGetCat(Map data) {
    // TODO: implement onFaildGetCat
    throw UnimplementedError();
  }

  @override
  onFaildGetMenu(Map data) {
    // TODO: implement onFaildGetMenu
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
  onSuccessGetCat(Map data) {
    // TODO: implement onSuccessGetCat
    throw UnimplementedError();
  }

  @override
  onSuccessGetMenu(Map data) {
    // TODO: implement onSuccessGetMenu
    throw UnimplementedError();
  }

  @override
  onFailedGetDetailMenu(Map data) {
    // TODO: implement onFailedGetDetailMenu
    // throw UnimplementedError();
    if (this.mounted) {
      setState(() {
        isLoading = false;
        isFailed = true;
        errorMessage = data['errorMessage'];
        print("ini detail failed " + errorMessage.toString());
      });
    }
  }

  @override
  onSuccessGetDetailMenu(Map data) {
    // TODO: implement onSuccessGetDetailMenu
    // throw UnimplementedError();
    if (this.mounted) {
      setState(() {
        isLoading = false;
        datadetailmenu = data['message'];
        // datadetailmenu = jsonDecode(data['message']);

        print('ini nama menu ' + datadetailmenu.toString());
        print('ini data menu ' + data['message'].toString());
        // print('ini data menu ' + datamenu.toString());
        // product = Product.fromJson(data['message']);
      });
    }
  }

  @override
  onFailedhapusMenu(Map data) {
    // TODO: implement onFailedhapusMenu
    // throw UnimplementedError();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MenuMain()));
  }

  @override
  onSuccesshapusMenu(Map data) {
    // TODO: implement onSuccesshapusMenu
    // throw UnimplementedError();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MenuMain()));
  }
}
