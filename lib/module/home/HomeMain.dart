import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pillar_app/model/User.dart';
import 'package:pillar_app/module/home/pattern/HomePresenter.dart';
import 'package:pillar_app/module/home/pattern/HomeView.dart';
import 'package:pillar_app/module/home/pattern/HomeWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({Key key}) : super(key: key);

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain>
    with WidgetsBindingObserver
    implements HomeView {
  HomePresenter homePresenter;
  List datamenu;
  User user;
  bool isLogin = false;
  String userPic = "";
  @override
  void initState() {
    super.initState();
    homePresenter = new HomePresenter();
    homePresenter.attachView(this);
    WidgetsBinding.instance.addObserver(this);
    getCredential();
  }

  getCredential() async {
    if (!mounted) return;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogin = prefs.containsKey("IS_LOGIN") ? prefs.getBool("IS_LOGIN") : false;
    if (isLogin) {
      final Map data = jsonDecode(prefs.getString("user"));
      setState(() {
        user = User.fromJson(data['message']);
        if (user.foto.isNotEmpty) {
          userPic = "http://10.0.2.2:8000/foto_kariawan" +
              "/" +
              data['message']['foto'];
        }
      });
    }
  }

  Future<Null> onRefresh() async {}
  getProfile() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 245, 245, 1),
      appBar: AppBar(
        title: Text(
          "Pillar Cofe & Resto",
          style: TextStyle(fontSize: 15),
        ),
        backgroundColor: Colors.black87,
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              user != null
                  ? displayBoxProfile(context, user, userPic, getProfile)
                  : Container(
                      padding: EdgeInsets.all(16),
                      color: Colors.white,
                      child: Center(
                        child: Text("User Tidak ditemukan"),
                      ),
                    ),
              SizedBox(height: 20),
              displayBoxFirstMenu(context),
            ],
          ),
        ),
      ),
    );
  }
}
