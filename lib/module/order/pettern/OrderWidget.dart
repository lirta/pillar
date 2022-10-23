import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pillar_app/base/BaseView.dart';

class OrderWidget {
  Widget displayOrderLis(BuildContext context, List dataList) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: dataList == null ? 0 : dataList.length,
      itemBuilder: (context, i) {
        return InkWell(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 8, right: 8),
              child: Column(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Orders",
                              style: TextStyle(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                          SizedBox(width: 16),
                          Text(dataList[i]['jam'],
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87)),
                          SizedBox(width: 16),
                          Expanded(
                            child: Container(
                              height: 1.0,
                              color: Colors.black,
                            ),
                          ),
                          // popMenu(context, dataList[i]['orderStatus'],
                          //     dataList[i], access, displayPopUpDeleteOrder),
                        ],
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      // Row(
                      //   mainAxisSize: MainAxisSize.min,
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Expanded(
                      //       child: Row(
                      //         children: [
                      //           Container(
                      //               decoration: BoxDecoration(
                      //                 // color: statusCol,
                      //                 border: Border.all(
                      //                     width: 1.4, color: Colors.white),
                      //                 borderRadius:
                      //                     BorderRadius.all(Radius.circular(6)),
                      //               ),
                      //               child: Padding(
                      //                 padding: const EdgeInsets.all(6.0),
                      //                 child: Text(dataList[i]['nama_pelanggan'],
                      //                     style: TextStyle(
                      //                         fontSize: 11.0,
                      //                         fontWeight: FontWeight.bold,
                      //                         color: Colors.white)),
                      //               )),
                      //           SizedBox(width: 16),
                      //           // Text(dataList[i]['orderSource'],
                      //           //     style: TextStyle(
                      //           //         fontSize: 10.0,
                      //           //         fontWeight: FontWeight.bold,
                      //           //         color: Colors.grey)),
                      //         ],
                      //       ),
                      //     ),
                      //     Row(
                      //       children: [
                      //         Text("Total",
                      //             style: TextStyle(
                      //                 fontSize: 14.0,
                      //                 fontWeight: FontWeight.bold,
                      //                 color: Colors.black87)),
                      //         SizedBox(width: 4),
                      //         Padding(
                      //           padding: const EdgeInsets.all(6.0),
                      //           child: Text(dataList[i]['total'].toString(),
                      //               style: TextStyle(
                      //                   fontSize: 13.0,
                      //                   fontWeight: FontWeight.bold,
                      //                   color: Colors.green)),
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(height: 10),
                      //--------------
                      Text("Data Pemesan",
                          style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey)),
                      SizedBox(height: 6),
                      Text(dataList[i]['tgl'],
                          style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87)),
                      SizedBox(height: 6),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text("Konsumen",
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87)),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Text(dataList[i]['nama_pelanggan'],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87)),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text("Data Menu",
                          style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey)),
                      SizedBox(height: 6),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 16, right: 16, bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                      margin: EdgeInsets.only(left: 5),
                                      child: Text(
                                        "Menu",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87),
                                      )),
                                ),
                                Expanded(
                                  child: Container(
                                      margin: EdgeInsets.only(left: 5),
                                      child: Text(
                                        "Jumlah",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87),
                                      )),
                                ),
                                Expanded(
                                  child: Container(
                                      margin: EdgeInsets.only(left: 5),
                                      child: Text(
                                        "Harga ",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87),
                                      )),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      // SizedBox(height: 6),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: dataList[i]['menu'].length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                                left: 16, right: 16, bottom: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                          margin: EdgeInsets.only(left: 5),
                                          child: Text(
                                            dataList[i]['menu'][index]['nama'],
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black87),
                                          )),
                                    ),
                                    Expanded(
                                      child: Container(
                                          margin: EdgeInsets.only(left: 5),
                                          child: Text(
                                            dataList[i]['menu'][index]['qty']
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black87),
                                          )),
                                    ),
                                    Expanded(
                                      child: Container(
                                          margin: EdgeInsets.only(left: 5),
                                          child: Text(
                                            "Rp " +
                                                dataList[i]['menu'][index]
                                                        ['harga']
                                                    .toString(),
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black87),
                                          )),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text("Total ",
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87)),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Text("Rp " + dataList[i]['total'].toString(),
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87)),
                          ),
                          Expanded(
                            child: Container(
                              height: 1.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget displayForm(
  BuildContext context,
  final formKey,
  TextEditingController nama,
  String type,
  Function selectMenu,
  TextEditingController serialCont,
  List data_namaMenu,
  List<TextEditingController> qtycont,
  List dataQuan,
  Function displayPopUpDelete,
  Function removeQuantitySelectedSN,
  Function addQuantitySelectedSN,
) {
  return SingleChildScrollView(
    child: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    child: Text("Nama Konsumen",
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 12)),
                  ),
                  Container(
                    child: TextFormField(
                      textAlign: TextAlign.start,
                      controller: nama,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      validator: (val) => nama.text == ""
                          ? "Nama Konsumen tidak boleh kosong"
                          : null,
                      decoration: InputDecoration(
                        contentPadding: new EdgeInsets.only(left: 12, top: 12),
                        fillColor: Color.fromRGBO(241, 241, 241, 1),
                        // filled: true,
                        labelStyle:
                            TextStyle(fontFamily: "Poppins", fontSize: 12),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black12, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide
                                .none), //                        icon: Icon(Icons.email),
                      ),
                    ),
                  ),
                  SizedBox(height: 18),
                  Container(
                      margin: EdgeInsets.only(bottom: 8),
                      child: Text("Pilih Menu",
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 12))),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width - 100,
                          child: InkWell(
                            onTap: () {
                              if (type != "edit") {
                                selectMenu("");
                              }
                            },
                            child: IgnorePointer(
                              ignoring: true,
                              child: TextFormField(
                                textAlign: TextAlign.start,
                                controller: serialCont,
                                textCapitalization: TextCapitalization.words,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                // validator: (val) => partCont.text == ""
                                //     ? "Data Kode Produk tidak boleh kosong"
                                //     : null,
                                onSaved: (val) => serialCont.text = val,
                                decoration: InputDecoration(
                                  contentPadding:
                                      new EdgeInsets.only(left: 12, top: 12),
                                  fillColor: Color.fromRGBO(241, 241, 241, 1),
                                  filled: true,
                                  //labelText: "Scan / Pilih Serial Number",
                                  labelStyle: TextStyle(
                                      fontFamily: "Poppins", fontSize: 12),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black12, width: 1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                          color: Colors.transparent)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none),
                                  //                        icon: Icon(Icons.email),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      height: data_namaMenu.length.toString() == "0" ? 0 : 18),
                  data_namaMenu.length.toString() == "0"
                      ? Container()
                      : Text(
                          data_namaMenu.length.toString() +
                              " Produk Telah dipilih",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 12)),
                  SizedBox(height: 18),
                  data_namaMenu.length < 1
                      ? Container()
                      : displaySelectMenu(
                          context,
                          data_namaMenu,
                          qtycont,
                          dataQuan,
                          displayPopUpDelete,
                          removeQuantitySelectedSN,
                          addQuantitySelectedSN)
                ],
              ),
            )
          ],
        )),
  );
}

