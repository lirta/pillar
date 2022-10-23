// import 'dart:html';
import 'dart:convert';
import 'dart:io';

class Menu {
  var menu_id;
  var ket_id;
  var menu;
  var modal;
  var harga;
  File foto;
  int picLength;
  Menu(
      {this.menu_id,
      this.ket_id,
      this.menu,
      this.modal,
      this.harga,
      this.foto,
      this.picLength});

  factory Menu.fromJson(Map<dynamic, dynamic> json) {
    return Menu(
      menu_id: json['id_item_menu'].toString(),
      ket_id: json['id_ket_menu'].toString(),
      menu: json['nama_menu'],
      modal: json['modal'].toString(),
      harga: json['harga'].toString(),
    );
  }

  Map toAddMenu() {
    var map = new Map<String, String>();
    map['ket_id'] = ket_id;
    map['menu'] = menu;
    map['modal'] = modal;
    map['harga'] = harga;
    return map;
  }

  Map<String, String> toEditMenu() {
    var map = new Map<String, String>();
    map['menu_id'] = menu_id;
    map['ket_id'] = ket_id;
    map['menu'] = menu;
    map['modal'] = modal;
    map['harga'] = harga;
    return map;
  }
}
