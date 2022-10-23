import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pillar_app/module/home/HomeMain.dart';
import 'package:pillar_app/module/login/LoginMain.dart';
import 'package:pillar_app/module/splash/pattern/SplashPresenter.dart';
import 'package:pillar_app/util/SharedPref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  SplashPresenter splashPresenter;
  SharedPreferences prefs;
  SharedPref sharedPref = SharedPref();
  bool isLogin = false;
  dynamic page;

  // getCredential() async {
  //   if (this.mounted) {
  //     bool checkLogin = prefs.containsKey(sharedPref.IS_LOGIN)
  //         ? prefs.getBool(sharedPref.IS_LOGIN)
  //         : false;

  //     setState(() {
  //       isLogin = checkLogin;
  //     });
  //     if (isLogin) {
  //       setState(() {
  //         page = HomeMain();
  //       });
  //     } else {
  //       setState(() {
  //         page = LoginMain();
  //       });
  //     }
  //   }
  // }
  @override
  void initState() {
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => LoginMain())));
  }

  @override
  Widget build(BuildContext context) {
    // ScreenUtil.init(context, allowFontScaling: true);
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Image.asset(
            "assets/images/logo.png",
          ),
        ),
      ),
    );
  }
}