Widget displaySelectMenu(
  BuildContext context,
  List data_namaMenu,
  List<TextEditingController> qtycont,
  List dataQuan,
  Function displayPopUpDelete,
  Function removeQuantitySelectedSN,
  Function addQuantitySelectedSN,
) {
  return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: data_namaMenu == null ? 0 : data_namaMenu.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: InkWell(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    InkWell(
                        onTap: () {
                          return displayPopUpDelete(index);
                        },
                        child: Icon(
                          Icons.delete,
                          size: 20,
                          color: Colors.red,
                        )),
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(
                            data_namaMenu[index].toString(),
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87),
                          )),
                    ),
                    InkWell(
                        onTap: () {
                          if (dataQuan[index] <= 1) {
                            return displayPopUpDelete(index);
                          } else {
                            removeQuantitySelectedSN(index);
                          }
                        },
                        child: Icon(
                          Icons.remove,
                          size: 20,
                          color: Colors.blue,
                        )),
                    Container(
                      width: 50,
                      height: 25,
                      child: Focus(
                        onFocusChange: (hasFocus) async {
                          if (!hasFocus) {
                            if (qtycont[index].text == "" ||
                                qtycont[index].text == null ||
                                int.parse(qtycont[index].text) < 1) {
                              qtycont[index].text = "1";
                            }
                          }
                        },
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: qtycont[index],
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            // print(value);
                            // if (value == "" ||
                            //     value == null ||
                            //     int.parse(value) < 1) {
                            //   quantitySelectedOnChanged(index, 1);
                            //   // qtycont[index].text = "0";
                            //   // returndisplayPopUpDelete();
                            // } else {
                            //   quantitySelectedOnChanged(
                            //       index, int.parse(value));
                            // }
                          },
                          decoration: InputDecoration(
                            //labelText: 'Serial Number',
                            //  border: InputBorder.none,
                            // contentPadding:
                            //     new EdgeInsets.only(left: 12, top: 12),
                            fillColor: Color.fromRGBO(241, 241, 241, 1),
                            filled: true,
                            // suffixIcon: Padding(
                            //   padding: const EdgeInsets.only(top: 15.0),
                            //   child: InkWell(
                            //       onTap: () {
                            //         selectSerial();
                            //       },
                            //       child: Text(
                            //         "Cari",
                            //         style: TextStyle(fontSize: 14, color: Colors.red[400], fontWeight: FontWeight.bold),
                            //       )),
                            // ),
                            //labelText: "Nama Lengkap",
                            labelStyle:
                                TextStyle(fontFamily: "Poppins", fontSize: 12),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black12, width: 1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                )),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide
                                    .none), //                        icon: Icon(Icons.email),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          addQuantitySelectedSN(index);
                        },
                        child: Icon(
                          Icons.add,
                          size: 20,
                          color: Colors.blue,
                        )),
                  ],
                )
              ],
            ),
          ),
        );
      });
}

