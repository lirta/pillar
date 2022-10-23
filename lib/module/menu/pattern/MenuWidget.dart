import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pillar_app/module/menu/MenuDetail.dart';
import 'package:pillar_app/module/menu/MenuPhotoDetail.dart';

Widget displayCatList(BuildContext context, dataMenu) {
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
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => MenuDetail(
                                            menuId: dataMenu['menu'][index]
                                                    ['id_menu']
                                                .toString(),
                                          ),
                                      settings:
                                          RouteSettings(name: "Detail Menu")));
                                  print("id menu" +
                                      dataMenu['menu'][index]['id_menu']
                                          .toString());
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
                                                    "https://pillarcaffee.xyz/foto_menu/" +
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

Widget displayMenuForm(
  BuildContext context,
  String kType,
  final formKey,
  // final formKey,
  // Function uploadImage,
  // TextEditingController harga,
  // TextEditingController modal,
  TextEditingController nama,
  TextEditingController hargaModal,
  TextEditingController harga,
  Function selectCat,
  TextEditingController codeCatName,
  int jml,
  Function _showChoiceDialog,
  File _fileImage,
  String oldPicture,
  Function uploadImage,
) {
  return SingleChildScrollView(
    child: Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 12, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                  child: Text("Kategori Menu",
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width - 32,
                      child: InkWell(
                        onTap: () {
                          selectCat();
                        },
                        child: IgnorePointer(
                          ignoring: true,
                          child: TextFormField(
                            textAlign: TextAlign.start,
                            controller: codeCatName,
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            validator: (val) =>
                                codeCatName.text == "" ? "Data Kategori" : null,
                            onSaved: (val) => codeCatName.text = val,
                            decoration: InputDecoration(
                              //labelText: 'Part Number',
                              //  border: InputBorder.none,
                              contentPadding:
                                  new EdgeInsets.only(left: 12, top: 12),
                              fillColor: Color.fromRGBO(241, 241, 241, 1),
                              filled: true,
                              //labelText: "Nama Lengkap",
                              labelStyle: TextStyle(
                                  fontFamily: "Poppins", fontSize: 12),
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
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 12, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                  child: Text("Nama Menu",
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
                ),
                Container(
                  child: TextFormField(
                    textAlign: TextAlign.start,
                    controller: nama,
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    validator: (val) =>
                        nama.text == "" ? "Nama Menu tidak boleh kosong" : null,
                    decoration: InputDecoration(
                      contentPadding: new EdgeInsets.only(left: 12, top: 12),
                      fillColor: Color.fromRGBO(241, 241, 241, 1),
                      // filled: true,
                      labelStyle:
                          TextStyle(fontFamily: "Poppins", fontSize: 12),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12, width: 1),
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
                )
              ],
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 12, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(bottom: 8),
                    child: Text("Modal ",
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 12))),
                Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width - 100,
                      child: TextFormField(
                        textAlign: TextAlign.start,
                        controller: hargaModal,
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.number,
                        maxLines: null,
                        // validator: (val) => serialCont.text == ""
                        //     ? "Data Serial Number tidak boleh kosong"
                        //     : null,
                        // onSaved: (val) => serialCont.text = val,
                        decoration: InputDecoration(
                          //labelText: 'Serial Number',
                          //  border: InputBorder.none,
                          contentPadding:
                              new EdgeInsets.only(left: 12, top: 12),
                          fillColor: Color.fromRGBO(241, 241, 241, 1),
                          // filled: true,
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
                    Text(
                      " . 00",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Text("Harga modal tidak boleh lebih besar dari harga Jual",
                    style: TextStyle(fontSize: 10, fontFamily: "Poppins"))
              ],
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 12, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(bottom: 8),
                    child: Text("Harga Jual *",
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 12))),
                Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width - 100,
                      child: TextFormField(
                        textAlign: TextAlign.start,
                        controller: harga,
                        // keyboardType:TextInputType.number,
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.number,
                        maxLines: null,
                        validator: (val) => harga.text == ""
                            ? "Harga Normal tidak boleh kosong"
                            : null,
                        onSaved: (val) => harga.text = val,
                        decoration: InputDecoration(
                          //labelText: 'Serial Number',
                          //  border: InputBorder.none,
                          contentPadding:
                              new EdgeInsets.only(left: 12, top: 12),
                          // fillColor: Color.fromRGBO(241, 241, 241, 1),
                          fillColor: Colors.white70,
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
                            borderRadius: BorderRadius.circular(8),
                          ),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.black54,
                              )),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide
                                  .none), //                        icon: Icon(Icons.email),
                        ),
                      ),
                    ),
                    Text(
                      " . 00",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          addPic(
              context, uploadImage, _fileImage, oldPicture, _showChoiceDialog)
        ],
      ),
    ),
  );
}

