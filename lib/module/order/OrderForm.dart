import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pillar_app/base/BaseView.dart';
import 'package:pillar_app/module/order/SelectMenu.dart';
import 'package:pillar_app/module/order/pettern/OrderPresenter.dart';
import 'package:pillar_app/module/order/pettern/OrderView.dart';
import 'package:pillar_app/module/order/pettern/OrderWidget.dart';

class OrderForm extends StatefulWidget {
  final String type;
  List dataEdit;
  OrderForm({Key key, this.type, this.dataEdit}) : super(key: key);

  @override
  State<OrderForm> createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> with OrderView {
  OrderPresener orderPresener;
  TextEditingController nama = TextEditingController();
  TextEditingController serialCont = TextEditingController();
  TextEditingController partCont = TextEditingController();
  List<TextEditingController> qtycont = [];
  List data_idMenu = List(), data_namaMenu = List(), dataQuan = List();
  bool isLogin = false, isFailed = false, btnLoad = false, autoValidate = false;
  int total = 0;
  final formKey = new GlobalKey<FormState>();

  void selectMenu(String decoded) async {
    var information;
    information = await Navigator.push(
        context,
        CupertinoPageRoute(
            fullscreenDialog: true, builder: (context) => SelectMenu()));

    if (information != null && information.toString().isNotEmpty) {
      if (this.mounted) {
        setState(() {
          List data = information.toString().split("@");
          data_idMenu.add(data[0].toString());
          data_namaMenu.add(data[1].toString());
          dataQuan.add(1);
          total = num.parse(data[2]) + total;
          qtycont.add(TextEditingController());
          for (int i = 0; i < qtycont.length; i++) {
            qtycont[i].text = dataQuan[i].toString();
          }
          if (data_idMenu.length != 0) {
            partCont.text = "ada";
          } else {
            partCont.text = "";
          }
        });
        print("data add" + information.toString());
        print(total.toString());
        print(data_idMenu.toString());
        print(data_namaMenu.toString());
        print(dataQuan.toString());
      }
    }
  }

  void deleteSelectMenu(int index) async {
    setState(() {
      data_idMenu.removeAt(index);
      data_namaMenu.removeAt(index);
      dataQuan.removeAt(index);
      for (int i = 0; i < qtycont.length; i++) {
        qtycont[i].text = dataQuan[i].toString();
      }
    });
  }

  void removeQuantitySelectedSN(int index) async {
    if (this.mounted) {
      int qtyTemp = int.parse(qtycont[index].text);
      setState(() {
        if (qtyTemp > 1) {
          qtyTemp -= 1;
        }
        dataQuan[index] = qtyTemp;
        qtycont[index].text = qtyTemp.toString();
      });
    }
  }

  Widget displayPopUpDelete(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setModalState) {
          return AlertDialog(
            title: new Text("Hapus Menu"),
            content: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Text("Anda ingin menghapus " +
                              data_namaMenu[index].toString() +
                              " ?")),
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Batal"),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
              new FlatButton(
                color: Color(0xffED8811),
                child: new Text(
                  "Hapus",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  deleteSelectMenu(index);
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
      },
    );
  }

  void addQuantitySelectedSN(int index) async {
    if (this.mounted) {
      int qtyTemp = int.parse(qtycont[index].text);
      setState(() {
        qtyTemp += 1;
        dataQuan[index] = qtyTemp;
        qtycont[index].text = qtyTemp.toString();
      });
      // print("data tambah");
      // print(dataSelectedSninId.toString());
      // print(dataSelectedSerial.toString());
      // print(dataSelectedQuantity.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle appBarTextStyle =
        TextStyle(fontSize: 18.0, color: Colors.black87);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.type == "edit" ? "Edit Transaksi Offline" : "Tambah Order"),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: displayForm(
            context,
            formKey,
            nama,
            widget.type,
            selectMenu,
            serialCont,
            data_namaMenu,
            qtycont,
            dataQuan,
            displayPopUpDelete,
            removeQuantitySelectedSN,
            addQuantitySelectedSN),
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        height: 48,
        child: MaterialButton(
          onPressed: () {
            // if (mId == "") {
            //   BaseView()
            //       .displayToastLong("Anda belum memilih (Customer/Cabang)");
            // } else {
            submit();
            // }
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
        //btnLoad = true;
      });
      sendData();
    } else {
      setState(() {
        this.autoValidate = true;
        //btnLoad = false;
      });
    }
  }

  void sendData() {
    if (this.mounted) {
      setState(() {
        // if (widget.type != "edit") {
        //   serial = Serial(
        //     prodcode: dataSelectedSninId,
        //     // prodname: dataSelectedSerial,
        //     qty: dataSelectedQuantity,
        //     mId: mId,
        //     adminId: adminId,
        //     // type: formView == "Customer" ? "customer" : "bo",
        //     // desc: descCont.text,
        //   );
        //   print("data add");
        //   print(serial.prodcode.toString());
        //   // print(serial.prodname.toString());
        //   print(serial.qty.toString());
        //   print(serial.mId);
        //   print(serial.adminId);
        //   // print(serial.type);
        //   print(serial.addSerialNumberOut());
        //   serialOutPresenter.addSerialOut(serial);
        // } else {
        //   serial = Serial(
        //     // sninId: dataSelectedSninId[0].toString(),
        //     // serialnumber: serialCont.text.toString(),
        //     // mId: mId,
        //     adminId: adminId,
        //     snoutId: widget.dataEdit[0]['snId'].toString(),
        //     // desc: descCont.text.toString(),
        //   );
        //   print("data edit");
        //   // print(serial.sninId);
        //   // print(serial.serialnumber);
        //   // print(serial.mId);
        //   print(serial.adminId);
        //   print(serial.snoutId);
        //   print(serial.desc);
        //   serialOutPresenter.editSerialOut(serial);
        // }
      });
    }
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
    throw UnimplementedError();
  }

  @override
  onFaildGetMenu(Map data) {
    // TODO: implement onFaildGetMenu
    throw UnimplementedError();
  }
}
