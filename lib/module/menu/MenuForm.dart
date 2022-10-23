import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pillar_app/base/BaseFunction.dart';
import 'package:pillar_app/model/Menu.dart';
import 'package:pillar_app/module/menu/MenuMain.dart';
import 'package:pillar_app/module/menu/SelectCat.dart';
import 'package:pillar_app/module/menu/pattern/MenuPresenter.dart';
import 'package:pillar_app/module/menu/pattern/MenuView.dart';
import 'package:pillar_app/module/menu/pattern/MenuWidget.dart';

class MenuForm extends StatefulWidget {
  final String type;
  final List menu;
  const MenuForm({Key key, this.type, this.menu}) : super(key: key);

  @override
  State<MenuForm> createState() => _MenuFormState();
}

class _MenuFormState extends State<MenuForm> with MenuView {
  MenuPresenter menuPresenter;
  bool isLogin = false,
      isFailed = false,
      btnLoad = false,
      autoValidate = false,
      isLoading = false;
  final formKey = new GlobalKey<FormState>();
  String dataSelCatNama;
  String dataSelCatId;
  File fileImage;
  int jml;
  String oldPicture = "";
  TextEditingController nama = TextEditingController();
  TextEditingController hargaModal = TextEditingController();
  TextEditingController harga = TextEditingController();
  TextEditingController codeCatName = TextEditingController();
  Menu menudata;
  var codeCatId;
  File _fileImage;
  int _fileLength;
  String menu_id;
  String kType;

  @override
  void initState() {
    super.initState();
    menuPresenter = new MenuPresenter();
    menuPresenter.attachView(this);
    getCredential();
  }

  getCredential() async {
    kType = widget.type;
    if (widget.type == "edit") {
      menu_id = widget.menu[0]['id_item_menu'].toString();
      nama.text = widget.menu[0]['nama_menu'].toString();
      hargaModal.text = widget.menu[0]['modal'].toString();
      harga.text = widget.menu[0]['harga'].toString();
      oldPicture = widget.menu[0]['foto'].toString();
    } else {
      print("menu tidak ada");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.type == "edit" ? "Edit Menu" : "Tambah Menu"),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: displayMenuForm(
          context,
          kType,
          formKey,
          nama,
          hargaModal,
          harga,
          selectCat,
          codeCatName,
          jml,
          _showChoiceDialog,
          _fileImage,
          oldPicture,
          uploadImage,
        ),
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        height: 48,
        child: MaterialButton(
          onPressed: () {
            submit();
//            displayPopUp();
          },
          color: btnLoad ? null : Color(0xffED8811),
          child: btnLoad
              ? CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                )
              : Text(
                  "Simpan",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins",
                      fontSize: 15,
                      color: Colors.white),
                ),
        ),
      ),
    );
  }

  void submit() async {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        btnLoad = true;
      });
      sendData();
    } else {
      setState(() {
        this.autoValidate = true;
        btnLoad = false;
      });
    }
  }

  void sendData() {
    if (this.mounted) {
      print(codeCatId);
      setState(() {
        menudata = new Menu(
          menu_id: menu_id,
          ket_id: codeCatId,
          menu: nama.text,
          modal: hargaModal.text,
          harga: harga.text,
          foto: _fileImage,
          picLength: _fileLength,
        );
        // print("product");
        // print(menudata);
      });

      if (widget.type != "edit") {
        print("add product toAddProduct");
        print(menudata.toAddMenu());
        menuPresenter.addMenu(menudata);
      } else {
        print("edit product toEditProduct");
        print(menudata.toEditMenu());
        // menuPresenter.editMenu(menudata);
      }
    }
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            title: Text(
              "Pilih dari :",
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  .copyWith(color: Colors.black, fontSize: 18),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ListTile(
                    dense: true,
                    leading: Icon(Icons.image),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    onTap: () {
                      uploadImage(context, ImageSource.gallery);
                    },
                    title: Text("Galeri",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(fontSize: 12.5, color: Colors.black)),
                  ),
                  ListTile(
                    dense: true,
                    leading: Icon(Icons.camera),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    onTap: () {
                      uploadImage(context, ImageSource.camera);
                    },
                    title: Text("Kamera",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(fontSize: 12.5, color: Colors.black)),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future uploadImage(BuildContext context, ImageSource source) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
    ].request();

    if (statuses[Permission.camera] == PermissionStatus.granted &&
        statuses[Permission.storage] == PermissionStatus.granted) {
      var imageFile = await ImagePicker()
          .getImage(source: source, maxHeight: 480, maxWidth: 640);

      var _image =
          await FlutterExifRotation.rotateAndSaveImage(path: imageFile.path);

      final length = await _image.length();
      setState(() {
        _fileImage = _image;
        _fileLength = length;
      });
      Navigator.of(context).pop();
    } else if (statuses[Permission.camera] != PermissionStatus.granted &&
        statuses[Permission.storage] != PermissionStatus.granted) {
      BaseFunction().displayToast('Akses kamera dan penyimpanan diperlukan');
      Navigator.of(context).pop();
    } else if (statuses[Permission.camera] != PermissionStatus.granted) {
      BaseFunction().displayToast('Akses kamera diperlukan untuk fitur ini');
      Navigator.of(context).pop();
    } else if (statuses[Permission.storage] != PermissionStatus.granted) {
      BaseFunction().displayToast('Akses penyimpanan diperlukan');
      Navigator.of(context).pop();
    }
  }

  void selectCat() async {
    final information = await Navigator.push(
        context,
        CupertinoPageRoute(
            fullscreenDialog: true, builder: (context) => SelectCat()));
    if (information != null && information.toString().isNotEmpty) {
      if (this.mounted) {
        setState(() {
          List data = information.toString().split("@");
          dataSelCatNama = data[0].toString();
          dataSelCatId = data[1].toString();
          codeCatId = new Map();
          codeCatId = dataSelCatId;
          codeCatName.text = data[0];
          jml = 1;
        });
        // // print("data add " + information.toString());
        print(" nama" + dataSelCatNama.toString());
        print(" nama" + dataSelCatId.toString());
        // print("code cat id" + codeCatId.toString());
      }
    }
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
    throw UnimplementedError();
  }

  @override
  onSuccessGetCat(Map data) {
    // TODO: implement onSuccessGetCat
    // throw UnimplementedError();
    // if (this.mounted) {}
  }

  @override
  onFailedAddMenu(Map data) {
    // TODO: implement onFailedAddMenu
    throw UnimplementedError();
  }

  @override
  onSuccessAddMenu(Map data) {
    // TODO: implement onSuccessAddMenu
    // throw UnimplementedError();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MenuMain()));
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