Widget displayCatList(BuildContext context, dataMenu, Function setMenu) {
  print(dataMenu['menu']);
  return dataMenu['menu'] == null
      ? Center(
          child: CircularProgressIndicator(),
        )
      : dataMenu['menu'].length > 0
          ? ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: dataMenu['menu'] == null ? 0 : dataMenu['menu'].length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            child: Material(
                              type: MaterialType.card,
                              elevation: 2,
                              child: InkWell(
                                onTap: () {
                                  String value = dataMenu['menu'][index]
                                              ['id_menu']
                                          .toString() +
                                      "@" +
                                      dataMenu['menu'][index]['menu'] +
                                      "@" +
                                      dataMenu['menu'][index]['harga']
                                          .toString();
                                  print(value.toString());
                                  setMenu(value);
                                },
                                child: Container(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            FittedBox(
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    left: 10, right: 10),
                                                width: 150,
                                                height: 150,
                                                child: Image.network(
                                                    "http://10.0.2.2:8000/foto_menu/" +
                                                        dataMenu['menu'][index]
                                                            ['foto']),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                dataMenu['menu'][index]['menu']
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(height: 5),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text("Harga",
                                                      style: TextStyle(
                                                          color: Colors.black45,
                                                          fontSize: 13)),
                                                  Text(
                                                      "Rp " +
                                                          dataMenu['menu']
                                                                      [index]
                                                                  ['harga']
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13))
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Text(dataMenu['menu']),
            );
}
