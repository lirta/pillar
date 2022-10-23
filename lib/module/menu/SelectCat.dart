import 'package:flutter/material.dart';
import 'package:pillar_app/module/menu/pattern/MenuPresenter.dart';
import 'package:pillar_app/module/menu/pattern/MenuView.dart';
import 'package:pillar_app/module/menu/pattern/MenuWidget.dart';

class SelectCat extends StatefulWidget {
  const SelectCat({Key key}) : super(key: key);

  @override
  State<SelectCat> createState() => _SelectCatState();
}

class _SelectCatState extends State<SelectCat>
    with TickerProviderStateMixin
    implements MenuView {
  MenuPresenter menuPresenter;
  bool isLogin = false, isFailed = false, isSearch = false;
  List dataCat;
  TextEditingController searchCont = TextEditingController();
  String errorMessage = "", keyword = "";
  String decoded = "";

  @override
  Future<void> initState() {
    super.initState();
    menuPresenter = new MenuPresenter();
    menuPresenter.attachView(this);
    // productPresenter.getListProductCat();
    getCredential();
  }

  getCredential() async {
    menuPresenter.getCat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            height: 80,
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                fillColor: Color(0xfff1f1f1),
                filled: true,
                hintText: 'Cari Kategori Product',
                hintStyle: TextStyle(
                    color: Colors.grey, fontSize: 13.0, fontFamily: "Poppins"),
                isDense: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide.none),
                suffixIcon: isSearch
                    ? IconButton(
                        onPressed: onClear,
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.grey,
                        ))
                    : null,
              ),
              // onChanged: onTextChanged,
            ),
          ),
        ),
        body: dataCat == null
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              )
            : isFailed
                ? displayNotFound()
                : getCatList(context, dataCat, onRefresh, isFailed, setToForm));
  }

  void setToForm(String value) async {
    Navigator.of(context).pop(value);
  }

  void onClear() async {
    WidgetsBinding.instance.addPostFrameCallback((_) => searchCont.clear());
    if (mounted) {
      setState(() {
        isSearch = false;
      });
    }
  }

  Future onRefresh() async {
    await menuPresenter.getCat();
  }

  Widget displayNotFound() {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(child: Text(errorMessage))),
          ],
        ),
      ),
    );
  }

  @override
  onFaildGetMenu(Map data) {
    // TODO: implement onFaildGetMenu
    throw UnimplementedError();
  }

  @override
  onSuccessGetMenu(Map data) {
    // TODO: implement onSuccessGetMenu
    throw UnimplementedError();
  }

  @override
  onFaildGetCat(Map data) {
    // TODO: implement onFaildGetCat
    // throw UnimplementedError();
    if (this.mounted) {
      setState(() {
        print(data['errorMessage']);
      });
    }
  }

  @override
  onSuccessGetCat(Map data) {
    // TODO: implement onSuccessGetCat
    // throw UnimplementedError();
    if (this.mounted) {
      setState(() {
        dataCat = data['message'];
        print("sucses data ket" + dataCat.toString());
        // print("ini data kategori produk : " + dataProdCat.toString());
        // getDataTabBar();
      });
    }
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