Widget addPic(
  BuildContext context,
  Function uploadImage,
  File _fileImage,
  oldPicture,
  Function _showChoiceDialog,
) {
  return Container(
    padding: EdgeInsets.all(16),
    child: Center(
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () => _showChoiceDialog(context),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: Color.fromARGB(255, 105, 100, 100), width: 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image(
                    image: _fileImage != null
                        ? FileImage(_fileImage)
                        : oldPicture != ""
                            ? CachedNetworkImageProvider(oldPicture)
                            : AssetImage(
                                'assets/images/no_image_available.jpg')),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget getCatList(BuildContext context, List dataCat, Function onRefresh,
    bool isFailed, Function setToForm) {
  return ListView.builder(
    itemCount: dataCat.length,
    itemBuilder: (BuildContext context, int index) {
      return Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: InkWell(
          onTap: () {
            String value = dataCat[index]['nama_ket_menu'] +
                "@" +
                dataCat[index]['id_ket_menu'].toString();
            print(value + "ini vlue");
            setToForm(value);
          },
          child: Container(
            padding: EdgeInsets.all(10),
            child:
                // Text(dataCat[index]['data'][i]['catNama']),
                Text(dataCat[index]['nama_ket_menu']),
          ),
        ),
      );
    },
  );
}

Widget displayPhotoInfoMenu(BuildContext context, List dataDetailMenu) {
  List<String> images = [];

  for (int i = 0; i < dataDetailMenu.length; i++) {
    images.add(dataDetailMenu[0]['foto']);
  }
  print("ini list image " + images.toString());
  return Container(
    color: Colors.white,
    child: InkWell(
      onTap: () {
        if (images.isNotEmpty) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MenuPhotoDetail(images: images)));
        }
      },
      child: Container(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
                Widget>[
          images.length > 1
              ? SizedBox(
                  height: 350,
                  child: Swiper(
                    itemCount: images.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CachedNetworkImage(
                        fit: BoxFit.cover,
                        placeholder: (context, i) {
                          return Image.asset(
                              "assets/images/no_image_available.jpg");
                        },
                        imageUrl: images[index],
                      );
                    },
                    autoplay: true,
                    scrollDirection: Axis.horizontal,
                    pagination: new SwiperPagination(
                        alignment: Alignment.bottomCenter,
                        builder: DotSwiperPaginationBuilder(
                            activeColor: Colors.red, color: Colors.red[100])),
                    control: new SwiperControl(),
                  ),
                )
              : new CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: images.isEmpty
                      ? Image.asset("assets/images/no_image_available.jpg")
                          .toString()
                      : images[0],
                  placeholder: (context, i) {
                    return Image.asset("assets/images/no_image_available.jpg");
                  },
                ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              dataDetailMenu[0]['nama_menu'],
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Harga Modal ",
                    style: TextStyle(color: Colors.black45, fontSize: 13)),
                Text("Rp" + dataDetailMenu[0]['modal'].toString(),
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
              ],
            ),
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Harga Menu ",
                    style: TextStyle(color: Colors.black45, fontSize: 13)),
                Text("Rp " + dataDetailMenu[0]['harga'].toString(),
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
              ],
            ),
          ),
          SizedBox(height: 16),
        ]),
      ),
    ),
  );
}

Widget displayDescMenu(BuildContext context, List dataDetailMenu) {
  return Container(
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            "Informasi Produk",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Berat ",
                  style: TextStyle(color: Colors.black45, fontSize: 13)),
              Text(
                  dataDetailMenu[0]['prodWeight'] != ""
                      ? dataDetailMenu[0]['prodWeight'] + "Kg"
                      : "-",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Jumlah Stok ",
                  style: TextStyle(color: Colors.black45, fontSize: 13)),
              Text(
                  dataDetailMenu[0]['jumlahstock'] != ""
                      ? dataDetailMenu[0]['jumlahstock'].toString() + " Buah"
                      : "0 Buah",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Minimal Order ",
                  style: TextStyle(color: Colors.black45, fontSize: 13)),
              Text(
                  dataDetailMenu[0]['prodMinOrder'] != 0
                      ? dataDetailMenu[0]['prodMinOrder'].toString() + " Buah"
                      : "0 Buah",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
            ],
          ),
          SizedBox(height: 5),
        ],
      ),
    ),
  );
}
