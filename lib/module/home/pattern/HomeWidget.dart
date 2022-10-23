import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pillar_app/model/User.dart';
import 'package:pillar_app/module/menu/MenuMain.dart';
import 'package:pillar_app/module/order/OrderMain.dart';

Widget displayBoxProfile(
    BuildContext context, User user, String userPic, Function getProfile) {
  return Container(
    margin: EdgeInsets.all(8),
    padding: EdgeInsets.only(top: 10, left: 12, bottom: 14, right: 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Colors.blue[300],
    ),
    child: Row(
      children: <Widget>[
        userPic.isNotEmpty
            ? CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(userPic),
              )
            : CircleAvatar(
                radius: 50,
                backgroundColor: Colors.black,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Image.asset("assets/images/ic_default_user.webp"),
                ),
              ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(user.nama,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(height: 2),
                Text(
                  user.akses == "2" ? "Kasir" : "Owner",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 2),
                Row(
                  children: <Widget>[
                    Icon(Icons.call, size: 16),
                    SizedBox(width: 4.0),
                    Text(
                      user.hp.isEmpty ? "-" : "0" + user.hp.substring(2),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(FontAwesomeIcons.whatsapp, size: 16),
                    SizedBox(width: 4.0),
                    Text(
                      user.hp.isEmpty ? "-" : "0" + user.hp.substring(2),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: <Widget>[
                    ButtonTheme(
                      height: 30,
                      child: RaisedButton(
                        onPressed: () async {
                          // final result = await Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (_) =>
                          //         SettingsMain(adminId: admin.adminId),
                          //     settings: RouteSettings(
                          //         name: "/Settings", arguments: Map()),
                          //   ),
                          // );
                          // if (result != null) {
                          //   getProfile();
                          // }
                        },
                        elevation: 0,
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                        color: Colors.white,
                        child: Text(
                          "My Account",
                          style: TextStyle(letterSpacing: 1, fontSize: 12),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            side: BorderSide(color: Colors.black45)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    ),
    // ),
  );
}

Widget displayBoxFirstMenu(BuildContext context) {
  return Container(
    color: Colors.white,
    child: Material(
      type: MaterialType.transparency,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => MenuMain(),
                    settings: RouteSettings(name: "Menu")));
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("assets/images/m.jpg", width: 45, height: 45),
                    SizedBox(height: 5),
                    Text(
                      "Menu",
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => OrderMain(),
                    settings: RouteSettings(name: "Menu")));
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("assets/images/m.jpg", width: 70, height: 45),
                    SizedBox(height: 5),
                    Text(
                      "Order",
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
