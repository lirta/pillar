import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pillar_app/base/BaseView.dart';
import 'package:pillar_app/module/home/HomeMain.dart';
import 'package:pillar_app/module/login/pattren/LoginPresenter.dart';
import 'package:pillar_app/module/login/pattren/LoginView.dart';

class LoginMain extends StatefulWidget {
  const LoginMain({Key key}) : super(key: key);

  @override
  State<LoginMain> createState() => _LoginMainState();
}

class _LoginMainState extends State<LoginMain> implements LoginView {
  LoginPresenter loginPresenter;
  static final _formKey = new GlobalKey<FormState>();
  bool autoValidate = false;
  TextEditingController usernameCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  final FocusNode usernameNode = FocusNode();
  final FocusNode passwordNode = FocusNode();
  bool passwordVisible = false;
  String validateUsername(String value) {
    if (value.isEmpty) {
      return 'Username masih kosong';
    }
    return null;
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password masih kosong';
    }
    return null;
  }

  signIn() async {
    if (_formKey.currentState.validate()) {
      loginPresenter.signIn(
          username: usernameCont.text, password: passwordCont.text);
      print(usernameCont.text + " data username");
      print(passwordCont.text + " data pass");
    } else {
      setState(() {
        autoValidate = true;
      });
    }
  }

  @override
  void initState() {
    loginPresenter = LoginPresenter();
    loginPresenter.attachView(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Image.asset("assets/images/logo.png"),
              SizedBox(
                height: 50,
              ),
              Text(
                "Login",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Form(
                  key: _formKey,
                  // autovalidate: autoValidate,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: usernameCont,
                        validator: validateUsername,
                        focusNode: usernameNode,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (trem) {
                          usernameNode.unfocus();
                          FocusScope.of(context).requestFocus(passwordNode);
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          labelText: "Username",
                        ),
                      ),
                      TextFormField(
                        controller: passwordCont,
                        validator: validatePassword,
                        focusNode: passwordNode,
                        obscureText: !passwordVisible,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock, color: Colors.black),
                          labelText: "Password",
                          suffixIcon: IconButton(
                            icon: Icon(
                              passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Color(0xff383838),
                            ),
                            onPressed: () {
                              setState(() {
                                this.passwordVisible = !passwordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 16.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {
                        signIn();
                      },
                      padding: const EdgeInsets.all(16.0),
                      color: Color(0xFFff5A5D),
                      child: Text("SIGN IN",
                          style: TextStyle(color: Colors.white)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  onFailLogin(Map data) {
    if (this.mounted) {
      BaseView().displayToastLong(data['errorMessage']);
    }
  }

  @override
  onNetworkError() {
    if (this.mounted) {
      BaseView().displayToastLong(
          "Jaringan error. Silahkan coba lagi beberapa saat.");
    }
  }

  @override
  onSuccessLogin(Map data) {
    if (this.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => HomeMain()),
        (route) => false,
      );
    }
  }
}
