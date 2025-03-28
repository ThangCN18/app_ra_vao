class User {
  late int id;
  late String ma_nv;
  late String ho_ten;
  late String vi_tri;
  late String bo_phan;
  late String ca_kip;
  late String role;
  late String token;
  late int idVaiTro;
  late int idKho;

  User({
    required this.id,
    required this.ma_nv,
    required this.ho_ten,
    required this.vi_tri,
    required this.bo_phan,
    required this.ca_kip,
    required this.role,
    required this.token,
    required this.idVaiTro,
    required this.idKho,
  });

  // Convert User to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ma_nv': ma_nv,
      'ho_ten': ho_ten,
      'vi_tri': vi_tri,
      'bo_phan': bo_phan,
      'ca_kip': ca_kip,
      'role': role,
      'token': token,
      'idVaiTro': idVaiTro,
      'idKho': idKho,
    };
  }

  // Convert a map to a User object
  static User fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      ma_nv: map['ma_nv'],
      ho_ten: map['ho_ten'],
      vi_tri: map['vi_tri'],
      bo_phan: map['bo_phan'],
      ca_kip: map['ca_kip'],
      role: map['role'],
      token: map['token'],
      idVaiTro: map['idVaiTro'],
      idKho: map['idKho'],
    );
  }
}
