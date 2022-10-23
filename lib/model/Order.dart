import 'dart:convert';

class Order {
  var idOrder;
  var konsumen;
  var kariawan;
  var idMenu;
  var qty;
  var harga;

  Order(
      {this.idOrder,
      this.konsumen,
      this.kariawan,
      this.idMenu,
      this.qty,
      this.harga});

  Map<String, String> toAddOrder() {
    var map = Map<String, String>();
    map['konsumen'] = konsumen;
    // map['total'] = total;
    map['idMenu'] = jsonEncode(idMenu);
    map['qty'] = jsonEncode(qty);
    map['harga'] = jsonEncode(harga);
    return map;
  }
}
