class User {
  String id;
  String nama;
  String hp;
  String akses;
  String foto;
  User({this.id, this.nama, this.hp, this.akses, this.foto});
  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
      id: json['id_kariawan'].toString(),
      nama: json['nama'].toString(),
      hp: json['hp'].toString(),
      akses: json['id_kariawan'].toString(),
      foto: json['foto'].toString(),
    );
  }
}
